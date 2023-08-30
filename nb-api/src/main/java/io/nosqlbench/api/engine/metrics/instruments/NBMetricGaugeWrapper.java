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

package io.nosqlbench.api.engine.metrics.instruments;

import com.codahale.metrics.Gauge;
import io.nosqlbench.api.config.NBLabels;

public class NBMetricGaugeWrapper<T> implements NBMetricGauge<T> {

    private final Gauge<? extends T> gauge;
    private final NBLabels labels;

    public NBMetricGaugeWrapper(NBLabels labels, Gauge<? extends T> gauge) {
        this.gauge = gauge;
        this.labels = labels;
    }

    @Override
    public T getValue() {
        return gauge.getValue();
    }

    @Override
    public NBLabels getLabels() {
        return labels;
    }
}