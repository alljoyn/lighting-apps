/*
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 */
package org.allseen.lsf.sdk.model;

import org.allseen.lsf.ControllerService;
import org.allseen.lsf.sdk.AboutData;
import org.allseen.lsf.sdk.LightingControllerConfiguration;
import org.allseen.lsf.sdk.RankAvailability;
import org.allseen.lsf.sdk.RankMobility;
import org.allseen.lsf.sdk.RankNodeType;
import org.allseen.lsf.sdk.RankPower;

public class BasicControllerService extends ControllerService {

    protected LightingControllerConfiguration controllerConfiguration;

    public BasicControllerService(LightingControllerConfiguration configuration) {
        controllerConfiguration = configuration;
    }

    public LightingControllerConfiguration getLightingControllerConfiguration() {
        return controllerConfiguration;
    }

    @Override
    public void populateDefaultProperties(AboutData aboutData) {
        controllerConfiguration.populateDefaultProperties(aboutData);
    }

    @Override
    public String getMacAddress(String generatedMacAddress) {
        return controllerConfiguration.getMacAddress(generatedMacAddress);
    }

    @Override
    public boolean isNetworkConnected() {
        return controllerConfiguration.isNetworkConnected();
    }

    @Override
    public RankMobility getRankMobility() {
        return controllerConfiguration.getRankMobility();
    }

    @Override
    public RankPower getRankPower() {
        return controllerConfiguration.getRankPower();
    }

    @Override
    public RankAvailability getRankAvailability() {
        return controllerConfiguration.getRankAvailability();
    }

    @Override
    public RankNodeType getRankNodeType() {
        return controllerConfiguration.getRankNodeType();
    }
}
