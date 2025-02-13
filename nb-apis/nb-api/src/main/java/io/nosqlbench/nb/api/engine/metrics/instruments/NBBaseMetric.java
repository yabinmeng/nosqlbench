/*
 * Copyright (c) nosqlbench
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

package io.nosqlbench.nb.api.engine.metrics.instruments;

import io.nosqlbench.nb.api.labels.NBLabels;

public class NBBaseMetric implements NBMetric {
    private final NBLabels labels;
    private String description;
    private MetricCategory[] categories;

    public NBBaseMetric(NBLabels labels, String description, MetricCategory... categories) {
        this.labels = labels;
        this.description = description;
        this.categories = categories;
    }
    @Override
    public NBLabels getLabels() {
        return this.labels;
    }

    @Override
    public String typeName() {
        return "basetype";
    }

    @Override
    public String getDescription() {
        return this.description;
    }

    @Override
    public MetricCategory[] getCategories() {
        return this.categories;
    }
}
