/*
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.sampleapp;

import java.util.Map;

import org.alljoyn.about.AboutKeys;
import org.alljoyn.bus.Variant;

public class LampAbout {
    public static String dataNotFound = "-";

    public String aboutPeer;
    public short aboutPort;
    public boolean aboutQuery;

    // Announced data
    public String aboutDeviceID;
    public String aboutAppID;
    public String aboutDeviceName;
    public String aboutDefaultLanguage;
    public String aboutAppName;
    public String aboutManufacturer;
    public String aboutModelNumber;

    // Queried data
    public String aboutDescription;
    public String aboutDateOfManufacture;
    public String aboutSoftwareVersion;
    public String aboutHardwareVersion;
    public String aboutSupportUrl;

    public LampAbout() {
        aboutPeer = null;
        aboutPort = 0;
        aboutQuery = false;

        aboutDeviceID = dataNotFound;
        aboutAppID = dataNotFound;
        aboutDeviceName = dataNotFound;
        aboutDefaultLanguage = dataNotFound;
        aboutAppName = dataNotFound;
        aboutManufacturer = dataNotFound;
        aboutModelNumber = dataNotFound;

        aboutDescription = dataNotFound;
        aboutDateOfManufacture = dataNotFound;
        aboutSoftwareVersion = dataNotFound;
        aboutHardwareVersion = dataNotFound;
        aboutSupportUrl = dataNotFound;
    }

    public void setAnnouncedData(String peer, short port, Map<String, Variant> announcedData) {
        if (announcedData != null) {
            aboutPeer = peer;
            aboutPort = port;

            aboutAppID = AboutManager.getByteArrayHexStringFromAnnouncedData(AboutKeys.ABOUT_APP_ID, announcedData, dataNotFound);
        }
    }

    public void setQueriedData(Map<String, Object> queriedData) {
        if (queriedData != null) {
            aboutQuery = true;

            aboutDeviceID = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_DEVICE_ID, queriedData, dataNotFound);
            aboutDeviceName = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_DEVICE_NAME, queriedData, dataNotFound);
            aboutDefaultLanguage = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_DEFAULT_LANGUAGE, queriedData, dataNotFound);
            aboutAppName = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_APP_NAME, queriedData, dataNotFound);
            aboutManufacturer = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_MANUFACTURER, queriedData, dataNotFound);
            aboutModelNumber = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_MODEL_NUMBER, queriedData, dataNotFound);
            aboutDescription = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_DESCRIPTION, queriedData, dataNotFound);
            aboutDateOfManufacture = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_DATE_OF_MANUFACTURE, queriedData, dataNotFound);
            aboutSoftwareVersion = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_SOFTWARE_VERSION, queriedData, dataNotFound);
            aboutHardwareVersion = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_HARDWARE_VERSION, queriedData, dataNotFound);
            aboutSupportUrl = AboutManager.getStringFromQueriedData(AboutKeys.ABOUT_SUPPORT_URL, queriedData, dataNotFound);
        }
    }
}