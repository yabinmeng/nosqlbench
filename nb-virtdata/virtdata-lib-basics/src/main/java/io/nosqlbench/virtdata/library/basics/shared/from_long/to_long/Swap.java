/*
 * Copyright (c) 2022 nosqlbench
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

package io.nosqlbench.virtdata.library.basics.shared.from_long.to_long;

import io.nosqlbench.virtdata.api.annotations.Categories;
import io.nosqlbench.virtdata.api.annotations.Category;
import io.nosqlbench.virtdata.api.annotations.Example;
import io.nosqlbench.virtdata.api.annotations.ThreadSafeMapper;
import io.nosqlbench.virtdata.library.basics.core.threadstate.SharedState;

import java.util.HashMap;
import java.util.function.LongFunction;
import java.util.function.LongUnaryOperator;

@ThreadSafeMapper
@Categories({Category.state})
public class Swap implements LongUnaryOperator {

    private final String name;
    private final LongFunction<String> nameGen;
    private final long defaultValue;

    @Example({"Swap('foo')","for the current thread, swap the input value with the named variable and returned the named variable."})
    public Swap(String name) {
        this.name = name;
        this.nameGen=null;
        this.defaultValue=0L;
    }

    @Example({"Swap('foo',234L)","for the current thread, swap the input value with the named variable and returned the named variable" +
            ",or the default value if the named variable is not defined."})
    public Swap(String name, long defaultValue) {
        this.name = name;
        this.nameGen=null;
        this.defaultValue=defaultValue;
    }

    @Example({"Swap(NumberNameToString())","for the current thread, swap the input value with the named variable and returned the named variable" +
            ", where the variable name is generated by the provided function."})
    public Swap(LongFunction<String> nameFunc) {
        this.name=null;
        this.nameGen=nameFunc;
        defaultValue=0L;
    }

    @Example({"Swap(NumberNameToString(), 234L)","for the current thread, swap the input value with the named variable and returned the named variable" +
            ", where the variable name is generated by the provided function" +
            ", or the default value if the named variable is not defined."})
    public Swap(LongFunction<String> nameFunc, long defaultValue) {
        this.name=null;
        this.nameGen=nameFunc;
        this.defaultValue=defaultValue;
    }

    @Override
    public long applyAsLong(long input) {
        HashMap<String, Object> map = SharedState.tl_ObjectMap.get();
        String varname=(nameGen!=null) ? nameGen.apply(input) : name;

        long output = map.containsKey(varname) ? (long) map.get(varname) : defaultValue;
        map.put(varname,input);

        return output;
    }
}