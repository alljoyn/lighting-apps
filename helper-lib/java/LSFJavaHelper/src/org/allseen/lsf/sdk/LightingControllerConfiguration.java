/*
 * Copyright (c) AllSeen Alliance. All rights reserved.
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

import org.allseen.lsf.AboutData;
import org.allseen.lsf.sdk.RankAvailability;
import org.allseen.lsf.sdk.RankMobility;
import org.allseen.lsf.sdk.RankNodeType;
import org.allseen.lsf.sdk.RankPower;

/**
 * Interface used to define any application and device specific values used by
 * the LightingController. The LightingController will query its configuration
 * interface to determine storage location, identifier strings, network
 * connectivity, and controller ranking.
 */
public interface LightingControllerConfiguration {

    /**
     * Get the location to save all AllJoyn and LightingController specific
     * files.
     *
     * @return Absolute directory path to be used for file storage.
     */
    public String getKeystorePath();

    /**
     * Populates the AllJoyn AboutData properties to be used for the LightingController.
     *
     * @param aboutData
     *      AllJoyn AboutData object that will be filled with the default values within
     *      this method.
     */
    public void populateDefaultProperties(AboutData aboutData);

    /**
     * Get the MAC Address of the device running the LightingController. The
     * MAC Address is expected as a 12-digit HEX string (i.e. "XXXXXXXXXXXX")
     *
     * @param generatedMacAddress
     *      A random 12-digit HEX string which can be substituted as the MAC
     *      address on devices where it cannot be queried.
     *
     * @return the MAC address of the device
     */
    public String getMacAddress(String generatedMacAddress);

    /**
     * Determines whether the LightingController is connected to a network.
     *
     * @return true if the controller is connected to a network, otherwise false.
     */
    public boolean isNetworkConnected();

    /**
     * Get the Mobility parameter of the LightingController. The mobility is
     * used when determining the controller's rank.
     *
     * @return the LightingController mobility
     */
    public RankMobility getRankMobility();

    /**
     * Get the Power parameter of the LightingController. The power is used
     * when determining the controller's rank.
     *
     * @return the LightingController power
     */
    public RankPower getRankPower();

    /**
     * Get the Availability parameter of the LightingController. The
     * availability is used when determining the controller's rank.
     *
     * @return the LightingController availability
     */
    public RankAvailability getRankAvailability();

    /**
     * Get the NodeType parameter of the LightingController. The NodeType is
     * used when determining the controller's rank.
     *
     * @return the LightingController node type
     */
    public RankNodeType getRankNodeType();
}

