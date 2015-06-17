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

import org.allseen.lsf.sdk.model.BasicControllerService;
import org.allseen.lsf.sdk.model.LightingControllerConfiguration;

public class LightingController {

    private static final LightingController instance = new LightingController();

    private boolean controllerRunning;
    private BasicControllerService controllerService;

    private LightingController() {
        System.out.println("Initializing LightingController singleton");

        controllerRunning = false;
        controllerService = null;
    }

    public static LightingController get() {
        return LightingController.instance;
    }

    public LightingControllerStatus init(LightingControllerConfiguration configuration) {
        if (controllerRunning || configuration == null) {
            return LightingControllerStatus.ERROR_INIT;
        }

        controllerService = new BasicControllerService(configuration);
        return LightingControllerStatus.OK;
    }

    public LightingControllerStatus start() {

        if (controllerService != null && controllerService.getLightingControllerConfiguration() == null) {
            return LightingControllerStatus.ERROR_INIT;
        } else if (controllerRunning) {
            return LightingControllerStatus.ERROR_ALREADY_RUNNING;
        }

        controllerRunning = true;

        new Thread(new Runnable() {
            @Override
            public void run() {
                controllerService.start(controllerService.getLightingControllerConfiguration().getKeystorePath());
            }
        }).start();

        return LightingControllerStatus.OK;
    }

    public LightingControllerStatus stop() {
        controllerRunning = false;
        controllerService.stop();
        return LightingControllerStatus.OK;
    }

    public LightingControllerStatus lightingReset() {
        stop();
        controllerService.lightingReset();
        return LightingControllerStatus.OK;
    }

    public LightingControllerStatus factoryReset() {
        stop();
        controllerService.factoryReset();
        return LightingControllerStatus.OK;
    }

    public boolean isRunning() {
        return controllerRunning;
    }

    public void sendNetworkConnected() {
        if (controllerRunning) {
            controllerService.sendNetworkConnected();
        }
    }

    public void sendNetworkDisconnected() {
        if (controllerRunning) {
            controllerService.sendNetworkDisconnected();
        }
    }
}
