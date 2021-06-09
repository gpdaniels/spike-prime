package com.gpdaniels.controller.service;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

public final class receiver extends BroadcastReceiver {
    private static final String TAG = new Object(){}.getClass().getEnclosingClass().getCanonicalName();

    private static final String ACTION_STATE_CHANGED ="android.bluetooth.adapter.action.STATE_CHANGED";

    public receiver(Context context) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        context.registerReceiver(this, new IntentFilter(ACTION_STATE_CHANGED));
    }

    @Override
    public final void onReceive(Context context, Intent intent) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        // TODO: Should add a broadcast receiver for android.bluetooth.adapter.action.STATE_CHANGED
        // TODO: Plus others?
    }
}
