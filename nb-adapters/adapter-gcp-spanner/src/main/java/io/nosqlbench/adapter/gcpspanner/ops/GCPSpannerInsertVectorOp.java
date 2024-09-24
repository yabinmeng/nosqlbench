/*
 * Copyright (c) 2024 nosqlbench
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
 *
 */

package io.nosqlbench.adapter.gcpspanner.ops;

import com.google.cloud.spanner.Spanner;
import com.google.cloud.spanner.DatabaseClient;
import com.google.cloud.spanner.Mutation;

import java.util.Collections;

public class GCPSpannerInsertVectorOp extends GCPSpannerBaseOp<Long> {
    private final Mutation mutation;
    private final DatabaseClient dbClient;

    public GCPSpannerInsertVectorOp(Spanner searchIndexClient, Long requestParam, Mutation mutation, DatabaseClient dbClient) {
        super(searchIndexClient, requestParam);
        this.mutation = mutation;
        this.dbClient = dbClient;
    }

    @Override
    public Object applyOp(long value) {
        return dbClient.write(Collections.singletonList(mutation));
    }
}
