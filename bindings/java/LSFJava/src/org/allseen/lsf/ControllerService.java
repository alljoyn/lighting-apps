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
package org.allseen.lsf;

import org.allseen.lsf.sdk.AboutData;
import org.allseen.lsf.sdk.RankAvailability;
import org.allseen.lsf.sdk.RankMobility;
import org.allseen.lsf.sdk.RankNodeType;
import org.allseen.lsf.sdk.RankPower;

public abstract class ControllerService extends DefaultNativeClassWrapper {
    private static final NativeLibraryLoader LIBS = NativeLibraryLoader.LIBS;

    public ControllerService() {
        createNativeObject();
    }

    public abstract void populateDefaultProperties(AboutData aboutData);
    public abstract String getMacAddress(String generatedMacAddress);
    public abstract boolean isNetworkConnected();
    public abstract RankPower getRankPower();
    public abstract RankMobility getRankMobility();
    public abstract RankAvailability getRankAvailability();
    public abstract RankNodeType getRankNodeType();

    public native void start(String keyStorePath);
    public native void stop();
    public native void lightingReset();
    public native void factoryReset();
    public native void sendNetworkConnected();
    public native void sendNetworkDisconnected();
    public native String getName();
    public native boolean isLeader();

    protected void populateDefaultProperties(long nativeAboutDataHandle) {
        populateDefaultProperties(new AboutData(nativeAboutDataHandle));
    }

    @Override
    protected native void createNativeObject();

    @Override
    protected native void destroyNativeObject();
}
