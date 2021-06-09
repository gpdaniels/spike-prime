package com.gpdaniels.controller.service;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

import com.gpdaniels.controller.R;

public final class main extends Service {
    private static final String TAG = new Object(){}.getClass().getEnclosingClass().getCanonicalName();

    private final IBinder binder = new api();

    @Override
    public final void onCreate() {
        Log.d(TAG,  "onCreate()");
    }

    @Override
    public final int onStartCommand(Intent intent, int flags, int startId) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        // Stop self as this service is designed as a bound service and should not be started.
        stopSelf();
        return START_NOT_STICKY;
    }

    @Override
    public final IBinder onBind(Intent intent) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        return binder;
    }

    @Override
    public final boolean onUnbind(Intent intent) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        return super.onUnbind(intent);
    }

    @Override
    public final void onRebind(Intent intent) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
    }

    @Override
    public final void onDestroy() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
    }
}
