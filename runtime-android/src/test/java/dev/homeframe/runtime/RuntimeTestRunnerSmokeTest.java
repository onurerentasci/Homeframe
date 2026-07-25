package dev.homeframe.runtime;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

final class RuntimeTestRunnerSmokeTest {
    @Test
    void gradleRunsTestsOnJava17() {
        assertEquals(17, Runtime.version().feature());
    }
}
