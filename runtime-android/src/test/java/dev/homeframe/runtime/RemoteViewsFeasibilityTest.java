package dev.homeframe.runtime;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import android.content.Context;
import android.view.View;
import android.widget.Chronometer;
import android.widget.FrameLayout;
import android.widget.RemoteViews;
import android.widget.TextView;
import androidx.test.core.app.ApplicationProvider;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.annotation.Config;

@RunWith(RobolectricTestRunner.class)
@Config(sdk = 35)
public final class RemoteViewsFeasibilityTest {
    @Test
    public void hfS11T01GroupsTitleWithNativeCountdownAccessibility() {
        Context context = ApplicationProvider.getApplicationContext();
        long endAtEpochMillis = System.currentTimeMillis() + 60_000L;
        RemoteViews remoteViews =
                HomeframeRemoteViewsFactory.create(context, "S1 feasibility", endAtEpochMillis);

        View root = remoteViews.apply(context, new FrameLayout(context));
        TextView title = root.findViewById(R.id.title);
        Chronometer countdown = root.findViewById(R.id.countdown);

        assertNotNull(title);
        assertNotNull(countdown);
        assertEquals(R.id.homeframe_root, root.getId());
        assertEquals("S1 feasibility", title.getText().toString());
        assertTrue(root.isScreenReaderFocusable());
        assertNull(root.getContentDescription());
        assertNull(title.getContentDescription());
        assertTrue(countdown.getContentDescription().toString().contains("second"));
        assertTrue(countdown.isCountDown());
    }

    @Test
    public void hfS11T02NativeCountdownDescribesHoursMinutesAndSeconds() {
        Chronometer countdown = createCountdown(2 * 3_600_000L + 3 * 60_000L + 4_000L);
        String description = countdown.getContentDescription().toString();

        assertTrue(description.contains("hour"));
        assertTrue(description.contains("minute"));
        assertTrue(description.contains("second"));
    }

    @Test
    public void hfS11T03NativeCountdownDescribesDurationsBeyondOneDay() {
        Chronometer countdown = createCountdown(49 * 3_600_000L + 2 * 60_000L + 3_000L);
        String description = countdown.getContentDescription().toString();

        assertTrue(description.contains("hour") || description.contains("day"));
        assertTrue(description.contains("minute"));
        assertTrue(description.contains("second"));
    }

    @Test
    public void hfS11T04BlankTitleUsesSafeFallback() {
        Context context = ApplicationProvider.getApplicationContext();
        RemoteViews remoteViews =
                HomeframeRemoteViewsFactory.create(
                        context, " \t", System.currentTimeMillis() + 60_000L);
        View root = remoteViews.apply(context, new FrameLayout(context));
        TextView title = root.findViewById(R.id.title);

        assertEquals("Homeframe countdown", title.getText().toString());
    }

    @Test
    public void hfS11T07TwoInstancesKeepIndependentAccessibilitySemantics() {
        Context context = ApplicationProvider.getApplicationContext();
        long now = System.currentTimeMillis();
        View first =
                HomeframeRemoteViewsFactory.create(context, "Instance A", now + 60_000L)
                        .apply(context, new FrameLayout(context));
        View second =
                HomeframeRemoteViewsFactory.create(context, "Instance B", now + 120_000L)
                        .apply(context, new FrameLayout(context));
        TextView firstTitle = first.findViewById(R.id.title);
        TextView secondTitle = second.findViewById(R.id.title);
        Chronometer firstCountdown = first.findViewById(R.id.countdown);
        Chronometer secondCountdown = second.findViewById(R.id.countdown);

        assertEquals("Instance A", firstTitle.getText().toString());
        assertEquals("Instance B", secondTitle.getText().toString());
        assertTrue(
                !firstCountdown
                        .getContentDescription()
                        .toString()
                        .equals(secondCountdown.getContentDescription().toString()));
    }

    private static Chronometer createCountdown(long remainingMillis) {
        Context context = ApplicationProvider.getApplicationContext();
        RemoteViews remoteViews =
                HomeframeRemoteViewsFactory.create(
                        context, "S1 feasibility", System.currentTimeMillis() + remainingMillis);
        View root = remoteViews.apply(context, new FrameLayout(context));
        return root.findViewById(R.id.countdown);
    }
}
