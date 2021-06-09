package com.gpdaniels.controller.service;

import android.app.Activity;
import android.os.Binder;
import android.util.Log;
import android.widget.Toast;

import com.gpdaniels.controller.R;

import java.nio.charset.StandardCharsets;
import java.util.List;

public final class api extends Binder {
    private static final String TAG = new Object(){}.getClass().getEnclosingClass().getCanonicalName();

    public final void log() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
    }

    public final void toast(Activity context) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        Toast.makeText(context, "Test", Toast.LENGTH_LONG).show();
    }

    bluetooth bt;
    Thread t;
    public final void connect() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        t = new Thread() {
            public void run() {
                bt = new bluetooth();
                List<bluetooth.device_type> addresses = bt.get_paired_devices();
                if (!addresses.isEmpty()) {
                    Log.d(TAG, "Connecting to " + addresses.get(0).name + " @ " + addresses.get(0).address);
                    if (bt.open(addresses.get(0).address)) {
                        while(bt.is_open()) {
                            byte[] data = new byte[1];
                            if (bt.read(data)) {
                                Log.d(TAG + ".SPAM",  new String(data, StandardCharsets.UTF_8));
                            }
                        }
                    }
                }
                else {
                    Log.d(TAG, "No bluetooth devices paired.");
                }
            }
        };
        t.start();
    }
}
