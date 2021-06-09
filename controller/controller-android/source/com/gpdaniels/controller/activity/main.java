package com.gpdaniels.controller.activity;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageButton;
import android.widget.Toast;

import com.gpdaniels.controller.service.api;

import com.gpdaniels.controller.R;

import java.util.List;

public final class main extends Activity {
    private static final String TAG = new Object(){}.getClass().getEnclosingClass().getCanonicalName();

    private api service_api = null;
    private final ServiceConnection service_connection = new ServiceConnection() {
        @Override
        public final void onServiceConnected(ComponentName component_name, IBinder binder) {
            Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
            service_api  = (api)binder;
        }
        @Override
        public final void onServiceDisconnected(ComponentName component_name) {
            Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
            service_api = null;
        }
    };

    private ImageButton button;
    private final View.OnClickListener button_handler = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
            if (view == button) {
                service_api.toast(main.this);
                service_api.connect();
            }
        }
    };

    private static Context application_context = null;
    public static Context get_application_context() {
        return application_context;
    }

    @Override
    protected final void onCreate(Bundle bundle) {
        application_context = getApplicationContext();

        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        super.onCreate(bundle);

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.main);

        // Connect to service.
        Intent intent = new Intent();
        intent.setComponent(new ComponentName(getApplicationContext().getPackageName(), com.gpdaniels.controller.service.main.class.getCanonicalName()));
        if (!bindService(intent, service_connection, Context.BIND_AUTO_CREATE | Context.BIND_IMPORTANT)) {
            Log.e(TAG, "Failed to bind to service.");
            Toast.makeText(this, "Failed to bind to service.", Toast.LENGTH_LONG).show();
            finish();
        }

        // Wire-up UI.
        button = findViewById(R.id.imageButton);
        button.setEnabled(false);

        // Request permissions.
        String[] required_permissions = permissions.get_all_required_permissions(this);
        List<String> missing_permissions = permissions.get_all_missing_permissions(this, required_permissions);
        if (!missing_permissions.isEmpty()) {
            requestPermissions(missing_permissions.toArray(new String[missing_permissions.size()]), 0);
        }
        else {
            onRequestPermissionsResult(0, new String[0], new int[0]);
        }
    }

    @Override
    public final void onRequestPermissionsResult(int request_code, String[] permission_names, int[] grant_results) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");

        String[] required_permissions = permissions.get_all_required_permissions(this);
        List<String> missing_permissions = permissions.get_all_missing_permissions(this, required_permissions);
        if (!missing_permissions.isEmpty()) {
            Log.e(TAG, "Required permissions have not been granted.");
            Log.e(TAG, "Missing permissions: " + missing_permissions);
            Toast.makeText(this, "Required permissions have not been granted.", Toast.LENGTH_LONG).show();
            finish();
            return;
        }

        // Enable UI.
        button.setEnabled(true);
        button.setOnClickListener(button_handler);
    }

    @Override
    protected final void onDestroy() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        super.onDestroy();
        unbindService(service_connection);
    }
}
