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

package io.nosqlbench.engine.core.lifecycle.scenario.container;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.io.Writer;

final class FanWriter extends Writer {
    private final Writer[] writers;

    public FanWriter(Writer... writers) {
        this.writers = writers;
    }

    @Override
    public void write(char @NotNull [] cbuf, int off, int len) throws IOException {
        for (Writer writer : writers) {
            writer.write(cbuf, off, len);
            writer.flush();
        }

    }

    @Override
    public void flush() throws IOException {
        for (Writer writer : writers) {
            writer.flush();
        }
    }

    @Override
    public void close() throws IOException {
        for (Writer writer : writers) {
            writer.close();
        }

    }
}
