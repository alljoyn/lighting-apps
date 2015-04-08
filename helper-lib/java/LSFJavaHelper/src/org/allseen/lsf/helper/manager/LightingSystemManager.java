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
package org.allseen.lsf.helper.manager;

import org.allseen.lsf.LampGroupManager;
import org.allseen.lsf.LampManager;
import org.allseen.lsf.MasterSceneManager;
import org.allseen.lsf.NativeLibraryLoader;
import org.allseen.lsf.PresetManager;
import org.allseen.lsf.SceneManager;
import org.allseen.lsf.helper.callback.HelperControllerClientCallback;
import org.allseen.lsf.helper.callback.HelperControllerServiceManagerCallback;
import org.allseen.lsf.helper.callback.HelperGroupManagerCallback;
import org.allseen.lsf.helper.callback.HelperLampManagerCallback;
import org.allseen.lsf.helper.callback.HelperMasterSceneManagerCallback;
import org.allseen.lsf.helper.callback.HelperPresetManagerCallback;
import org.allseen.lsf.helper.callback.HelperSceneManagerCallback;
import org.allseen.lsf.helper.listener.AllJoynListener;
import org.allseen.lsf.helper.listener.ControllerAdapter;
import org.allseen.lsf.helper.model.AllLampsLampGroup;
import org.allseen.lsf.helper.model.ControllerDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class LightingSystemManager {
    @SuppressWarnings("unused")
    private static final NativeLibraryLoader LIBS = NativeLibraryLoader.LIBS;
    public static final String LANGUAGE = "en";

    public static final int POLLING_DELAY = 10000;
    public static final int LAMP_EXPIRATION = 15000;

    private final LightingSystemQueue queue;

    //TODO-FIX add get...() methods for these
    public final HelperControllerClientCallback controllerClientCB;
    public final HelperControllerServiceManagerCallback controllerServiceManagerCB;
    public final HelperLampManagerCallback lampManagerCB;
    public final HelperGroupManagerCallback groupManagerCB;
    public final HelperPresetManagerCallback presetManagerCB;
    public final HelperSceneManagerCallback sceneManagerCB;
    public final HelperMasterSceneManagerCallback masterSceneManagerCB;

    private final LampCollectionManager lampCollectionManager;
    private final GroupCollectionManager groupCollectionManager;
    private final PresetCollectionManager presetCollectionManager;
    private final SceneCollectionManager sceneCollectionManager;
    private final MasterSceneCollectionManager masterSceneCollectionManager;
    private final ControllerManager controllerManager;

    public LightingSystemManager(LightingSystemQueue queue) {
        this.queue = queue;

        AllLampsLampGroup.instance.setLightingSystemManager(this);

        controllerClientCB = new HelperControllerClientCallback(this);
        controllerServiceManagerCB = new HelperControllerServiceManagerCallback(this);
        lampManagerCB = new HelperLampManagerCallback(this);
        groupManagerCB = new HelperGroupManagerCallback(this);
        presetManagerCB = new HelperPresetManagerCallback(this);
        sceneManagerCB = new HelperSceneManagerCallback(this);
        masterSceneManagerCB = new HelperMasterSceneManagerCallback(this);

        lampCollectionManager = new LampCollectionManager(this);
        groupCollectionManager = new GroupCollectionManager(this);
        presetCollectionManager = new PresetCollectionManager(this);
        sceneCollectionManager = new SceneCollectionManager(this);
        masterSceneCollectionManager = new MasterSceneCollectionManager(this);
        controllerManager = new ControllerManager(this);

        controllerManager.addListener(new ControllerAdapter() {
            @Override
            public void onLeaderModelChange(ControllerDataModel leaderModel) {
                if (!leaderModel.connected) {
                    clearModels();
                }
            }
        });
    }

    public void init(String applicationName, AllJoynListener alljoynListener) {
        AboutManager aboutManager = new AboutManager(this);

        AllJoynManager.init(
            applicationName,
            queue,
            controllerClientCB,
            controllerServiceManagerCB,
            lampManagerCB,
            groupManagerCB,
            presetManagerCB,
            sceneManagerCB,
            masterSceneManagerCB,
            aboutManager,
            alljoynListener);
    }

    public void start() {
        clearModels();

        AllJoynManager.start(queue);
    }

    public void stop() {
        clearModels();

        AllJoynManager.stop(queue);
    }

    public void destroy() {
        stop();

        AllJoynManager.destroy();
    }

    public LightingSystemQueue getQueue() {
        return queue;
    }

    public LampCollectionManager getLampCollectionManager() {
        return lampCollectionManager;
    }

    public GroupCollectionManager getGroupCollectionManager() {
        return groupCollectionManager;
    }

    public PresetCollectionManager getPresetCollectionManager() {
        return presetCollectionManager;
    }

    public SceneCollectionManager getSceneCollectionManager() {
        return sceneCollectionManager;
    }

    public MasterSceneCollectionManager getMasterSceneCollectionManager() {
        return masterSceneCollectionManager;
    }

    public ControllerManager getControllerManager() {
        return controllerManager;
    }

    public LampManager getLampManager() {
        return AllJoynManager.lampManager;
    }

    public LampGroupManager getGroupManager() {
        return AllJoynManager.groupManager;
    }

    public PresetManager getPresetManager() {
        return AllJoynManager.presetManager;
    }

    public SceneManager getSceneManager() {
        return AllJoynManager.sceneManager;
    }

    public MasterSceneManager getMasterSceneManager() {
        return AllJoynManager.masterSceneManager;
    }

    public void postOnNextControllerConnection(final Runnable task, final int delay) {
        final ControllerManager controllerManager = getControllerManager();

        controllerManager.addListener(new ControllerAdapter() {
            @Override
            public void onLeaderModelChange(ControllerDataModel leaderModel) {
                if (leaderModel.connected) {
                    controllerManager.removeListener(this);
                    getQueue().postDelayed(task, delay);
                }
            }
        });
    }

    private void clearModels() {
        lampManagerCB.clear();

        lampCollectionManager.removeAllAdapters();
        groupCollectionManager.removeAllAdapters();
        presetCollectionManager.removeAllAdapters();
        sceneCollectionManager.removeAllAdapters();
        masterSceneCollectionManager.removeAllAdapters();
    }
}