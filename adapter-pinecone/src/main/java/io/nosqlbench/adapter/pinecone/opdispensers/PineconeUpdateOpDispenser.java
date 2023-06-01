/*
 * Copyright (c) 2023 nosqlbench
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.nosqlbench.adapter.pinecone.opdispensers;

import com.google.protobuf.Struct;
import com.google.protobuf.Value;
import io.nosqlbench.adapter.pinecone.PineconeDriverAdapter;
import io.nosqlbench.adapter.pinecone.PineconeSpace;
import io.nosqlbench.adapter.pinecone.ops.PineconeOp;
import io.nosqlbench.adapter.pinecone.ops.PineconeUpdateOp;
import io.nosqlbench.engine.api.templating.ParsedOp;
import io.pinecone.proto.SparseValues;
import io.pinecone.proto.UpdateRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.*;
import java.util.function.BiConsumer;
import java.util.function.LongFunction;

public class PineconeUpdateOpDispenser extends PineconeOpDispenser {
    private static final Logger logger = LogManager.getLogger(PineconeUpdateOpDispenser.class);
    private final LongFunction<UpdateRequest.Builder> updateRequestFunc;
    private final LongFunction<Struct> updateMetadataFunc;
    private final LongFunction<SparseValues> sparseValuesFunc;

    /**
     * Create a new PineconeUpdateOpDispenser subclassed from {@link PineconeOpDispenser}.
     *
     * @param adapter           The associated {@link PineconeDriverAdapter}
     * @param op                The {@link ParsedOp} encapsulating the activity for this cycle
     * @param pcFunction        A function to return the associated context of this activity (see {@link PineconeSpace})
     * @param targetFunction    A LongFunction that returns the specified Pinecone Index for this Op
     */
    public PineconeUpdateOpDispenser(PineconeDriverAdapter adapter,
                                     ParsedOp op,
                                     LongFunction<PineconeSpace> pcFunction,
                                     LongFunction<String> targetFunction) {
        super(adapter, op, pcFunction, targetFunction);
        updateRequestFunc = createUpdateRequestFunction(op);
        updateMetadataFunc = createUpdateMetadataFunction(op);
        sparseValuesFunc = createSparseValuesFunction(op);
    }

    /**
     * @param op the ParsedOp from which the SparseValues object will be built
     * @return a SparseValues Object to be added to a Pinecone UpdateRequest
     * <p>
     * This method interrogates the subsection of the ParsedOp defined for SparseValues parameters and constructs
     * a SparseValues Object based on the included values, or returns null if this section is not populated. The
     * base function returns either the SparseValues Object or null, while the interior function builds the SparseValues
     * with a Builder pattern based on the values contained in the source ParsedOp.
     */
    private LongFunction<SparseValues> createSparseValuesFunction(ParsedOp op) {
        Optional<LongFunction<Map>> mFunc = op.getAsOptionalFunction("sparse_values", Map.class);
        return mFunc.<LongFunction<SparseValues>>map(mapLongFunction -> l -> {
            Map<String, String> sparse_values_map = mapLongFunction.apply(l);
            String[] rawValues = (sparse_values_map.get("values")).split(",");
            ArrayList floatValues = new ArrayList<>();
            for (String val : rawValues) {
                floatValues.add(Float.valueOf(val));
            }
            rawValues = sparse_values_map.get("indices").split(",");
            List<Integer> intValues = new ArrayList<>();
            for (String val : rawValues) {
                intValues.add(Integer.valueOf(val));
            }
            return SparseValues.newBuilder()
                .addAllValues(floatValues)
                .addAllIndices(intValues)
                .build();
        }).orElse(null);
    }

    /**
     * @param op the ParsedOp from which the Metadata objects will be built
     * @return a Metadata Struct to be added to a Pinecone UpdateRequest
     * <p>
     * This method interrogates the subsection of the ParsedOp defined for metadata parameters and constructs
     * a Metadata Struct based on the included values, or returns null if this section is not populated. The
     * base function returns either the Metadata Struct or null, while the interior function builds the Metadata
     * with a Builder pattern based on the values contained in the source ParsedOp.
     */
    private LongFunction<Struct> createUpdateMetadataFunction(ParsedOp op) {
        Optional<LongFunction<Map>> mFunc = op.getAsOptionalFunction("metadata", Map.class);
        return mFunc.<LongFunction<Struct>>map(mapLongFunction -> l -> {
            Map<String, Value> metadata_map = new HashMap<String,Value>();
            BiConsumer<String,Object> stringToValue = (key, val) -> {
                Value targetval = null;
                if (val instanceof String) targetval = Value.newBuilder().setStringValue((String)val).build();
                else if (val instanceof Number) targetval = Value.newBuilder().setNumberValue((((Number) val).doubleValue())).build();
                metadata_map.put(key, targetval);
            };
            Map<String, Object> metadata_values_map = mapLongFunction.apply(l);
            metadata_values_map.forEach(stringToValue);
            return UpdateRequest.newBuilder().getSetMetadataBuilder().putAllFields(metadata_map).build();
        }).orElse(null);
    }

    /**
     * @param op The ParsedOp used to build the Request
     * @return A function that will take a long (the current cycle) and return a Pinecone UpdateRequest Builder
     * <p>
     * The pattern used here is to accommodate the way Request types are constructed for Pinecone.
     * Requests use a Builder pattern, so at time of instantiation the methods should be chained together.
     * For each method in the chain a function is created here and added to the chain of functions
     * called at time of instantiation.
     * <p>
     * The Metadata and SparseValues objects used by the UpdateRequest are sufficiently sophisticated in their own
     * building process that they have been broken out into separate methods. At runtime, they are built separately
     * and then added to the build chain by the builder returned by this method.
     */
    private LongFunction<UpdateRequest.Builder> createUpdateRequestFunction(ParsedOp op) {
        LongFunction<UpdateRequest.Builder> rFunc = l -> UpdateRequest.newBuilder();

        Optional<LongFunction<String>> nFunc = op.getAsOptionalFunction("namespace", String.class);
        if (nFunc.isPresent()) {
            LongFunction<UpdateRequest.Builder> finalFunc = rFunc;
            LongFunction<String> af = nFunc.get();
            rFunc = l -> finalFunc.apply(l).setNamespace(af.apply(l));
        }

        Optional<LongFunction<String>> iFunc = op.getAsOptionalFunction("id", String.class);
        if (iFunc.isPresent()) {
            LongFunction<UpdateRequest.Builder> finalFunc = rFunc;
            LongFunction<String> af = iFunc.get();
            rFunc = l -> finalFunc.apply(l).setId(af.apply(l));
        }

        Optional<LongFunction<String>> vFunc = op.getAsOptionalFunction("values", String.class);
        if (vFunc.isPresent()) {
            LongFunction<UpdateRequest.Builder> finalFunc = rFunc;
            LongFunction<String> af = vFunc.get();
            LongFunction<ArrayList<Float>> alf = extractFloatVals(af);
            rFunc = l -> finalFunc.apply(l).addAllValues(alf.apply(l));
        }

        return rFunc;
    }

    @Override
    public PineconeOp apply(long value) {
        UpdateRequest.Builder urb = updateRequestFunc.apply(value);
        if (updateMetadataFunc != null) {
            urb.setSetMetadata(updateMetadataFunc.apply(value));
        }
        if (sparseValuesFunc != null) {
            urb.setSparseValues(sparseValuesFunc.apply(value));
        }
        return new PineconeUpdateOp(pcFunction.apply(value).getConnection(targetFunction.apply(value)), urb.build());
    }
}
