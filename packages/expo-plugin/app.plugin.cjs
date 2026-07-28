const { AndroidConfig, withAndroidManifest, withDangerousMod } = require("@expo/config-plugins");
const fs = require("node:fs");
const path = require("node:path");

const PROVIDER_CLASS = "dev.homeframe.basic.widget.HomeframeWidgetProvider";

const generatedFiles = {
  "app/src/main/java/dev/homeframe/basic/widget/HomeframeWidgetProvider.java": `package dev.homeframe.basic.widget;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.SystemClock;
import android.widget.RemoteViews;
import dev.homeframe.basic.R;
import java.util.Arrays;

public final class HomeframeWidgetProvider extends AppWidgetProvider {
    private static final String ACTION_REFRESH = "dev.homeframe.action.REFRESH_WIDGET";
    private static final String ACTION_RENDER_STATIC_TEST =
            "dev.homeframe.action.RENDER_STATIC_TEST";
    private static final String PREFERENCES = "homeframe_s1";

    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);
        String action = intent.getAction();
        if (ACTION_RENDER_STATIC_TEST.equals(action)) {
            updateAll(context, false);
        } else if (ACTION_REFRESH.equals(action) || Intent.ACTION_BOOT_COMPLETED.equals(action)) {
            updateAll(context, true);
        }
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager manager, int[] appWidgetIds) {
        render(context, manager, appWidgetIds, true);
    }

    public static void refresh(Context context) {
        updateAll(context, true);
    }

    private static void updateAll(Context context, boolean running) {
        AppWidgetManager manager = AppWidgetManager.getInstance(context);
        int[] ids = manager.getAppWidgetIds(
                new android.content.ComponentName(context, HomeframeWidgetProvider.class));
        render(context, manager, ids, running);
    }

    private static void render(
            Context context, AppWidgetManager manager, int[] widgetIds, boolean running) {
        int[] sortedIds = Arrays.copyOf(widgetIds, widgetIds.length);
        Arrays.sort(sortedIds);
        SharedPreferences preferences =
                context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE);

        for (int index = 0; index < sortedIds.length; index += 1) {
            int widgetId = sortedIds[index];
            String endAtKey = "endAt." + widgetId;
            long endAt = preferences.getLong(endAtKey, 0L);
            if (endAt == 0L) {
                endAt = System.currentTimeMillis() + 3_600_000L;
                preferences.edit().putLong(endAtKey, endAt).apply();
            }

            String title = sortedIds.length == 1
                    ? "S1 feasibility"
                    : "Instance " + (index == 0 ? "A" : "B");
            long base = SystemClock.elapsedRealtime()
                    + Math.max(0L, endAt - System.currentTimeMillis());
            RemoteViews views =
                    new RemoteViews(context.getPackageName(), R.layout.homeframe_widget);
            views.setTextViewText(R.id.title, title);
            views.setChronometer(R.id.countdown, base, null, running);
            views.setChronometerCountDown(R.id.countdown, true);
            manager.updateAppWidget(widgetId, views);
        }
    }
}
`,
  "app/src/main/java/dev/homeframe/basic/widget/HomeframeRecoveryProvider.java": `package dev.homeframe.basic.widget;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

public final class HomeframeRecoveryProvider extends ContentProvider {
    @Override
    public boolean onCreate() {
        Context context = getContext();
        if (context != null) {
            HomeframeWidgetProvider.refresh(context);
        }
        return true;
    }

    @Override
    public Cursor query(
            Uri uri,
            String[] projection,
            String selection,
            String[] selectionArgs,
            String sortOrder) {
        return null;
    }

    @Override
    public String getType(Uri uri) {
        return null;
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) {
        return null;
    }

    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        return 0;
    }

    @Override
    public int update(
            Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        return 0;
    }
}
`,
  "app/src/main/res/layout/homeframe_widget.xml": `<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/homeframe_root"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#F4F0E8"
    android:gravity="center_vertical"
    android:importantForAccessibility="yes"
    android:orientation="vertical"
    android:padding="16dp"
    android:screenReaderFocusable="true">
    <TextView
        android:id="@+id/title"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="S1 feasibility"
        android:textColor="#171714"
        android:textSize="16sp"
        android:textStyle="bold" />
    <Chronometer
        android:id="@+id/countdown"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:countDown="true"
        android:textColor="#171714"
        android:textSize="28sp" />
</LinearLayout>
`,
  "app/src/main/res/xml/homeframe_widget_info.xml": `<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:description="@string/homeframe_widget_description"
    android:initialLayout="@layout/homeframe_widget"
    android:minHeight="110dp"
    android:minWidth="180dp"
    android:previewLayout="@layout/homeframe_widget"
    android:resizeMode="horizontal|vertical"
    android:updatePeriodMillis="0"
    android:widgetCategory="home_screen" />
`,
  "app/src/main/res/values/homeframe_strings.xml": `<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="homeframe_widget_description">Homeframe event countdown</string>
</resources>
`,
};

function appendUnique(target, value, identity) {
  const existing = target.findIndex((entry) => identity(entry) === identity(value));
  if (existing === -1) {
    target.push(value);
  } else {
    target[existing] = value;
  }
}

function withHomeframeManifest(config) {
  return withAndroidManifest(config, (mod) => {
    const manifest = mod.modResults.manifest;
    manifest["uses-permission"] = manifest["uses-permission"] || [];
    appendUnique(
      manifest["uses-permission"],
      { $: { "android:name": "android.permission.RECEIVE_BOOT_COMPLETED" } },
      (entry) => entry.$["android:name"],
    );

    const application = AndroidConfig.Manifest.getMainApplicationOrThrow(mod.modResults);
    application.receiver = application.receiver || [];
    appendUnique(
      application.receiver,
      {
        $: {
          "android:exported": "true",
          "android:label": "Homeframe",
          "android:name": PROVIDER_CLASS,
        },
        "intent-filter": [
          {
            action: [
              { $: { "android:name": "android.appwidget.action.APPWIDGET_UPDATE" } },
              { $: { "android:name": "android.intent.action.BOOT_COMPLETED" } },
              { $: { "android:name": "dev.homeframe.action.REFRESH_WIDGET" } },
              { $: { "android:name": "dev.homeframe.action.RENDER_STATIC_TEST" } },
            ],
          },
        ],
        "meta-data": [
          {
            $: {
              "android:name": "android.appwidget.provider",
              "android:resource": "@xml/homeframe_widget_info",
            },
          },
        ],
      },
      (entry) => entry.$["android:name"],
    );

    const packageName = config.android?.package;
    if (packageName === undefined) {
      throw new Error("Homeframe Android plugin'i için expo.android.package gerekli.");
    }

    application.provider = application.provider || [];
    appendUnique(
      application.provider,
      {
        $: {
          "android:authorities": `${packageName}.homeframe-recovery`,
          "android:exported": "false",
          "android:initOrder": "100",
          "android:name": "dev.homeframe.basic.widget.HomeframeRecoveryProvider",
        },
      },
      (entry) => entry.$["android:name"],
    );

    return mod;
  });
}

function withHomeframeSources(config) {
  return withDangerousMod(config, [
    "android",
    async (mod) => {
      for (const [relativePath, contents] of Object.entries(generatedFiles)) {
        const outputPath = path.join(mod.modRequest.platformProjectRoot, relativePath);
        fs.mkdirSync(path.dirname(outputPath), { recursive: true });
        if (!fs.existsSync(outputPath) || fs.readFileSync(outputPath, "utf8") !== contents) {
          const temporaryPath = outputPath + ".homeframe-tmp";
          fs.writeFileSync(temporaryPath, contents, "utf8");
          fs.renameSync(temporaryPath, outputPath);
        }
      }
      return mod;
    },
  ]);
}

module.exports = function withHomeframe(config) {
  return withHomeframeSources(withHomeframeManifest(config));
};
