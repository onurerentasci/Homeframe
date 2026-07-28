package dev.homeframe.runtime;

import android.content.Context;
import android.os.SystemClock;
import android.widget.RemoteViews;

public final class HomeframeRemoteViewsFactory {
    private HomeframeRemoteViewsFactory() {}

    public static RemoteViews create(Context context, String title, long endAtEpochMillis) {
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.homeframe_widget);
        long remainingMillis = Math.max(0L, endAtEpochMillis - System.currentTimeMillis());
        long elapsedRealtimeBase = SystemClock.elapsedRealtime() + remainingMillis;
        String accessibleTitle =
                title == null || title.trim().isEmpty() ? "Homeframe countdown" : title.trim();

        views.setTextViewText(R.id.title, accessibleTitle);
        views.setChronometer(R.id.countdown, elapsedRealtimeBase, null, true);
        views.setChronometerCountDown(R.id.countdown, true);
        return views;
    }
}
