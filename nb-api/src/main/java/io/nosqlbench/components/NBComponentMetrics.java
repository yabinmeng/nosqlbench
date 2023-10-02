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

package io.nosqlbench.components;

import io.nosqlbench.api.engine.metrics.instruments.NBMetric;

import java.util.List;
import java.util.Optional;

public interface NBComponentMetrics {
    String addMetric(NBMetric metric);

    /**
     * If you have the serialized open metrics name of a metric, you can ask for it
     * this way and get a direct result.
     * @param name The name of a metric in {@code {a:"b",...}} form
     * @return the metric or null if it dosen't exist
     */
    NBMetric lookupMetric(String name);

    default Optional<NBMetric> lookupMetricOptionally(String name) {
        return Optional.ofNullable(lookupMetric(name));
    }

    List<NBMetric> findMetrics(String pattern);

    default NBMetric findOneMetric(String pattern) {
        List<NBMetric> found = findMetrics(pattern);
        if (found.size()!=1) {
            throw new RuntimeException("Found " + found.size() + " metrics with pattern '" + pattern + "', expected exactly 1");
        }
        return found.get(0);
    }

}
