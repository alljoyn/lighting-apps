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

import java.util.ArrayList;
import java.util.Collection;

import org.alljoyn.bus.BusAttachment;
import org.allseen.lsf.LampGroupManager;
import org.allseen.lsf.MasterSceneManager;
import org.allseen.lsf.PresetManager;
import org.allseen.lsf.PulseEffectManager;
import org.allseen.lsf.SceneElementManager;
import org.allseen.lsf.TransitionEffectManager;
import org.allseen.lsf.sdk.factory.AllLightingItemsFactory;
import org.allseen.lsf.sdk.listener.AllJoynListener;
import org.allseen.lsf.sdk.listener.LightingListener;
import org.allseen.lsf.sdk.listener.NextControllerConnectionListener;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.manager.ControllerCollectionManager;
import org.allseen.lsf.sdk.manager.GroupCollectionManager;
import org.allseen.lsf.sdk.manager.LampCollectionManager;
import org.allseen.lsf.sdk.manager.LightingSystemManager;
import org.allseen.lsf.sdk.manager.LightingSystemQueue;
import org.allseen.lsf.sdk.manager.MasterSceneCollectionManager;
import org.allseen.lsf.sdk.manager.PresetCollectionManager;
import org.allseen.lsf.sdk.manager.PulseEffectCollectionManager;
import org.allseen.lsf.sdk.manager.SceneCollectionManager;
import org.allseen.lsf.sdk.manager.SceneCollectionManagerV2;
import org.allseen.lsf.sdk.manager.SceneElementCollectionManager;
import org.allseen.lsf.sdk.manager.TransitionEffectCollectionManager;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.ControllerDataModel;
import org.allseen.lsf.sdk.model.GroupDataModel;
import org.allseen.lsf.sdk.model.LampDataModel;
import org.allseen.lsf.sdk.model.LightingItemFilter;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.MasterSceneDataModel;
import org.allseen.lsf.sdk.model.PresetDataModel;
import org.allseen.lsf.sdk.model.PulseEffectDataModelV2;
import org.allseen.lsf.sdk.model.SceneDataModel;
import org.allseen.lsf.sdk.model.SceneDataModelV2;
import org.allseen.lsf.sdk.model.SceneElementDataModelV2;
import org.allseen.lsf.sdk.model.TransitionEffectDataModelV2;

/**
 * LightingDirector is the main class in the Lighting SDK. It provides access
 * to instances of other SDK classes that represent active components in
 * the Lighting system.
 * <p>
 * Please see the LSFTutorial project for an example of how to use the
 * LightingDirector class.
 */
public class LightingDirector {
    public static final int MAX_GROUPS = LampGroupManager.MAX_LAMP_GROUPS;
    public static final int MAX_PRESETS = PresetManager.MAX_PRESETS;
    public static final int MAX_TRANSITION_EFFECTS = TransitionEffectManager.MAX_TRANSITION_EFFECTS;
    public static final int MAX_PULSE_EFFECTS = PulseEffectManager.MAX_PULSE_EFFECTS;
    public static final int MAX_SCENE_ELEMENTS = SceneElementManager.MAX_SCENE_ELEMENTS;
    public static final int MAX_SCENES = MasterSceneManager.MAX_MASTER_SCENES;
    public static final int MAX_MASTER_SCENES = MasterSceneManager.MAX_MASTER_SCENES;

    public static final int HUE_MIN = ColorStateConverter.VIEW_HUE_MIN;
    public static final int HUE_MAX = ColorStateConverter.VIEW_HUE_MAX;
    public static final int SATURATION_MIN = ColorStateConverter.VIEW_SATURATION_MIN;
    public static final int SATURATION_MAX = ColorStateConverter.VIEW_SATURATION_MAX;
    public static final int BRIGHTNESS_MIN = ColorStateConverter.VIEW_BRIGHTNESS_MIN;
    public static final int BRIGHTNESS_MAX = ColorStateConverter.VIEW_BRIGHTNESS_MAX;
    public static final int COLORTEMP_MIN = ColorStateConverter.VIEW_COLORTEMP_MIN;
    public static final int COLORTEMP_MAX = ColorStateConverter.VIEW_COLORTEMP_MAX;

    private static final String LANGUAGE_DEFAULT = "en";
    private static final LightingDirector instance = new LightingDirector();

    private final LightingSystemManager<Lamp, Group, Preset, TransitionEffect, PulseEffect, SceneElement, SceneV1, SceneV2, MasterScene, Controller, LightingItemErrorEvent> lightingManager;
    private String defaultLanguage;

    private boolean alljoynInitialized;
    private boolean networkConnected;

    private static class LightingItemFactory implements AllLightingItemsFactory<Lamp, Group, Preset, TransitionEffect, PulseEffect, SceneElement, SceneV1, SceneV2, MasterScene, Controller, LightingItemErrorEvent> {

        @Override
        public Lamp createLamp(String lampID) {
            return new Lamp(lampID);
        }

        @Override
        public Lamp[] createLamps(int size) {
            return new Lamp[size];
        }

        @Override
        public LampDataModel findLampDataModel(Lamp lamp) {
            return lamp != null ? lamp.getLampDataModel() : null;
        }

        @Override
        public Group createGroup(String groupID) {
            return new Group(groupID);
        }

        @Override
        public Group[] createGroups(int size) {
            return new Group[size];
        }

        @Override
        public GroupDataModel findGroupDataModel(Group group) {
            return group != null ? group.getGroupDataModel() : null;
        }

        @Override
        public Preset createPreset(String presetID) {
            return new Preset(presetID);
        }

        @Override
        public Preset[] createPresets(int size) {
            return new Preset[size];
        }

        @Override
        public PresetDataModel findPresetDataModel(Preset preset) {
            return preset != null ? preset.getPresetDataModel() : null;
        }

        @Override
        public TransitionEffect createTransitionEffect(String transitionEffectID) {
            return new TransitionEffect(transitionEffectID);
        }

        @Override
        public TransitionEffect[] createTransitionEffects(int size) {
            return new TransitionEffect[size];
        }

        @Override
        public TransitionEffectDataModelV2 findTransitionEffectDataModel(TransitionEffect transitionEffect) {
            return transitionEffect != null ? transitionEffect.getTransitionEffectDataModel() : null;
        }

        @Override
        public PulseEffect createPulseEffect(String pulseEffectID) {
            return new PulseEffect(pulseEffectID);
        }

        @Override
        public PulseEffect[] createPulseEffects(int size) {
            return new PulseEffect[size];
        }

        @Override
        public PulseEffectDataModelV2 findPulseEffectDataModel(PulseEffect pulseEffect) {
            return pulseEffect != null ? pulseEffect.getPulseEffectDataModel() : null;
        }

        @Override
        public SceneElement createSceneElement(String sceneElementID) {
            return new SceneElement(sceneElementID);
        }

        @Override
        public SceneElement[] createSceneElements(int size) {
            return new SceneElement[size];
        }

        @Override
        public SceneElementDataModelV2 findSceneElementDataModel(SceneElement sceneElement) {
            return sceneElement != null ? sceneElement.getSceneElementDataModel() : null;
        }

        @Override
        public SceneV1 createSceneV1(String sceneID) {
            return new SceneV1(sceneID);
        }

        @Override
        public SceneV1[] createScenesV1(int size) {
            return new SceneV1[size];
        }

        @Override
        public SceneDataModel findSceneDataModelV1(SceneV1 scene) {
            return scene.getSceneDataModel();
        }

        @Override
        public SceneV2 createSceneV2(String sceneID) {
            return new SceneV2(sceneID);
        }

        @Override
        public SceneV2[] createScenesV2(int size) {
            return new SceneV2[size];
        }

        @Override
        public SceneDataModelV2 findSceneDataModelV2(SceneV2 scene) {
            return scene.getSceneDataModel();
        }

        @Override
        public MasterScene createMasterScene(String masterSceneID) {
            return new MasterScene(masterSceneID);
        }

        @Override
        public MasterScene[] createMasterScenes(int size) {
            return new MasterScene[size];
        }

        @Override
        public MasterSceneDataModel findMasterSceneDataModel(MasterScene masterScene) {
            return masterScene.getMasterSceneDataModel();
        }

        @Override
        public Controller createController(String controllerID) {
            return new Controller();
        }

        @Override
        public Controller[] createControllers(int size) {
            return new Controller[size];
        }

        @Override
        public ControllerDataModel findControllerDataModel(Controller controller) {
            return controller.getControllerDataModel();
        }

        @Override
        public LightingItemErrorEvent createError(String name, ResponseCode responseCode, String itemID, TrackingID trackingID, ErrorCode[] errorCodes) {
            return new LightingItemErrorEvent(name, responseCode, itemID, trackingID, errorCodes);
        }
    };

    /**
     * Construct a LightingDirector instance.
     * <p>
     * Note that the start() method must be called at some point after
     * construction when you're ready to begin working with the Lighting system.
     *
     * @return The LightingDirector instance.
     */
    public static LightingDirector get() {
        return LightingDirector.instance;
    }

    /*
     * Construct a LightingDirector instance with the default queue.
     *
     * Note that this is private since LightingDirector is a singleton. See
     * LightingDirector.get()
     */
    private LightingDirector() {
        super();
        lightingManager    = new LightingSystemManager<Lamp, Group, Preset, TransitionEffect, PulseEffect, SceneElement, SceneV1, SceneV2, MasterScene, Controller, LightingItemErrorEvent>(new LightingItemFactory());
        defaultLanguage    = LANGUAGE_DEFAULT;
        networkConnected   = false;
        alljoynInitialized = false;
    }

    /**
     * The version number of the interface provided by this class.
     *
     * @return The version number
     */
    public int getVersion() {
        return 2;
    }

    /**
     * Causes the LightingDirector to start interacting with the Lighting
     * system. This method will create its own BusAttachment and default
     * LightingSystemQueue since none are provided.
     * <p>
     * Note: start() should be called before interacting with the Lighting
     * Director. Subsequent calls to start() must each be preceded by a call
     * to stop().
     * <p>
     * Note: you should make sure a WiFi or other network connection is
     * available before calling this method.
     */
    public void start() {
        start("LightingDirector");
    }

    /**
     * Causes the LightingDirector to start interacting with the Lighting system
     * using the specified application name. This method uses the application
     * name when creating the AllJoyn bus attachment.
     * <p>
     * Note: start() should be called before interacting with the Lighting
     * Director. Subsequent calls to start() must each be preceded by a call
     * to stop().
     * <p>
     * Note: you should make sure a WiFi or other network connection is
     * available before calling this method.
     *
     * @param applicationName
     *            The name used to create the AllJoyn bus attachment. See the
     *            AllJoyn core documentation for more information on bus
     *            attachments.
     */
    public void start(String applicationName) {
        start(applicationName, null);
    }

    /**
     * Causes the LightingDirector to start interacting with the Lighting system
     * using the specified AllJoyn bus attachment. In this method, the application
     * name is not necessary since a bus attachment is passed in directly.
     * <p>
     * Note: start() should be called before interacting with the Lighting
     * Director. Subsequent calls to start() must each be preceded by a call
     * to stop().
     * <p>
     * Note: you should make sure a WiFi or other network connection is
     * available before calling this method.
     *
     * @param busAttachment
     *            The AllJoyn bus attachment to use. See the AllJoyn core
     *            documentation for more information on bus attachments.
     */
    public void start(BusAttachment busAttachment) {
        start(busAttachment, null);
    }

    /**
     * Causes the LightingDirector to start interacting with the Lighting system
     * using the specified application name and dispatch queue. The passed in
     * application name will be used in creating an AllJoyn BusAttachment.
     * <p>
     * Note: start() should be called before interacting with the Lighting
     * Director. Subsequent calls to start() must each be preceded by a call
     * to stop().
     * <p>
     * Note: you should make sure a WiFi or other network connection is
     * available before calling this method.
     *
     * @param applicationName
     *            The name used to create the AllJoyn bus attachment. See the
     *            AllJoyn core documentation for more information on bus
     *            attachments.
     * @param queue
     *            The queue that will be used to handle all lighting events. The
     *            framework will process internal tasks and invoke the client
     *            listeners from the thread associated with this queue.
     */
    public void start(String applicationName, LightingSystemQueue queue) {
        lightingManager.init(applicationName, queue, createAllJoynListener());
    }

    /**
     * Causes the LightingDirector to start interacting with the Lighting system
     * using the specified AllJoyn bus attachment and dispatch queue.
     * <p>
     * Note: start() should be called before interacting with the Lighting
     * Director. Subsequent calls to start() must each be preceded by a call
     * to stop().
     * <p>
     * Note: you should make sure a WiFi or other network connection is
     * available before calling this method.
     *
     * @param busAttachment
     *            The AllJoyn bus attachment to use. See the AllJoyn core
     *            documentation for more information on bus attachments.
     * @param queue
     *            The queue that will be used to handle all lighting events. The
     *            framework will process internal tasks and invoke the client
     *            listeners from the thread associated with this queue.
     */
    public void start(BusAttachment busAttachment, LightingSystemQueue queue) {
        lightingManager.init(busAttachment, queue, createAllJoynListener());
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected AllJoynListener createAllJoynListener() {
        return new AllJoynListener() {
            @Override
            public void onAllJoynInitialized() {
                alljoynInitialized = true;

                if (networkConnected) {
                    lightingManager.start();
                }
            }
        };
    }

    /**
     * Causes the LightingDirector to stop interacting with the Lighting system.
     */
    public void stop() {
        lightingManager.destroy();
    }

    public void setNetworkConnectionStatus(boolean isConnected) {
        if (alljoynInitialized) {
            if (!isConnected) {
                lightingManager.stop();
            } else if (!networkConnected) {
                lightingManager.stop();
                lightingManager.start();
            }
        }

        networkConnected = isConnected;
    }

    /**
     * Returns the AllJoyn BusAttachment object being used to connect to the
     * Lighting system.
     * <p>
     * The BusAttachment will be <code>null</code> until some time after the call to start().
     *
     * @return The BusAttachment object
     */
    public BusAttachment getBusAttachment() {
        return AllJoynManager.bus;
    }

    /**
     * Returns the number of active Lamps in the Lighting system including
     * lamps that may not have received all data from the controller.
     *
     * @return The number of active Lamps
     */
    public int getLampCount() {
        return getLampCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active Lamps in the Lighting system including
     * lamps that may not have received all data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new lamps are discovered or existing lamps are determined to be
     * offline. This array may be empty.
     *
     * @return An array of active Lamps
     */
    public Lamp[] getLamps() {
        return getLampCollectionManager().getLamps();
    }

    /**
     * Returns the Lamp instances corresponding to the set of lamp IDs. If a
     * Lamp corresponding to a lamp ID is not found, then it is not included
     * in the returned array. The returned array may be empty.
     *
     * @param lampIDs The IDs of the Lamps to retrieve
     *
     * @return An array of Lamps
     */
    public Lamp[] getLamps(Collection<String> lampIDs) {
        return getLampCollectionManager().getLamps(new LightingItemIDCollectionFilter<Lamp>(lampIDs));
    }

    /**
     * Returns a snapshot of the active Lamps in the Lighting system that have
     * received all the data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new lamps are discovered or existing lamps are determined to be
     * offline. This array may be empty.
     *
     * @return Array of active Lamps
     */
    public Lamp[] getInitializedLamps() {
        return getLampCollectionManager().getLamps(new LightingItemInitializedFilter<Lamp>());
    }

    /**
     * Returns an instance of the Lamp with the corresponding lamp ID. If a
     * Lamp corresponding to the lamp ID is not found, then this method will
     * return null.
     *
     * @param lampId The ID of the Lamp
     *
     * @return Instance of Lamp or null if Lamp does not exist.
     */
    public Lamp getLamp(String lampId) {
        return getLampCollectionManager().getLamp(lampId);
    }

    /**
     * Returns the number of active Groups in the Lighting system including
     * groups that may not have received all data from the controller.
     *
     * @return The number of active Groups
     */
    public int getGroupCount() {
        return getGroupCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active Group definitions in the Lighting
     * system including groups that may not have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new groups are created or existing groups are deleted. This array may
     * be empty.
     *
     * @return An array of active Groups
     */
    public Group[] getGroups() {
        return getGroupCollectionManager().getGroups();
    }

    /**
     * Returns the Group instances corresponding to the set of group IDs. If a
     * Group corresponding to a group ID is not found, then it is not included
     * in the returned array. The returned array may be empty.
     *
     * @param groupIDs The IDs of the Groups to retrieve
     *
     * @return An array of Groups
     */
    public Group[] getGroups(Collection<String> groupIDs) {
        return getGroupCollectionManager().getGroups(new LightingItemIDCollectionFilter<Group>(groupIDs));
    }

    /**
     * Returns a snapshot of the active Groups definitions in the Lighting
     * system that have received all the data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new groups are discovered or existing groups are determined to be
     * offline. This array may be empty.
     *
     * @return Array of active Groups
     */
    public Group[] getInitializedGroups() {
        return getGroupCollectionManager().getGroups(new LightingItemInitializedFilter<Group>());
    }

    /**
     * Returns an instance of the Group with the corresponding group ID. If a
     * Group corresponding to the group ID is not found, then this method will
     * return null.
     *
     * @param groupId The ID of the Group
     *
     * @return Instance of Group or null if Group does not exist.
     */
    public Group getGroup(String groupId) {
        return getGroupCollectionManager().getGroup(groupId);
    }

    /**
     * Returns the number of active Presets in the Lighting system including
     * presets that may not have received all data from the controller.
     *
     * @return The number of active Presets
     */
    public int getPresetCount() {
        return getPresetCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active Preset definitions in the Lighting
     * system including presets that may not have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new preset are created or existing presets are deleted. This array may
     * be empty.
     *
     * @return An array of active Presets
     */
    public Preset[] getPresets() {
        return getPresetCollectionManager().getPresets();
    }

    /**
     * Returns the Preset instances corresponding to the set of preset IDs. If a
     * Preset corresponding to a preset ID is not found, then it is not included
     * in the returned array. The returned array may be empty.
     *
     * @param presetIDs The IDs of the Presets to retrieve
     *
     * @return An array of Presets
     */
    public Preset[] getPresets(Collection<String> presetIDs) {
        return getPresetCollectionManager().getPresets(new LightingItemIDCollectionFilter<Preset>(presetIDs));
    }

    /**
     * Returns a snapshot of the active Preset definitions the have received all
     * data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new preset are created or existing presets are deleted. This array may
     * be empty.
     *
     * @return An array of active Presets
     */
    public Preset[] getInitializedPresets() {
        return getPresetCollectionManager().getPresets(new LightingItemInitializedFilter<Preset>());
    }

    /**
     * Returns an instance of the Preset with the corresponding preset ID. If a
     * Preset corresponding to the preset ID is not found, then this method will
     * return null.
     *
     * @param presetId The ID of the Preset
     *
     * @return Instance of Preset or null if Preset does not exist.
     */
    public Preset getPreset(String presetId) {
        return getPresetCollectionManager().getPreset(presetId);
    }

    /**
     * Returns the number of active TransitionEffects in the Lighting system
     * including transition effects that may not have received all data from
     * the controller.
     *
     * @return The number of active TransitionEffects
     */
    public int getTransitionEffectCount() {
        return getTransitionEffectCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active TransitionEffect definitions in the Lighting
     * system including transition effects that may not have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new transition effect are created or existing transition effects are
     * deleted. This array may be empty.
     *
     * @return An array of active TransitionEffects
     */
    public TransitionEffect[] getTransitionEffects() {
        return getTransitionEffectCollectionManager().getTransitionEffects();
    }

    /**
     * Returns the TransitionEffect instances corresponding to the set of transition effect
     * IDs. If a TransitionEffect corresponding to a transition effect ID is not found, then
     * it is not included in the returned array. The returned array may be empty.
     *
     * @param transitionEffectIDs The IDs of the TransitionEffects to retrieve
     *
     * @return An array of TransitionEffects
     */
    public TransitionEffect[] getTransitionEffects(Collection<String> transitionEffectIDs) {
        return getTransitionEffectCollectionManager().getTransitionEffects(new LightingItemIDCollectionFilter<TransitionEffect>(transitionEffectIDs));
    }

    /**
     * Returns a snapshot of the active TransitionEffect definitions in the Lighting
     * system that have received all data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new transition effect are created or existing transition effects are
     * deleted. This array may be empty.
     *
     * @return An array of active TransitionEffects
     */
    public TransitionEffect[] getInitializedTransitionEffects() {
        return getTransitionEffectCollectionManager().getTransitionEffects(new LightingItemInitializedFilter<TransitionEffect>());
    }

    /**
     * Returns an instance of the TransistionEffect with the corresponding
     * transition effect ID. If a TransitionEffect corresponding to the
     * transition effect ID does not exist, then this method will return null.
     *
     * @param transitionEffectId The ID of the TransitionEffect
     *
     * @return Instance of TransitionEffect or null if TransitionEffect does not exist.
     */
    public TransitionEffect getTransitionEffect(String transitionEffectId) {
        return getTransitionEffectCollectionManager().getTransistionEffect(transitionEffectId);
    }

    /**
     * Returns the number of active PulseEffects in the Lighting system
     * including pulse effects that may not have received all data from
     * the controller.
     *
     * @return The number of active PulseEffects
     */
    public int getPulseEffectCount() {
        return getPulseEffectCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active PulseEffect definitions in the Lighting
     * system including pulse effects that may not have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new pulse effect are created or existing pulse effects are
     * deleted. This array may be empty.
     *
     * @return An array of active PulseEffects
     */
    public PulseEffect[] getPulseEffects() {
        return getPulseEffectCollectionManager().getPulseEffects();
    }

    /**
     * Returns the PulseEffect instances corresponding to the set of pulse effect
     * IDs. If a PulseEffect corresponding to a pulse effect ID is not found, then
     * it is not included in the returned array. The returned array may be empty.
     *
     * @param pulseEffectIDs The IDs of the PulseEffects to retrieve
     *
     * @return An array of PulseEffects
     */
    public PulseEffect[] getPulseEffects(Collection<String> pulseEffectIDs) {
        return getPulseEffectCollectionManager().getPulseEffects(new LightingItemIDCollectionFilter<PulseEffect>(pulseEffectIDs));
    }

    /**
     * Returns a snapshot of the active PulseEffect definitions in the Lighting
     * system that have received all data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new pulse effect are created or existing pulse effects are
     * deleted. This array may be empty.
     *
     * @return An array of active PulseEffects
     */
    public PulseEffect[] getInitializedPulseEffects() {
        return getPulseEffectCollectionManager().getPulseEffects(new LightingItemInitializedFilter<PulseEffect>());
    }

    /**
     * Returns an instance of the PulseEffect with the corresponding
     * pulse effect ID. If a PulseEffect corresponding to the pulse effect ID
     * does not exist, then this method will return null.
     *
     * @param pulseEffectId The ID of the PulseEffect
     *
     * @return Instance of PulseEffect or null if PulseEffect does not exist
     */
    public PulseEffect getPulseEffect(String pulseEffectId) {
        return getPulseEffectCollectionManager().getPulseEffect(pulseEffectId);
    }

    /**
     * Returns the number of active SceneElements in the Lighting system
     * including scene elements that may not have received all data from
     * the controller.
     *
     * @return The number of active SceneElements
     */
    public int getSceneElementCount() {
        return getSceneElementCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active SceneElement definitions in the Lighting
     * system including scene elements that may not have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new scene elements are created or existing scene elements are
     * deleted. This array may be empty.
     *
     * @return An array of active SceneElements
     */
    public SceneElement[] getSceneElements() {
        return getSceneElementCollectionManager().getSceneElements();
    }

    /**
     * Returns the SceneElement instances corresponding to the set of scene element
     * IDs. If a SceneElement corresponding to a scene element ID is not found, then
     * it is not included in the returned array. The returned array may be empty.
     *
     * @param sceneElementIDs The IDs of the SceneElements to retrieve
     *
     * @return An array of SceneElements
     */
    public SceneElement[] getSceneElements(Collection<String> sceneElementIDs) {
        return getSceneElementCollectionManager().getSceneElements(new LightingItemIDCollectionFilter<SceneElement>(sceneElementIDs));
    }

    /**
     * Returns a snapshot of the active SceneElement definitions in the Lighting
     * system that have received all data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new scene elements are created or existing scene elements are
     * deleted. This array may be empty.
     *
     * @return An array of active SceneElements
     */
    public SceneElement[] getInitializedSceneElements() {
        return getSceneElementCollectionManager().getSceneElements(new LightingItemInitializedFilter<SceneElement>());
    }

    /**
     * Returns an instance of the SceneElement with the corresponding
     * scene element ID. If a SceneElement corresponding to the scene element
     * ID does not exist, then this method will return null.
     *
     * @param sceneElementId The ID of the SceneElement
     *
     * @return Instance of SceneElement or null if SceneElement does not exist.
     */
    public SceneElement getSceneElement(String sceneElementId) {
        return getSceneElementCollectionManager().getSceneElement(sceneElementId);
    }

    /**
     * Returns the number of active Scenes in the Lighting system
     * including scenes that may not have received all data from
     * the controller.
     *
     * @return The number of active Scenes
     */
    public int getSceneCount() {
        int count = getSceneCollectionManagerV2().size();

        if (count == 0) {
            count = getSceneCollectionManager().size();
        }

        return count;
    }

    /**
     * Returns a snapshot of the active Scene definitions in the Lighting
     * system including scenes that may not have received all data from
     * the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new scenes are created or existing scenes are deleted. This array may
     * be empty.
     *
     * @return An array of active Scenes
     */
    public Scene[] getScenes() {
        Collection<Scene> scenes = new ArrayList<Scene>(getSceneCount());

        scenes.addAll(getSceneCollectionManagerV2().getScenesCollection(null));

        if (scenes.size() == 0) {
            scenes.addAll(getSceneCollectionManager().getScenesCollection(null));
        }

        return scenes.toArray(new Scene[scenes.size()]);
    }

    /**
     * Returns the Scene instances corresponding to the set of scene IDs.
     * If a Scene corresponding to a scene ID is not found, then it is
     * not included in the returned array. The returned array may be empty.
     *
     * @param sceneIDs The IDs of the Scenes to retrieve
     *
     * @return An array of Scenes
     */
    public Scene[] getScenes(Collection<String> sceneIDs) {
        Scene[] scenes = getSceneCollectionManagerV2().getScenes(new LightingItemIDCollectionFilter<SceneV2>(sceneIDs));

        if (scenes == null || scenes.length == 0) {
            scenes = getSceneCollectionManager().getScenes(new LightingItemIDCollectionFilter<SceneV1>(sceneIDs));
        }

        return scenes;
    }

    /**
     * Returns a snapshot of the active Scene definitions in the Lighting
     * system that received all data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new scenes are created or existing scenes are deleted. This array may
     * be empty.
     *
     * @return An array of active Scenes
     */
    public Scene[] getInitializedScenes() {
        Collection<Scene> scenes = new ArrayList<Scene>(getSceneCount());

        scenes.addAll(getSceneCollectionManager().getScenesCollection(new LightingItemInitializedFilter<SceneV1>()));

        if (scenes.size() == 0) {
            scenes.addAll(getSceneCollectionManagerV2().getScenesCollection(new LightingItemInitializedFilter<SceneV2>()));
        }

        return scenes.toArray(new Scene[scenes.size()]);
    }

    /**
     * Returns an instance of the Scene with the corresponding
     * scene ID.  If a Scene corresponding to the scene ID does not exists,
     * then this method will return null.
     *
     * @param sceneId The ID of the Scene
     *
     * @return Instance of Scene or null if Scene does not exist.
     */
    public Scene getScene(String sceneId) {
        Scene scene = getSceneCollectionManagerV2().getScene(sceneId);

        return scene == null ? getSceneCollectionManager().getScene(sceneId) : scene;
    }

    /**
     * Returns the number of active MasterScenes in the Lighting system
     * including master scenes that may not have received all data from
     * the controller.
     *
     * @return The number of active MasterScenes
     */
    public int getMasterSceneCount() {
        return getMasterSceneCollectionManager().size();
    }

    /**
     * Returns a snapshot of the active MasterScene definitions in the Lighting
     * system including master scenes that may not have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new master scenes are created or existing master scenes are
     * deleted. This array may be empty.
     *
     * @return An array of active MasterScenes
     */
    public MasterScene[] getMasterScenes() {
        return getMasterSceneCollectionManager().getMasterScenes();
    }

    /**
     * Returns the MasterScene instances corresponding to the set of master scene IDs.
     * If a MasterScene corresponding to a master scene ID is not found, then it is
     * not included in the returned array. The returned array may be empty.
     *
     * @param masterSceneIDs The IDs of the MasterScenes to retrieve
     *
     * @return An array of MasterScenes
     */
    public MasterScene[] getMasterScenes(Collection<String> masterSceneIDs) {
        return getMasterSceneCollectionManager().getMasterScenes(new LightingItemIDCollectionFilter<MasterScene>(masterSceneIDs));
    }

    /**
     * Returns a snapshot of the active MasterScene definitions in the Lighting
     * system that have received all data from the
     * controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new master scenes are created or existing master scenes are
     * deleted. This array may be empty.
     *
     * @return An array of active MasterScenes
     */
    public MasterScene[] getInitializedMasterScenes() {
        return getMasterSceneCollectionManager().getMasterScenes(new LightingItemInitializedFilter<MasterScene>());
    }

    /**
     * Returns an instance of the MasterScene with the corresponding
     * master scene ID. If a MasterScene corresponding to the master
     * scene ID does not exist, then this method will return null.
     *
     * @param masterSceneId The ID of the MasterScene
     *
     * @return Instance of MasterScene or null if MasterScene does not exist
     */
    public MasterScene getMasterScene(String masterSceneId) {
        return getMasterSceneCollectionManager().getMasterScene(masterSceneId);
    }

    public int getEffectCount() {
        return getPresetCount() + getTransitionEffectCount() + getPulseEffectCount();
    }

    public Effect[] getEffects() {
        return getEffects(null);
    }

    public Effect[] getEffects(Collection<String> effectIDs) {
        return getEffects(new LightingItemIDCollectionFilter<Preset>(effectIDs), new LightingItemIDCollectionFilter<TransitionEffect>(effectIDs), new LightingItemIDCollectionFilter<PulseEffect>(effectIDs));
    }

    public Effect[] getInitializedEffects() {
        return getEffects(new LightingItemInitializedFilter<Preset>(), new LightingItemInitializedFilter<TransitionEffect>(), new LightingItemInitializedFilter<PulseEffect>());
    }

    public Effect getEffect(String effectID) {
        Effect effect = getPreset(effectID);

        if (effect == null) {
            effect = getTransitionEffect(effectID);
        }

        if (effect == null) {
            effect = getPulseEffect(effectID);
        }

        return effect;
    }

    protected Effect[] getEffects(LightingItemFilter<Preset> presetFilter, LightingItemFilter<TransitionEffect> transitionEffectFilter, LightingItemFilter<PulseEffect> pulseEffectFilter) {
        Collection<Effect> effects = new ArrayList<Effect>();

        effects.addAll(getPresetCollectionManager().getPresetsCollection(presetFilter));
        effects.addAll(getTransitionEffectCollectionManager().getTransitionEffectsCollection(transitionEffectFilter));
        effects.addAll(getPulseEffectCollectionManager().getPulseEffectsCollection(pulseEffectFilter));

        return effects.toArray(new Effect[effects.size()]);
    }

    //TODO-DOC
    public Controller getLeadController() {
        return getControllerManager().getLeader();
    }

    /**
     * Specifies a listener to invoke once a connection to a lighting system has
     * been established. After a connection is established, this listener will
     * be invoked only one time.
     * <p>
     * This allows clients of the LightingDirector to be notified once a
     * connection has been established.
     *
     * @param listener
     *            The listener to invoke on connection
     * @param delay
     *            Specifies a delay between when a connection occurs and when
     *            the listener should be invoked
     */
    public void postOnNextControllerConnection(final NextControllerConnectionListener listener, final int delay) {
        lightingManager.postOnNextControllerConnection(listener, delay);
    }

    /**
     * Specifies a task to run once a connection to a lighting system has been
     * established. After a connection is established, this task will be run
     * only one time.
     * <p>
     * This allows clients of the LightingDirector to be notified once a
     * connection has been established.
     *
     * @param task
     *            The task to run on connection
     * @param delay
     *            Specifies a delay between when a connection occurs and when
     *            the task should be run
     */
    public void postOnNextControllerConnection(Runnable task, int delay) {
        lightingManager.postOnNextControllerConnection(task, delay);
    }

    /**
     * Asynchronously creates a Group on the Lighting Controller.
     *
     * @param members
     *            Array of GroupMember
     * @param groupName
     *            Name of the Group
     * @param listener
     *            Specifies the callback that's invoked only for the Group being created.
     *
     * @return TrackingID associated with the creation of the Group
     */
    public TrackingID createGroup(GroupMember[] members, String groupName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        AllJoynManager.groupManager.createLampGroupWithTracking(
                trackingId,
                GroupMember.createLampGroup(members),
                groupName,
                getDefaultLanguage());

        return trackingId;
    }

    /**
     * Asynchronously creates a Preset on the Lighting Controller.
     *
     * @param power
     *            Specifies the Power of the Preset's lamp state
     * @param color
     *            Specifies the Color of the Preset's lamp state
     * @param presetName
     *            Name of the Preset
     * @param listener
     *            Specifies the callback that's invoked only for the Preset being created.
     *
     * @return TrackingID associated with the create of the Preset
     */
    public TrackingID createPreset(Power power, Color color, String presetName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        AllJoynManager.presetManager.createPresetWithTracking(trackingId, LightingItemUtil.createLampStateFromView(
                power == Power.ON, color.getHue(), color.getSaturation(), color.getBrightness(), color.getColorTemperature()),
                presetName, getDefaultLanguage());

        return trackingId;
    }

    /**
     * Asynchronously creates a TransitionEffect on the Lighting Controller.
     *
     * @param state
     *            Specifies the lamp state of the TransitionEffect
     * @param duration
     *            Specifies how long the TransitionEffect will take
     * @param effectName
     *            Name of the TransitionEffect
     * @param listener
     *            Specifies a callback that's invoked only for the TransitionEffect being created
     *
     * @return TrackingID associated with the creation of the TransitionEffect
     */
    public TrackingID createTransitionEffect(LampState state, long duration, String effectName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        if (state instanceof Preset) {
            AllJoynManager.transitionEffectManager.createTransitionEffect(trackingId,
                    LightingItemUtil.createTransitionEffect(((Preset)state).getPresetDataModel(), duration), effectName, getDefaultLanguage());
        } else {
            AllJoynManager.transitionEffectManager.createTransitionEffect(trackingId,
                    LightingItemUtil.createTransitionEffect(state.getPowerOn(), state.getColorHsvt(), duration),
                    effectName, getDefaultLanguage());
        }

        return trackingId;
    }

    /**
     * Asynchronously creates a PulseEffect on the Lighting Controller.
     *
     * @param fromState
     *            Specifies the starting LampState of the PulseEffect
     * @param toState
     *            Specifies the ending LampState of the PulseEffect
     * @param period
     *            Specifies the period of the pulse (in ms). Period refers to the time duration between the start of two pulses
     * @param duration
     *            Specifies the duration of a single pulse (in ms). This must be less than the period
     * @param count
     *            Specifies the number of pulses
     * @param effectName
     *            Name of the PulseEffect
     * @param listener
     *            Specifies a callback that's invoked only for the PulseEffect being created
     *
     * @return TrackingID associated with the creation of the PulseEffect
     */
    public TrackingID createPulseEffect(LampState fromState, LampState toState, long period, long duration, long count, String effectName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        if (fromState instanceof Preset && toState instanceof Preset) {
            AllJoynManager.pulseEffectManager.createPulseEffect(trackingId,
                    LightingItemUtil.createPulseEffect(((Preset)fromState).getPresetDataModel(), ((Preset)toState).getPresetDataModel(), period, duration, count),
                    effectName, getDefaultLanguage());
        } else {
            AllJoynManager.pulseEffectManager.createPulseEffect(trackingId,
                    LightingItemUtil.createPulseEffect(fromState.getPowerOn(), fromState.getColorHsvt(), toState.getPowerOn(), toState.getColorHsvt(), period, duration, count),
                    effectName, getDefaultLanguage());
        }

        return trackingId;
    }

    /**
     * Asynchronously creates a SceneElement on the Lighting Controller.
     *
     * @param effect
     *            Specifies the SceneElement's effect
     * @param members
     *            Specifies the GroupMembers for which the effect will be applied
     * @param sceneElementName
     *            Name of the SceneElement
     * @param listener
     *            Specifies the callback that's invoked only for the scene element being created
     *
     * @return TrackingID associated with the creation of the SceneElement
     */
    public TrackingID createSceneElement(Effect effect, GroupMember[] members, String sceneElementName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        AllJoynManager.sceneElementManager.createSceneElement(
                trackingId,
                LightingItemUtil.createSceneElement(effect.getId(), GroupMember.createLampGroup(members)),
                sceneElementName,
                getDefaultLanguage());

        return trackingId;
    }

    /**
     * Asynchronously creates a Scene on the Lighting Controller.
     *
     * @param sceneElements
     *            Specifies the SceneElements that belong to the Scene
     * @param sceneName
     *            Name of the Scene
     * @param listener
     *            Specifies a callback that's invoked only for the Scene being created
     *
     * @return TrackingID associated with the creation of the Scene
     */
    public TrackingID createScene(SceneElement[] sceneElements, String sceneName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        String[] sceneElementIds = new String[sceneElements.length];
        for (int i = 0; i < sceneElements.length; i++) {
            sceneElementIds[i] = sceneElements[i].getId();
        }

        AllJoynManager.sceneManager.createSceneWithSceneElements(trackingId, LightingItemUtil.createSceneWithSceneElements(sceneElementIds), sceneName, getDefaultLanguage());

        return trackingId;
    }

    /**
     * Asynchronously creates a MasterScene on the Lighting Controller.
     *
     * @param scenes
     *            Specifies the Scenes that belong to the MasterScene
     * @param masterSceneName
     *            Name of the MasterScene
     * @param listener
     *            Specifies a callback that's invoked only for the MasterScene being created.
     *
     * @return TrackingID associate with the creation of the MasterScene
     */
    public TrackingID createMasterScene(Scene[] scenes, String masterSceneName) {
        TrackingID trackingId = new TrackingID(TrackingID.UNDEFINED);

        String[] sceneIds = new String[scenes.length];
        for (int i = 0; i < scenes.length; i++) {
            sceneIds[i] = scenes[i].getId();
        }

        AllJoynManager.masterSceneManager.createMasterSceneWithTracking(trackingId, LightingItemUtil.createMasterScene(sceneIds), masterSceneName, getDefaultLanguage());

        return trackingId;
    }

    /**
     * Adds a global listener to receive all Lighting System events associated
     * with the provided listener. Multiple listeners are supported.
     * <p>
     * @param listener
     *            The listener that received Lighting System events.
     */
    public void addListener(LightingListener listener) {
        if (listener instanceof LampListener) {
            addLampListener((LampListener) listener);
        }

        if (listener instanceof GroupListener) {
            addGroupListener((GroupListener) listener);
        }

        if (listener instanceof PresetListener) {
            addPresetListener((PresetListener) listener);
        }

        if (listener instanceof TransitionEffectListener) {
            addTransitionEffectListener((TransitionEffectListener) listener);
        }

        if (listener instanceof PulseEffectListener) {
            addPulseEffectListener((PulseEffectListener) listener);
        }

        if (listener instanceof SceneElementListener) {
            addSceneElementListener((SceneElementListener) listener);
        }

        if (listener instanceof SceneListener) {
            addSceneListener((SceneListener) listener);
        }

        if (listener instanceof MasterSceneListener) {
            addMasterSceneListener((MasterSceneListener) listener);
        }

        if (listener instanceof ControllerListener) {
            addControllerListener((ControllerListener) listener);
        }
    }

    /**
     * Adds a global listener to receive all Lamp events.
     *
     * @param listener
     *            The listener to receive all Lamp events.
     */
    public void addLampListener(LampListener listener) {
        getLampCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all Group events.
     *
     * @param listener
     *            The listener to receive all Group events.
     */
    public void addGroupListener(GroupListener listener) {
        getGroupCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all Preset events.
     *
     * @param listener
     *            The listener to receive all Preset events.
     */
    public void addPresetListener(PresetListener listener) {
        getPresetCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all TransitionEffect events.
     *
     * @param listener
     *            The listener to receive all TransitionEffect events.
     */
    public void addTransitionEffectListener(TransitionEffectListener listener) {
        getTransitionEffectCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all PulseEffect events.
     *
     * @param listener
     *            The listener to receive all PulseEffect events.
     */
    public void addPulseEffectListener(PulseEffectListener listener) {
        getPulseEffectCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all SceneElement events.
     *
     * @param listener
     *            The listener to receive all SceneElement events.
     */
    public void addSceneElementListener(SceneElementListener listener) {
        getSceneElementCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all Scene events.
     *
     * @param listener
     *            The listener to receive all Scene events.
     */
    public void addSceneListener(SceneListener listener) {
        getSceneCollectionManager().addListener(listener);
        getSceneCollectionManagerV2().addListener(listener);
    }

    /**
     * Adds a global listener to receive all MasterScene events.
     *
     * @param listener
     *            The listener to receive all MasterScene events.
     */
    public void addMasterSceneListener(MasterSceneListener listener) {
        getMasterSceneCollectionManager().addListener(listener);
    }

    /**
     * Adds a global listener to receive all Controller events.
     *
     * @param listener
     *            The listener to receive all Controller events.
     */
    public void addControllerListener(ControllerListener listener) {
        getControllerManager().addListener(listener);
    }

    /**
     * Removes a global listener that receives all Lighting System events
     * associated with the provided listener.
     *
     * @param listener
     *            The listener that receives Lighting System events.
     */
    public void removeListener(LightingListener listener) {
        if (listener instanceof LampListener) {
            removeLampListener((LampListener) listener);
        }

        if (listener instanceof GroupListener) {
            removeGroupListener((GroupListener) listener);
        }

        if (listener instanceof PresetListener) {
            removePresetListener((PresetListener) listener);
        }

        if (listener instanceof TransitionEffectListener) {
            removeTransitionEffectListener((TransitionEffectListener) listener);
        }

        if (listener instanceof PulseEffectListener) {
            removePulseEffectListener((PulseEffectListener) listener);
        }

        if (listener instanceof SceneElementListener) {
            removeSceneElementListener((SceneElementListener) listener);
        }

        if (listener instanceof SceneListener) {
            removeSceneListener((SceneListener) listener);
        }

        if (listener instanceof MasterSceneListener) {
            removeMasterSceneListener((MasterSceneListener) listener);
        }

        if (listener instanceof ControllerListener) {
            removeControllerListener((ControllerListener) listener);
        }
    }

    /**
     * Removes a global listener that receives all Lamp events.
     *
     * @param listener
     *            The listener that receives all Lamp events.
     */
    public void removeLampListener(LampListener listener) {
        getLampCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all Group events.
     *
     * @param listener
     *            The listener that receives all Group events.
     */
    public void removeGroupListener(GroupListener listener) {
        getGroupCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all Preset events.
     *
     * @param listener
     *            The listener that receives all Preset events.
     */
    public void removePresetListener(PresetListener listener) {
        getPresetCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all TransitionEffect events.
     *
     * @param listener
     *            The listener that receives all TransitionEffect events.
     */
    public void removeTransitionEffectListener(TransitionEffectListener listener) {
        getTransitionEffectCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all PulseEffect events.
     *
     * @param listener
     *            The listener that receives all PulseEffect events.
     */
    public void removePulseEffectListener(PulseEffectListener listener) {
        getPulseEffectCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all SceneElement events.
     *
     * @param listener
     *            The listener that receives all SceneElement events.
     */
    public void removeSceneElementListener(SceneElementListener listener) {
        getSceneElementCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all Scene events.
     *
     * @param listener
     *            The listener that receives all Scene events.
     */
    public void removeSceneListener(SceneListener listener) {
        getSceneCollectionManager().removeListener(listener);
        getSceneCollectionManagerV2().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all MasterScene events.
     *
     * @param listener
     *            The listener that receives all MasterScene events.
     */
    public void removeMasterSceneListener(MasterSceneListener listener) {
        getMasterSceneCollectionManager().removeListener(listener);
    }

    /**
     * Removes a global listener that receives all Controller events.
     *
     * @param listener
     *            The listener that receives all Controller events.
     */
    public void removeControllerListener(ControllerListener listener) {
        getControllerManager().removeListener(listener);
    }

    /**
     * Sets the default language used by the Lighting System.
     * <p>
     * If this method is never called, the default language is English ("en")
     *
     * @param language
     *            The language tag specifying the default language
     */
    public void setDefaultLanguage(String language) {
        if (language != null) {
            defaultLanguage = language;
        }
    }

    /**
     * Gets the default language used by the Lighting System.
     *
     * @return The language tag specifying the default language
     */
    public String getDefaultLanguage() {
        return defaultLanguage;
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected LampCollectionManager<Lamp, LightingItemErrorEvent> getLampCollectionManager() {
        return lightingManager.getLampCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected GroupCollectionManager<Group, LightingItemErrorEvent> getGroupCollectionManager() {
        return lightingManager.getGroupCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected PresetCollectionManager<Preset, LightingItemErrorEvent> getPresetCollectionManager() {
        return lightingManager.getPresetCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected TransitionEffectCollectionManager<TransitionEffect, LightingItemErrorEvent> getTransitionEffectCollectionManager() {
        return lightingManager.getTransitionEffectCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected PulseEffectCollectionManager<PulseEffect, LightingItemErrorEvent> getPulseEffectCollectionManager() {
        return lightingManager.getPulseEffectCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected SceneElementCollectionManager<SceneElement, LightingItemErrorEvent> getSceneElementCollectionManager() {
        return lightingManager.getSceneElementCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected SceneCollectionManager<SceneV1, LightingItemErrorEvent> getSceneCollectionManager() {
        return lightingManager.getSceneCollectionManagerV1();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected SceneCollectionManagerV2<SceneV2, LightingItemErrorEvent> getSceneCollectionManagerV2() {
        return lightingManager.getSceneCollectionManagerV2();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected MasterSceneCollectionManager<MasterScene, LightingItemErrorEvent> getMasterSceneCollectionManager() {
        return lightingManager.getMasterSceneCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected ControllerCollectionManager<Controller, LightingItemErrorEvent> getControllerManager() {
        return lightingManager.getControllerManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected LightingSystemManager<Lamp, Group, Preset, TransitionEffect, PulseEffect, SceneElement, SceneV1, SceneV2, MasterScene, Controller, LightingItemErrorEvent> getLightingSystemManager() {
        return lightingManager;
    }
}
