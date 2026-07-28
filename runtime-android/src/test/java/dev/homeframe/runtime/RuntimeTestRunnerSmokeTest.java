package dev.homeframe.runtime;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public final class RuntimeTestRunnerSmokeTest {
    @Test
    public void gradleRunsTestsOnJava17() {
        assertTrue(System.getProperty("java.version").startsWith("17"));
    }
}
