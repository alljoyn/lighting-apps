/*
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.helper.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.alljoyn.about.AboutKeys;
import org.alljoyn.bus.AboutListener;
import org.alljoyn.bus.AboutObjectDescription;
import org.alljoyn.bus.AboutProxy;
import org.alljoyn.bus.BusAttachment;
import org.alljoyn.bus.BusException;
import org.alljoyn.bus.Mutable;
import org.alljoyn.bus.SessionListener;
import org.alljoyn.bus.SessionOpts;
import org.alljoyn.bus.Status;
import org.alljoyn.bus.Variant;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class AboutManager implements AboutListener {
    private BusAttachment bus;
    private final LightingSystemManager manager;

    private static final String[] LAMP_SERVICE_INTERFACE_NAMES = {
        "org.allseen.LSF.LampService",
        "org.allseen.LSF.LampState",
        "org.allseen.LSF.LampParameters",
        "org.allseen.LSF.LampDetails" };
    private static final String[] CONTROLLER_SERVICE_INTERFACE_NAMES = {
        "org.allseen.LSF.ControllerService.Lamp",
        "org.allseen.LSF.ControllerService.LampGroup",
        "org.allseen.LSF.ControllerService.Preset",
        "org.allseen.LSF.ControllerService.Scene",
        "org.allseen.LSF.ControllerService.MasterScene" };

    public AboutManager(LightingSystemManager manager) {
        this.bus = null;
        this.manager = manager;
    }

    public void start(BusAttachment ba) {
        if (bus == null) {
            bus = ba;

            bus.registerAboutListener(this);

            bus.whoImplements(AboutManager.LAMP_SERVICE_INTERFACE_NAMES);
            bus.whoImplements(AboutManager.CONTROLLER_SERVICE_INTERFACE_NAMES);
        }
    }

    public void stop() {
        if (bus != null) {
            bus.unregisterAboutListener(this);

            bus.cancelWhoImplements(AboutManager.LAMP_SERVICE_INTERFACE_NAMES);
            bus.cancelWhoImplements(AboutManager.CONTROLLER_SERVICE_INTERFACE_NAMES);

            bus = null;
        }
    }

    public void destroy() {
        if (bus != null) {
            stop();
        }
    }

    @Override
    public void announced(String busName, int version, short port, AboutObjectDescription[] aboutObjects, Map<String, Variant> announcedData) {
        //TODO-FIX Log.d("AboutManager", "Announcement received from AboutService");

        // Flatten the interfaces
        List<String> allInterfaces = new ArrayList<String>();
        for (AboutObjectDescription aboutObject : aboutObjects) {
            for (String iface : aboutObject.interfaces) {
                allInterfaces.add(iface);
            }
        }

        if (containsLampInterfaces(allInterfaces)) {
            //TODO-FIX Log.d("AboutManager", "announcement: lamp ifaces found");
            addLampAnnouncedAboutData(busName, port, announcedData);
        } else if (containsControllerInterfaces(allInterfaces)) {
            //TODO-FIX Log.d("AboutManager", "announcement: controller ifaces found");
            addControllerAnnouncedAboutData(announcedData);
        }
    }

    protected boolean containsLampInterfaces(List<String> allInterfaces) {
        for (String iface : AboutManager.LAMP_SERVICE_INTERFACE_NAMES) {
            if (!allInterfaces.contains(iface)) {
                // this does not have a necessary lamp interface
                return false;
            }
        }

        return true;
    }

    protected boolean containsControllerInterfaces(List<String> allInterfaces) {
        for (String iface : AboutManager.CONTROLLER_SERVICE_INTERFACE_NAMES) {
            if (!allInterfaces.contains(iface)) {
                // this does not have a necessary controller interface
                return false;
            }
        }

        return true;
    }

    protected void addLampAnnouncedAboutData(String busName, short port, final Map<String, Variant> announcedData) {
        String lampID = getStringFromVariantMap(AboutKeys.ABOUT_DEVICE_ID, announcedData, null);

        if (lampID != null) {
            //TODO-FIX Log.d("AboutManager", "Announce received: " + lampID);
            manager.lampManagerCB.postOnLampAnnouncedAboutData(lampID, busName, port, announcedData, 0);
        } else {
            //TODO-FIX Log.e("AboutManager", "Announcement lacks device ID");
        }
    }

    public void getLampQueriedAboutData(String lampID, String busName, short port) {
        try {
            Mutable.IntegerValue sessionId = new Mutable.IntegerValue();;

            SessionOpts sessionOpts = new SessionOpts();
            sessionOpts.traffic = SessionOpts.TRAFFIC_MESSAGES;
            sessionOpts.isMultipoint = false;
            sessionOpts.proximity = SessionOpts.PROXIMITY_ANY;
            sessionOpts.transports = SessionOpts.TRANSPORT_ANY;

            Status status = bus.joinSession(busName, port, sessionId, sessionOpts, new SessionListener() {
                @Override
                public void sessionLost(int sessionId, int reason) {
                    //TODO-FIX Log.d("AboutManager", "Session Lost : " + sessionId + " reason: " + reason);
                }});

            //TODO-FIX Log.d("AboutManager", "bus " + busName + ", port " + port + ", session " + sessionId.value);

            if (status == Status.OK) {
                //TODO-FIX Log.d("AboutManager", "join session success");
                AboutProxy aboutProxy = new AboutProxy(bus, busName, sessionId.value);
                Map<String, Variant> queriedData = aboutProxy.getAboutData(LightingSystemManager.LANGUAGE);

                manager.lampManagerCB.postOnLampQueriedAboutData(lampID, queriedData, 0);
            } else {
                //TODO-FIX Log.e("AboutManager", "join session failed " + status);
            }
        } catch (BusException e) {
            //TODO-FIX Log.e("AboutManager", "About data retrieval failed: " + e.getMessage());
        }
    }

    protected void addControllerAnnouncedAboutData(final Map<String, Variant> announceData) {
        String controllerID = getStringFromVariantMap(AboutKeys.ABOUT_DEVICE_ID, announceData, null);
        String controllerName = getStringFromVariantMap(AboutKeys.ABOUT_DEVICE_NAME, announceData, null);

        manager.controllerClientCB.postOnControllerAnnouncedAboutData(controllerID, controllerName, 200);
    }

    public static String getStringFromVariantMap(String key, Map<String, Variant> variantMap, String defaultValue) {
        String value = defaultValue;

        if (variantMap != null) {
            try {
                Variant variant = variantMap.get(key);

                if (variant != null) {
                    value = variant.getObject(String.class);
                }
            } catch (BusException e) {
                //TODO-FIX Log.e(SampleAppActivity.TAG, "Announce parsing failed: key: " + key + ": " + e.getMessage());
            }
        }

        return value;
    }

    public static String getByteArrayHexStringFromVariantMap(String key, Map<String, Variant> variantMap, String defaultValue) {
        String value = defaultValue;

        if (variantMap != null) {
            try {
                Variant variant = variantMap.get(key);

                if (variant != null) {
                    byte[] bytes = variant.getObject(byte[].class);

                    StringBuilder sb = new StringBuilder("0x");

                    for (int i = 0; i < bytes.length; i++) {
                        sb.append(String.format("%02X", bytes[i]));

                        // group the bytes into groups of 4
                        if((i + 1) % 4 == 0) {
                            sb.append(" ");
                        }
                    }

                    value = sb.toString();
                }
            } catch (BusException e) {
                //TODO-FIX Log.e(SampleAppActivity.TAG, "Announce parsing failed: key: " + key + ": " + e.getMessage());
            }
        }

       return value;
    }
}