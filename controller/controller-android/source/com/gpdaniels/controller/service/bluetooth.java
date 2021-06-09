package com.gpdaniels.controller.service;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.util.Log;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

public final class bluetooth {
    private static final String TAG = new Object(){}.getClass().getEnclosingClass().getCanonicalName();

    public static class device_type {
        public final String name;
        public final String address;
        public device_type(String device_name, String device_address) {
            name = device_name;
            address = device_address;
        }
    }

    private final BluetoothAdapter adapter;
    private BluetoothSocket socket;

    public bluetooth() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingConstructor().getName() + "()");

        // Bluetooth Setup
        adapter = BluetoothAdapter.getDefaultAdapter();

        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return;
        }

        // We're not going to be doing any discovering.
        adapter.cancelDiscovery();
    }

    public final List<device_type> get_paired_devices() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");

        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return new ArrayList<>();
        }

        // Get List of Paired Bluetooth Device
        Set<BluetoothDevice> paired_devices = adapter.getBondedDevices();
        if (paired_devices.isEmpty()) {
            Log.w(TAG, "There are no paired bluetooth devices.");
        }

        // Extract the name and address of each paired device.
        List<device_type> device_list = new ArrayList<>();
        for (BluetoothDevice paired_device : paired_devices) {
            String name = paired_device.getName();
            String address = paired_device.getAddress();
            device_type device = new device_type(name, address);
            device_list.add(device);
        }
        return device_list;
    }

    public final boolean is_open() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");
        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return false;
        }
        if (socket == null) {
            return false;
        }
        return socket.isConnected();
    }

    public final boolean open(String address) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");

        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return false;
        }

        if (!BluetoothAdapter.checkBluetoothAddress(address)) {
            Log.e(TAG, "Cannot connect to invalid bluetooth address: " + address);
            return false;
        }

        if (is_open()) {
            Log.e(TAG, "Cannot connect to bluetooth devices while already connected.");
            return false;
        }

        // Try and open a socket to the device.
        BluetoothDevice device = adapter.getRemoteDevice(address);
        UUID uuid = device.getUuids()[0].getUuid();
        try {
            //socket = device.createRfcommSocketToServiceRecord(uuid);
            socket = device.createInsecureRfcommSocketToServiceRecord(uuid);
        } catch (IOException exception) {
            Log.e(TAG, "Failed to create rfcomm socket to device with error: ", exception);
            return false;
        }

        // Try and connect to the remote device through the socket.
        try {
            // This call blocks until it succeeds or throws an exception.
            socket.connect();
        } catch (IOException exception) {
            Log.e(TAG, "Failed to connect to device with error: ", exception);
            close();
            return false;
        }

        return true;
    }

    public final void close() {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");

        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return;
        }

        try {
            socket.close();
        } catch (IOException exception) {
            Log.e(TAG, "Failed to close the device socket with error: ", exception);
        }
    }

    public final boolean read(byte[] character) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");

        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return false;
        }

        if (!is_open()) {
            Log.e(TAG, "Cannot read from a device before connecting.");
            return false;
        }

        int buffer;
        try {
            buffer = socket.getInputStream().read();
        } catch (IOException exception) {
            Log.e(TAG, "Failed to read from the device with error: ", exception);
            return false;
        }

        if (buffer < 0) {
            return false;
        }

        character[0] = (byte)buffer;
        return true;
    }

    public final boolean write(byte character) {
        Log.d(TAG, new Object(){}.getClass().getEnclosingMethod().getName() + "()");

        if (adapter == null) {
            Log.e(TAG, "Bluetooth is not supported on this device.");
            return false;
        }

        if (!is_open()) {
            Log.e(TAG, "Cannot write to a device before connecting.");
            return false;
        }

        try {
            socket.getOutputStream().write(character);
        } catch (IOException exception) {
            Log.e(TAG, "Failed to write to the device with error: ", exception);
            return false;
        }

        return true;
    }
}
