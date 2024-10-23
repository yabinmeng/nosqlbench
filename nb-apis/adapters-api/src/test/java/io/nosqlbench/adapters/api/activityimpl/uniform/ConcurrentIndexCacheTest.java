package io.nosqlbench.adapters.api.activityimpl.uniform;

/*
 * Copyright (c) 2022 nosqlbench
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class ConcurrentIndexCacheTest {
    @Test
    public void testBasicCache() {
        ConcurrentIndexCache<String> sc = new ConcurrentIndexCache<>(l -> String.valueOf(l));
        String s = sc.get(300);
        assertThat(s).isEqualTo("300");
    }

}
