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

import java.io.PrintWriter;
import java.io.Reader;


public class NB_cycle_rate_change extends NBBaseCommand {
    public NB_cycle_rate_change(NBBufferedContainer parentComponent, String scenarioName) {
        super(parentComponent, scenarioName);
    }

    /** <pre>{@code
     * activitydef = {
     *     "alias" : "cycle_rate_change",
     *     "driver" : "diag",
     *     "cycles" : "0..1000000",
     *     "threads" : "10",
     *     "cyclerate" : "2000",
     *     "interval" : "2000",
     *     "op" : "noop"
     * };
     *
     * print('starting cycle_rate_change');
     * scenario.start(activitydef);
     * print('started');
     * print('cyclerate at 0ms:' + activities.cycle_rate_change.cyclerate);
     * scenario.waitMillis(500);
     * activities.cycle_rate_change.cyclerate='1000';
     * print("measured cycle increment per second is expected to adjust to 1000");
     *
     * print('cyclerate now:' + activities.cycle_rate_change.cyclerate);
     *
     * var lastcount=metrics.cycle_rate_change.cycles_servicetime.count;
     * for(i=0;i<20;i++) {
     *     scenario.waitMillis(1000);
     *     var nextcount=metrics.cycle_rate_change.cycles_servicetime.count;
     *     var cycles = (nextcount - lastcount);
     *     print("new this second: " + (nextcount - lastcount));
     *     print(" waittime: " + metrics.cycle_rate_change.cycles_waittime.value);
     *     lastcount=nextcount;
     *     if (cycles>700 && cycles<1300) {
     *         print("cycles adjusted, exiting on iteration " + i);
     *         break;
     *     }
     * }
     * scenario.stop(activitydef);
     * print('cycle_rate_change activity finished');
     * }</pre>
     */
    @Override
    public Object invoke(NBCommandParams params, PrintWriter stdout, PrintWriter stderr, Reader stdin, ContainerActivitiesController controller) {
        return null;
    }
}
