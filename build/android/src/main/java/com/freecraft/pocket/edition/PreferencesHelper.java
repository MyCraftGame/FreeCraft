package com.freecraft.pocket.edition;

import android.content.Context;
import android.content.SharedPreferences;

import com.freecraft.pocket.edition.R;

class PreferencesHelper {
    private static final String SETTINGS = "settings";
    static final String TAG_SHORTCUT_CREATED = "createShortcut";
    static final String TAG_BUILD_NUMBER = "buildNumber";
    static final String TAG_LAUNCH_TIMES = "launchTimes";
    private static boolean createShortcut;
    private static String buildNumber;
    private static SharedPreferences settings;

    static boolean isCreateShortcut() {
        return createShortcut;
    }

    static String getBuildNumber() {
        return buildNumber;
    }

    static void loadSettings(final Context context) {
        settings = context.getSharedPreferences(SETTINGS, Context.MODE_PRIVATE);
        createShortcut = settings.getBoolean(TAG_SHORTCUT_CREATED, true);
        buildNumber = settings.getString(TAG_BUILD_NUMBER, "0");
    }

    static void saveSettings(String tag, boolean bool) {
        settings.edit().putBoolean(tag, bool).apply();
    }

    static int getLaunchTimes() {
        return settings.getInt(TAG_LAUNCH_TIMES, 0);
    }

    static void saveSettings(String tag, String value) {
        settings.edit().putString(tag, value).apply();
    }

    static void saveSettings(String tag, int value) {
        settings.edit().putInt(tag, value).apply();
    }
}
