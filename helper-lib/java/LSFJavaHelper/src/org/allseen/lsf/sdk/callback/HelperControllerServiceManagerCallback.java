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
package org.allseen.lsf.sdk.callback;

import org.allseen.lsf.ControllerServiceManagerCallback;
import org.allseen.lsf.sdk.ResponseCode;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.manager.LightingSystemManager;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class HelperControllerServiceManagerCallback extends ControllerServiceManagerCallback {
    private final LightingSystemManager<?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?> manager;

    public HelperControllerServiceManagerCallback(LightingSystemManager<?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?> manager) {
        super();

        this.manager = manager;
    }

    @Override
    public void getControllerServiceVersionReplyCB(final long version) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                AllJoynManager.controllerServiceLeaderVersion = version;
                manager.getControllerCollectionManager().getLeaderModel().version = version;
                postSendControllerChanged();
            }
        });
    }

    @Override
    public void lightingResetControllerServiceReplyCB(ResponseCode responseCode) {
        // Currently nothing to do
    }

    @Override
    public void controllerServiceLightingResetCB() {
        // Currently nothing to do
    }

    @Override
    public void controllerServiceNameChangedCB(String controllerServiceDeviceID, String controllerServiceName) {
        // This is currently handled by the AboutManager
    }

    protected void postSendControllerChanged() {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                manager.getControllerCollectionManager().sendLeaderStateChangeEvent();
            }
        });
    }
}