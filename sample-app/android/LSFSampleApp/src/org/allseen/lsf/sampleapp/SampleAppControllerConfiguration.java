/*
 * Copyright AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.sampleapp;

import java.lang.reflect.Method;

import org.allseen.lsf.sdk.DefaultLightingControllerConfiguration;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

public class SampleAppControllerConfiguration extends DefaultLightingControllerConfiguration {

    private static final String DEVICE_ID_KEY = "CONTROLLER_DEVICE_ID";
    private static final String APP_ID_KEY = "CONTROLLER_APP_ID";

    private Context appContext;

    public SampleAppControllerConfiguration(String keystorePath) {
        this(keystorePath, null);
    }

    public SampleAppControllerConfiguration(String keystorePath, Context context) {
        super(keystorePath);

        appContext = context;
    }

    @Override
    public String getDefaultDeviceId(String generatedDeviceId) {
        return getSavedPreference(DEVICE_ID_KEY, generatedDeviceId);
    }

    @Override
    public String getDefaultAppId(String generatedAppId) {
        return getSavedPreference(APP_ID_KEY, generatedAppId);
    }

    @Override
    public String getMacAddress(String generatedMacAddress) {
        if (appContext == null) {
            return generatedMacAddress;
        }

        WifiManager wifiManager = (WifiManager) appContext.getSystemService(Context.WIFI_SERVICE);
        WifiInfo wInfo = wifiManager.getConnectionInfo();
        String originalMacAddress = wInfo.getMacAddress();

        if (originalMacAddress == null) {
            // If we don't have mac address, create one of length 12 which is
            // the usual length of mac address.
            originalMacAddress = generatedMacAddress;
        }

        originalMacAddress = originalMacAddress.replace(":", "");

        return originalMacAddress;
    }

    @Override
    public boolean isNetworkConnected() {
        if (appContext == null) {
            return super.isNetworkConnected();
        }

        return isWifiConnected();
    }

    private String getSavedPreference(String key, String generatedValue) {
        if (appContext == null) {
            return generatedValue;
        }

        SharedPreferences prefs = appContext.getSharedPreferences("PREFS_READ", Context.MODE_PRIVATE);
        String prefString = prefs.getString(key, null);

        if (prefString == null) {
            prefString = generatedValue;

            Editor e = prefs.edit();
            e.putString(key, prefString);
            e.commit();
        }

        return prefString;
    }

    private boolean isWifiConnected() {
        NetworkInfo wifiNetworkInfo = ((ConnectivityManager) appContext.getSystemService(Context.CONNECTIVITY_SERVICE)).getNetworkInfo(ConnectivityManager.TYPE_WIFI);

        // determine if wifi AP mode is on
        boolean isWifiApEnabled = false;
        WifiManager wifiManager = (WifiManager) appContext.getSystemService(Context.WIFI_SERVICE);
        // need reflection because wifi ap is not in the public API
        try {
            Method isWifiApEnabledMethod = wifiManager.getClass().getDeclaredMethod("isWifiApEnabled");
            isWifiApEnabled = (Boolean) isWifiApEnabledMethod.invoke(wifiManager);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Log.d(SampleAppActivity.TAG, "Connectivity state " + wifiNetworkInfo.getState().name() + " - connected:" + wifiNetworkInfo.isConnected() + " hotspot:" + isWifiApEnabled);

        return wifiNetworkInfo.isConnected() || isWifiApEnabled;
    }
}

