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

/**
 * The Lighting Controller class serves as middle manager to all devices and
 * applications working within the lighting system so that they may be recognized
 * and interact with one another.
 * <p>
 * Please see the LSFTutorial Project for an example of how to use the Lighting
 * Controller class.
 */
public class LightingController {

    private static final LightingController instance = new LightingController();

    private boolean controllerRunning;
    private BasicControllerService controllerService;

    /*
     * Construct a LightingController instance with the default queue.
     *
     * Note that this is private since LightingController is a singleton. See
     * LightingController.get()
     */
    private LightingController() {
        System.out.println("Initializing LightingController singleton");

        controllerRunning = false;
        controllerService = null;
    }

    /**
     * Construct a Lighting Controller instance.
     * <p>
     * Note that the start() method must be called at some point after
     * construction when you're ready to begin working with the Lighting Controller.
     *
     * @return The Lighting Controller instance.
     */
    public static LightingController get() {
        return LightingController.instance;
    }

    /**
     * Initialize the Lighting Controller with a context configuration.
     * <p>
     * Note that this method call should follow the get() method and
     * precede the start() method.
     * <p>
     * Note that the intended configuration is to pass in a LightingControllerConfigurationBase
     * with the application's absolute path as a parameter. An example of passing such a
     * configuration can be found in the LSFTutorial Project.
     *
     * @param configuration The desired configuration for your Lighting Controller.
     * @return "OK" status from the Lighting Controller.
     */
    public LightingControllerStatus init(LightingControllerConfiguration configuration) {
        if (controllerRunning || configuration == null) {
            return LightingControllerStatus.ERROR_INIT;
        }

        controllerService = new BasicControllerService(configuration);
        return LightingControllerStatus.OK;
    }

    /**
     * Causes the LightingController to start interacting with devices on the
     * network.
     * <p>
     * Note: start() should be called before interacting with the Lighting
     * Controller. Subsequent calls to start() must each be preceded by a call
     * to stop().
     * <p>
     * Note: you should make sure a WiFi or other network connection is
     * available before calling this method.
     */
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

    /**
     * Causes the Lighting Controller to stop interacting with devices on the network.
     *
     * @return "OK" status from the Lighting Controller.
     */
    public LightingControllerStatus stop() {
        controllerRunning = false;
        controllerService.stop();
        return LightingControllerStatus.OK;
    }

    /**
     * Causes the Lighting Controller to reset.
     *
     * @return "OK" status from the Lighting Controller.
     */
    public LightingControllerStatus lightingReset() {
        stop();
        controllerService.lightingReset();
        return LightingControllerStatus.OK;
    }

    /**
     * Causes the Lighting Controller to factory reset.
     *
     * @return "OK" status from the Lighting Controller.
     */
    public LightingControllerStatus factoryReset() {
        stop();
        controllerService.factoryReset();
        return LightingControllerStatus.OK;
    }

    /**
     * Returns a boolean representing whether the Controller is running.
     *
     * @return boolean representing whether the Controller is running.
     */
    public boolean isRunning() {
        return controllerRunning;
    }

    /**
     * Forwards a sendNetworkConnected() method call to the Controller Service.
     */
    public void sendNetworkConnected() {
        if (controllerRunning) {
            controllerService.sendNetworkConnected();
        }
    }

    /**
     * Forwards a sendNetworkDisconnected() method call to the Controller Service.
     */
    public void sendNetworkDisconnected() {
        if (controllerRunning) {
            controllerService.sendNetworkDisconnected();
        }
    }
}
