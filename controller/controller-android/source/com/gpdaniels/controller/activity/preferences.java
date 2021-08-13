package com.gpdaniels.controller.activity;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import java.util.Map;
import java.util.Set;

public final class preferences {
    private static final String TAG = new Object(){}.getClass().getEnclosingClass().getCanonicalName();

    public static boolean contains(String key) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        synchronized(new Object(){}.getClass().getEnclosingClass())
        {
            Context context = main.get_application_context();
            SharedPreferences database = context.getSharedPreferences(context.getPackageName(), Context.MODE_PRIVATE);
            return database.contains(key);
        }
    }

    @SuppressWarnings("unchecked")
    public static <type> type get(String key, type default_value) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        synchronized(new Object(){}.getClass().getEnclosingClass())
        {
            Context context = main.get_application_context();
            SharedPreferences database = context.getSharedPreferences(context.getPackageName(), Context.MODE_PRIVATE);
            Map<String, ?> all = database.getAll();
            if (all.containsKey(key)) {
                return ((type)all.get(key));
            }
            return default_value;
        }

    }

    @SuppressWarnings("unchecked")
    public static <type> boolean set(String key, type value) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        synchronized(new Object(){}.getClass().getEnclosingClass())
        {
            Context context = main.get_application_context();
            SharedPreferences database = context.getSharedPreferences(context.getPackageName(), Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = database.edit();

            if (value instanceof Boolean) {
                editor.putBoolean(key, Boolean.parseBoolean(value.toString()));
            }
            else if (value instanceof Integer) {
                editor.putInt(key, Integer.parseInt(value.toString()));
            }
            else if (value instanceof Long) {
                editor.putLong(key, Long.parseLong(value.toString()));
            }
            else if (value instanceof Float) {
                editor.putFloat(key, Float.parseFloat(value.toString()));
            }
            else if (value instanceof String) {
                editor.putString(key, (String)value);
            }
            else if ((value instanceof Set<?>) && ((((Set<?>)value).isEmpty()) || (((Set<?>)value).iterator().next() instanceof String))) {
                editor.putStringSet(key, (Set<String>)value);
            }
            else {
                Log.w(TAG, "Attempted to store an unsupported preference type.");
                return false;
            }

            editor.apply();
            return true;
        }
    }

    public static synchronized void remove(String key) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        synchronized(new Object(){}.getClass().getEnclosingClass())
        {
            Context context = main.get_application_context();
            SharedPreferences database = context.getSharedPreferences(context.getPackageName(), Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = database.edit();
            editor.remove(key);
            editor.apply();
        }
    }
}
