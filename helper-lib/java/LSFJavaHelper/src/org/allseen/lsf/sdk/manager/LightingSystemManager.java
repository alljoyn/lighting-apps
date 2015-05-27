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
package org.allseen.lsf.sdk.manager;

import org.alljoyn.bus.BusAttachment;
import org.allseen.lsf.LampGroupManager;
import org.allseen.lsf.LampManager;
import org.allseen.lsf.MasterSceneManager;
import org.allseen.lsf.NativeLibraryLoader;
import org.allseen.lsf.PresetManager;
import org.allseen.lsf.PulseEffectManager;
import org.allseen.lsf.SceneElementManager;
import org.allseen.lsf.SceneManager;
import org.allseen.lsf.SceneManagerCallback;
import org.allseen.lsf.TransitionEffectManager;
import org.allseen.lsf.sdk.AllJoynListener;
import org.allseen.lsf.sdk.ControllerAdapter;
import org.allseen.lsf.sdk.NextControllerConnectionListener;
import org.allseen.lsf.sdk.callback.HelperControllerClientCallback;
import org.allseen.lsf.sdk.callback.HelperControllerServiceManagerCallback;
import org.allseen.lsf.sdk.callback.HelperGroupManagerCallback;
import org.allseen.lsf.sdk.callback.HelperLampManagerCallback;
import org.allseen.lsf.sdk.callback.HelperMasterSceneManagerCallback;
import org.allseen.lsf.sdk.callback.HelperPresetManagerCallback;
import org.allseen.lsf.sdk.callback.HelperPulseEffectManagerCallback;
import org.allseen.lsf.sdk.callback.HelperSceneElementManagerCallback;
import org.allseen.lsf.sdk.callback.HelperSceneManagerCallback;
import org.allseen.lsf.sdk.callback.HelperSceneManagerCallbackV1;
import org.allseen.lsf.sdk.callback.HelperSceneManagerCallbackV2;
import org.allseen.lsf.sdk.callback.HelperTransitionEffectManagerCallback;
import org.allseen.lsf.sdk.model.AllLampsLampGroup;
import org.allseen.lsf.sdk.model.ControllerDataModel;

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

    private LightingSystemQueue queue;

    //TODO-FIX add get...() methods for these
    public final HelperControllerClientCallback controllerClientCB;
    public final HelperControllerServiceManagerCallback controllerServiceManagerCB;
    public final HelperLampManagerCallback lampManagerCB;
    public final HelperGroupManagerCallback groupManagerCB;
    public final HelperPresetManagerCallback presetManagerCB;
    public final HelperTransitionEffectManagerCallback transitionEffectManagerCB;
    public final HelperPulseEffectManagerCallback pulseEffectManagerCB;
    public final HelperSceneElementManagerCallback sceneElementManagerCB;
    public final HelperSceneManagerCallbackV1 sceneManagerCBV1;
    public final HelperSceneManagerCallbackV2 sceneWithSceneElementsManagerCB;
    public final HelperSceneManagerCallback sceneManagerCB;
    public final HelperMasterSceneManagerCallback masterSceneManagerCB;

    private final LampCollectionManager lampCollectionManager;
    private final GroupCollectionManager groupCollectionManager;
    private final PresetCollectionManager presetCollectionManager;
    private final TransitionEffectCollectionManager transitionEffectCollectionManager;
    private final PulseEffectCollectionManager pulseEffectCollectionManager;
    private final SceneElementCollectionManager sceneElementCollectionManager;
    private final SceneCollectionManager sceneCollectionManagerV1;
    private final SceneCollectionManagerV2 sceneCollectionManager;
    private final MasterSceneCollectionManager masterSceneCollectionManager;
    private final ControllerManager controllerManager;

    public LightingSystemManager() {
        AllLampsLampGroup.instance.setLightingSystemManager(this);

        // local callback manager, not to be directly registered with ControllerClient
        sceneManagerCBV1 = new HelperSceneManagerCallbackV1(this);
        sceneWithSceneElementsManagerCB = new HelperSceneManagerCallbackV2(this);

        controllerClientCB = new HelperControllerClientCallback(this);
        controllerServiceManagerCB = new HelperControllerServiceManagerCallback(this);
        lampManagerCB = new HelperLampManagerCallback(this);
        groupManagerCB = new HelperGroupManagerCallback(this);
        presetManagerCB = new HelperPresetManagerCallback(this);
        transitionEffectManagerCB = new HelperTransitionEffectManagerCallback(this);
        pulseEffectManagerCB = new HelperPulseEffectManagerCallback(this);
        sceneElementManagerCB = new HelperSceneElementManagerCallback(this);
        masterSceneManagerCB = new HelperMasterSceneManagerCallback(this);
        // sceneManagerCB is a composition of the two different types of scenes
        sceneManagerCB = new HelperSceneManagerCallback(new SceneManagerCallback[] { sceneWithSceneElementsManagerCB, sceneManagerCBV1 });
        lampCollectionManager = new LampCollectionManager(this);
        groupCollectionManager = new GroupCollectionManager(this);
        presetCollectionManager = new PresetCollectionManager(this);
        transitionEffectCollectionManager = new TransitionEffectCollectionManager(this);
        pulseEffectCollectionManager = new PulseEffectCollectionManager(this);
        sceneElementCollectionManager = new SceneElementCollectionManager(this);
        sceneCollectionManagerV1 = new SceneCollectionManager(this);
        sceneCollectionManager = new SceneCollectionManagerV2(this);
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

    public void init(String applicationName, LightingSystemQueue queue, AllJoynListener alljoynListener) {
        setQueue(queue);

        AllJoynManager.init(
            applicationName,
            controllerClientCB,
            controllerServiceManagerCB,
            lampManagerCB,
            groupManagerCB,
            presetManagerCB,
            transitionEffectManagerCB,
            pulseEffectManagerCB,
            sceneElementManagerCB,
            sceneManagerCB,
            masterSceneManagerCB,
            new AboutManager(this),
            alljoynListener);
    }

    public void init(BusAttachment busAttachment, LightingSystemQueue queue, AllJoynListener alljoynListener) {
        setQueue(queue);

        AllJoynManager.init(
            busAttachment,
            controllerClientCB,
            controllerServiceManagerCB,
            lampManagerCB,
            groupManagerCB,
            presetManagerCB,
            transitionEffectManagerCB,
            pulseEffectManagerCB,
            sceneElementManagerCB,
            sceneManagerCB,
            masterSceneManagerCB,
            new AboutManager(this),
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

        AllJoynManager.destroy(queue);

        queue.post(new Runnable() {
            @Override
            public void run() {
                queue.stop();
            }
        });
    }

    protected void setQueue(LightingSystemQueue queue) {
        if (queue == null) {
            queue = new DefaultLightingSystemQueue();
        }

        if (this.queue != null) {
            this.queue.stop();
        }

        this.queue = queue;
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

    public TransitionEffectCollectionManager getTransitionEffectCollectionManager() {
        return transitionEffectCollectionManager;
    }

    public PulseEffectCollectionManager getPulseEffectCollectionManager() {
        return pulseEffectCollectionManager;
    }

    public SceneElementCollectionManager getSceneElementCollectionManager() {
        return sceneElementCollectionManager;
    }

    public SceneCollectionManager getSceneCollectionManagerV1() {
        return sceneCollectionManagerV1;
    }

    public SceneCollectionManagerV2 getSceneCollectionManager() {
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

    public TransitionEffectManager getTransitionEffectManager() {
        return AllJoynManager.transitionEffectManager;
    }

    public PulseEffectManager getPulseEffectManager() {
        return AllJoynManager.pulseEffectManager;
    }

    public SceneElementManager getSceneElementManager() {
        return AllJoynManager.sceneElementManager;
    }

    public SceneManager getSceneManager() {
        return AllJoynManager.sceneManager;
    }

    public MasterSceneManager getMasterSceneManager() {
        return AllJoynManager.masterSceneManager;
    }

    public void postOnNextControllerConnection(final NextControllerConnectionListener listener, final int delay) {
        postOnNextControllerConnection(new Runnable() {
            @Override
            public void run() {
                listener.onControllerConnected();
            }}, delay);
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
        transitionEffectCollectionManager.removeAllAdapters();
        pulseEffectCollectionManager.removeAllAdapters();
        sceneElementCollectionManager.removeAllAdapters();
        sceneCollectionManagerV1.removeAllAdapters();
        sceneCollectionManager.removeAllAdapters();
        masterSceneCollectionManager.removeAllAdapters();
    }
}
