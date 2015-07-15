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
package org.allseen.lsf.sdk;

import java.util.Random;

import org.alljoyn.bus.AboutKeys;
import org.allseen.lsf.AboutData;

/**
 * LightingControllerConfigurationBase automatically sets all the parameters necessary
 * to initialize a Lighting Controller.
 * <p>
 * <b>except</b> for the application's absolute path,
 * which must be passed as a parameter in the LightingContrllerConfigurationBase's
 * constructor method.
 * <p>
 * An example usage of a LightingControllerConfigurationBase can be found in the
 * LSFTutorial project.
 */
public class LightingControllerConfigurationBase implements LightingControllerConfiguration {

    private final String keystorePath;

    /**
     * Constructs a Lighting Controller Configuration Base with a Key StorePath.
     *
     * @param keystorePath The absolute path of you application.
     */
    public LightingControllerConfigurationBase(String keystorePath) {
        this.keystorePath = keystorePath;
    }

    /**
     * Returns the Keystore Path of the LightingControllerConfigurationBase
     *
     * @return The Keystore Path of the LightingControllerConfigurationBase as a String.
     */
    @Override
    public String getKeystorePath() {
        return this.keystorePath;
    }

    /**
     * Populates the default properties of a Lighting Controller Configuration.
     *
     * @param aboutData The About Data of your app.
     */
    @Override
    public void populateDefaultProperties(AboutData aboutData) {
        byte[] randomAppID = new byte[16];
        Random random = new Random();

        random.nextBytes(randomAppID);

        aboutData.put(AboutKeys.ABOUT_APP_ID, randomAppID);
        aboutData.put(AboutKeys.ABOUT_DATE_OF_MANUFACTURE, "10/1/2199");
        aboutData.put(AboutKeys.ABOUT_DEFAULT_LANGUAGE, "en");
        aboutData.put(AboutKeys.ABOUT_HARDWARE_VERSION, "355.499. b");
        aboutData.put(AboutKeys.ABOUT_MODEL_NUMBER, "LSF-SDK-CS");
        aboutData.put(AboutKeys.ABOUT_SOFTWARE_VERSION, "12.20.44 build 44454");
        aboutData.put(AboutKeys.ABOUT_SUPPORT_URL, "http://www.company_a.com");

        aboutData.put(AboutKeys.ABOUT_SUPPORTED_LANGUAGES, new String[] {"en, de-AT"});
        aboutData.put(AboutKeys.ABOUT_APP_NAME, "LightingControllerService", "en");
        aboutData.put(AboutKeys.ABOUT_APP_NAME, "LightingControllerService", "de-AT");
        aboutData.put(AboutKeys.ABOUT_DESCRIPTION, "Controller Service", "en");
        aboutData.put(AboutKeys.ABOUT_DESCRIPTION, "Controller Service", "de-AT");
        aboutData.put(AboutKeys.ABOUT_DEVICE_NAME, "My device name", "en");
        aboutData.put(AboutKeys.ABOUT_DEVICE_NAME, "Mein Gerätename", "de-AT");
        aboutData.put(AboutKeys.ABOUT_MANUFACTURER, "Company A (EN)", "en");
        aboutData.put(AboutKeys.ABOUT_MANUFACTURER, "Firma A (DE-AT)", "de-AT");
    }

    /**
     * Returns the MAC Address of the Lighting Controller Configuration Base.
     *
     * @return The MAC Address of the Lighting Controller Configuration Base.
     */
    @Override
    public String getMacAddress(String generatedMacAddress) {
        return generatedMacAddress;
    }

    /**
     * Returns boolean representing the Lighting Controller Configuration is network connected.
     *
     * @return boolean true.
     */
    @Override
    public boolean isNetworkConnected() {
        return true;
    }

    /**
     * Returns the Rank Power of the Lighting Controller Configuration.
     *
     * @return The Rank Power of the Lighting Controller Configuration.
     */
    @Override
    public RankPower getRankPower() {
        return RankPower.BATTERY_POWERED_CHARGABLE;
    }

    /**
     * Returns the Rank Mobility of the Lighting Controller Configuration.
     *
     * @return The Rank Mobility of the Lighting Controller Configuration.
     */
    @Override
    public RankMobility getRankMobility() {
        return RankMobility.HIGH_MOBILITY;
    }

    /**
     * Returns the Rank Availability of the Lighting Controller Configuration.
     *
     * @return The Rank Availability of the Lighting Controller Configuration.
     */
    @Override
    public RankAvailability getRankAvailability() {
        return RankAvailability.SIX_TO_NINE_HOURS;
    }

    /**
     * Returns the Rank Node Type of the Lighting Controller Configuration.
     *
     * @return The Rank Node Type of the Lighting Controller Configuration.
     */
    @Override
    public RankNodeType getRankNodeType() {
        return RankNodeType.WIRELESS;
    }
}

