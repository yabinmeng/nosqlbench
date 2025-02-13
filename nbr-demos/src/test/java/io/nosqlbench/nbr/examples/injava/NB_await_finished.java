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

package io.nosqlbench.nbr.examples.injava;

import io.nosqlbench.engine.core.lifecycle.scenario.container.ContainerActivitiesController;
import io.nosqlbench.engine.core.lifecycle.scenario.container.NBBufferedContainer;
import io.nosqlbench.engine.core.lifecycle.scenario.container.NBCommandParams;
import io.nosqlbench.engine.core.lifecycle.scenario.execution.NBBaseCommand;
import org.jetbrains.annotations.NotNull;


import java.io.PrintWriter;
import java.io.Reader;
import java.util.Map;

public class NB_await_finished extends NBBaseCommand {
    public NB_await_finished(NBBufferedContainer parentComponent, String scenarioName) {
        super(parentComponent, scenarioName);
    }

    /**
     * <pre>{@code
     * activitydef1 = {
     *     "alias" : "activity_to_await",
     *     "driver" : "diag",
     *     "cycles" : "0..1500",
     *     "threads" : "1",
     *     "targetrate" : "500",
     *     "op" : "noop"
     * };
     *
     * print('starting activity teststartstopdiag');
     * scenario.start(activitydef1);
     * scenario.awaitActivity("activity_to_await");
     * print("awaited activity");
     * }</pre>
     */
    @Override
    public Object invoke(NBCommandParams params, PrintWriter stdout, PrintWriter stderr, Reader stdin, ContainerActivitiesController controller) {
        Map<String, String> activitydef1 = Map.of(
            "alias", "activity_to_await", "driver", "diag", "cycles", "0..1500", "threads", "1",
            "targetrate", "500", "op", "noop"
        );
        stdout.println("starting activity activity_to_await");
        controller.start(activitydef1);
        controller.awaitActivity("activity_to_await",1000L);
        stdout.println("awaited activity");
        return null;
    }
}
