/*
 * Copyright (c) 2020-2024 nosqlbench
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

package io.nosqlbench.adapter.qdrant.opdispensers;

import io.nosqlbench.adapter.qdrant.QdrantDriverAdapter;
import io.nosqlbench.adapter.qdrant.ops.QdrantBaseOp;
import io.nosqlbench.adapter.qdrant.ops.QdrantListSnapshotsOp;
import io.nosqlbench.adapters.api.templating.ParsedOp;
import io.qdrant.client.QdrantClient;
import io.qdrant.client.grpc.SnapshotsService.ListSnapshotsRequest;

import java.util.function.LongFunction;

public class QdrantListSnapshotsOpDispenser extends QdrantBaseOpDispenser<ListSnapshotsRequest> {
    public QdrantListSnapshotsOpDispenser(QdrantDriverAdapter adapter, ParsedOp op, LongFunction<String> targetFunction) {
        super(adapter, op, targetFunction);
    }

    @Override
    public LongFunction<ListSnapshotsRequest> getParamFunc(LongFunction<QdrantClient> clientF,
                                                           ParsedOp op, LongFunction<String> targetF) {
        LongFunction<ListSnapshotsRequest.Builder> ebF =
            l -> ListSnapshotsRequest.newBuilder().setCollectionName(targetF.apply(l));

        final LongFunction<ListSnapshotsRequest.Builder> lastF = ebF;
        return l -> lastF.apply(l).build();
    }

    @Override
    public LongFunction<QdrantBaseOp<ListSnapshotsRequest>> createOpFunc(LongFunction<ListSnapshotsRequest> paramF,
                                                                         LongFunction<QdrantClient> clientF,
                                                                         ParsedOp op, LongFunction<String> targetF) {
        return l -> new QdrantListSnapshotsOp(clientF.apply(l), paramF.apply(l));
    }
}
