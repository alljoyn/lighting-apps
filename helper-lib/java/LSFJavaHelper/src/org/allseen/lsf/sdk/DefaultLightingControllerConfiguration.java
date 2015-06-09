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

import org.allseen.lsf.RankAvailability;
import org.allseen.lsf.RankMobility;
import org.allseen.lsf.RankNodeType;
import org.allseen.lsf.RankPower;

public class DefaultLightingControllerConfiguration implements LightingControllerConfiguration {

    private final String keystorePath;

    public DefaultLightingControllerConfiguration(String keystorePath) {
        this.keystorePath = keystorePath;
    }

    @Override
    public String getKeystorePath() {
        return this.keystorePath;
    }

    @Override
    public String getDefaultDeviceId(String generatedDeviceId) {
        return generatedDeviceId;
    }

    @Override
    public String getDefaultAppId(String generatedAppId) {
        return generatedAppId;
    }

    @Override
    public String getMacAddress(String generatedMacAddress) {
        return generatedMacAddress;
    }

    @Override
    public boolean isNetworkConnected() {
        return true;
    }

    @Override
    public RankPower getRankPower() {
        return RankPower.BATTERY_POWERED_CHARGABLE;
    }

    @Override
    public RankMobility getRankMobility() {
        return RankMobility.HIGH_MOBILITY;
    }

    @Override
    public RankAvailability getRankAvailability() {
        return RankAvailability.SIX_TO_NINE_HOURS;
    }

    @Override
    public RankNodeType getRankNodeType() {
        return RankNodeType.WIRELESS;
    }
}

