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

package io.nosqlbench.virtdata.library.basics.shared.conversions.from_double;

import org.junit.jupiter.api.Test;

import java.util.function.DoubleFunction;
import java.util.function.DoubleUnaryOperator;
import java.util.function.Function;

import static org.assertj.core.api.Assertions.assertThat;

public class ToStringTest {

    @Test
    public void TestNoFunc() {
        io.nosqlbench.virtdata.library.basics.shared.conversions.from_long.ToString f = new io.nosqlbench.virtdata.library.basics.shared.conversions.from_long.ToString();
        assertThat(f.apply(1L)).isEqualTo("1");
    }

    @Test
    public void TestDoubleUnaryOp() {
        io.nosqlbench.virtdata.library.basics.shared.conversions.from_double.ToString f = new io.nosqlbench.virtdata.library.basics.shared.conversions.from_double.ToString(new DoubleUnaryOperator() {
            @Override
            public double applyAsDouble(double operand) {
                return operand;
            }
        });
        assertThat(f.apply(2L)).isEqualTo("2.0");
    }

    @Test
    public void TestDoubleFunction() {
        io.nosqlbench.virtdata.library.basics.shared.conversions.from_double.ToString f = new io.nosqlbench.virtdata.library.basics.shared.conversions.from_double.ToString(new DoubleFunction<Double>() {

            @Override
            public Double apply(double value) {
                return value;
            }
        });
        assertThat(f.apply(3L)).isEqualTo("3.0");
    }

    @Test
    public void TestFunctionDoubleDouble() {
        io.nosqlbench.virtdata.library.basics.shared.conversions.from_double.ToString f = new io.nosqlbench.virtdata.library.basics.shared.conversions.from_double.ToString(new Function<Double,Double>() {

            @Override
            public Double apply(Double aDouble) {
                return aDouble;
            }
        });
        assertThat(f.apply(4L)).isEqualTo("4.0");
    }


}
