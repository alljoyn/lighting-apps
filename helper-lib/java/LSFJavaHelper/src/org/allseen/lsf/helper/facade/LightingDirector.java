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
package org.allseen.lsf.helper.facade;

import org.alljoyn.bus.BusAttachment;
import org.allseen.lsf.helper.listener.AllJoynListener;
import org.allseen.lsf.helper.listener.ControllerListener;
import org.allseen.lsf.helper.listener.GroupListener;
import org.allseen.lsf.helper.listener.InitialSetListener;
import org.allseen.lsf.helper.listener.LampListener;
import org.allseen.lsf.helper.listener.LightingListener;
import org.allseen.lsf.helper.listener.MasterSceneListener;
import org.allseen.lsf.helper.listener.NextControllerConnectionListener;
import org.allseen.lsf.helper.listener.PresetListener;
import org.allseen.lsf.helper.listener.PulseEffectListener;
import org.allseen.lsf.helper.listener.SceneElementListener;
import org.allseen.lsf.helper.listener.SceneListener;
import org.allseen.lsf.helper.listener.TransitionEffectListener;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.manager.ControllerManager;
import org.allseen.lsf.helper.manager.GroupCollectionManager;
import org.allseen.lsf.helper.manager.LampCollectionManager;
import org.allseen.lsf.helper.manager.LightingSystemManager;
import org.allseen.lsf.helper.manager.LightingSystemQueue;
import org.allseen.lsf.helper.manager.MasterSceneCollectionManager;
import org.allseen.lsf.helper.manager.PresetCollectionManager;
import org.allseen.lsf.helper.manager.SceneCollectionManager;
import org.allseen.lsf.helper.model.LightingItemUtil;

/**
 * LightingDirector is the main class in the facade interface of the Lighting SDK.
 * It provides access to instances of other facade classes that represent active
 * components in the Lighting system.
 * <p>
 * Please see the LSFTutorial project for an example of how to use the
 * LightingDirector class.
 */
public class LightingDirector {
    private static final String LANGUAGE_DEFAULT = "en";
    private static final long SYNC_TIMEOUT_DEFAULT = 30000;
    private static final LightingDirector instance = new LightingDirector();

    private final LightingSystemManager lightingManager;
    private String defaultLanguage;
    private long createSyncTimeout;

    /**
     * Construct a LightingDirector instance.
     * <p>
     * Note that the start() method must be called at some point after
     * construction when you're ready to begin working with the Lighting system.
     *
     * @return The LightingDirectory instance.
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
        lightingManager = new LightingSystemManager();
        defaultLanguage = LANGUAGE_DEFAULT;
        createSyncTimeout = SYNC_TIMEOUT_DEFAULT;
    }

    /**
     * The version number of the interface provided by this class.
     *
     * @return The version number
     */
    public int getVersion() {
        return 1;
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
                lightingManager.start();
            }
        };
    }

    /**
     * Causes the LightingDirector to stop interacting with the Lighting system.
     */
    public void stop() {
        lightingManager.destroy();
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
     * Returns a snapshot of the active Lamps in the Lighting system that have
     * received all the data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new lamps are discovered or existing lamps are determined to be
     * offline. This array may be empty.
     *
     * @return Array of active Lamps
     */
    public Lamp[] getCompleteLamps() {
        // TODO-IMPL
        return null;
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
     * Returns a snapshot of the active Groups definitions in the Lighting
     * system that have received all the data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new groups are discovered or existing groups are determined to be
     * offline. This array may be empty.
     *
     * @return Array of active Groups
     */
    public Group[] getCompleteGroups() {
        // TODO-IMPL
        return null;
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
     * Returns a snapshot of the active Preset definitions the have received all
     * data from the controller.
     * <p>
     * The contents of this array may change in subsequent calls to this method
     * as new preset are created or existing presets are deleted. This array may
     * be empty.
     *
     * @return An array of active Presets
     */
    public Preset[] getCompletePresets() {
        // TODO-IMPL
        return null;
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
        // TODO-IMPL
        return null;
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
    public TransitionEffect[] getCompleteTransitionEffects() {
        // TODO-IMPL
        return null;
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
        // TODO-IMPL
        return null;
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
        // TODO-IMPL
        return null;
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
    public PulseEffect[] getCompletePulseEffects() {
        // TODO-IMPL
        return null;
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
    public PulseEffect getPuseEffect(String pulseEffectId) {
        // TODO-IMPL
        return null;
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
        // TODO-IMPL
        return null;
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
    public SceneElement[] getCompleteSceneElements() {
        // TODO-IMPL
        return null;
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
        // TODO-IMPL
        return null;
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
        return getSceneCollectionManager().getScenes();
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
    public Scene[] getCompleteScenes() {
        // TODO-IMPL
        return null;
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
        return getSceneCollectionManager().getScene(sceneId);
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
    public MasterScene[] getCompleteMasterScenes() {
        // TODO-IMPL
        return null;
    }

    /**
     * Returns an instance of the MasterScene with the corresponding
     * master scene ID. If a MasterScene corresponding to the master
     * sceen ID does not exist, then this method will return null.
     *
     * @param masterSceneId The ID of the MasterScene
     *
     * @return Instance of MasterScene or null if MasterScene does not exist
     */
    public MasterScene getMasterScene(String masterSceneId) {
        return getMasterSceneCollectionManager().getMasterScene(masterSceneId);
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
     * Waits for the initial data set from the controller to be received
     * before returning.
     * <p>
     * This is a blocking call that will block the current thread until the
     * method returns.
     */
    public void waitForInitialSetCompletion() {
        // TODO-IMPL
    }

    /**
     * Synchronously creates a Group on the Lighting Controller.
     *<p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
     *
     * @param members
     *            Array of GroupMember
     * @param groupName
     *            Name of the Group
     *
     * @return Instance of Group, or null upon failure.
     */
    public Group createGroupSync(GroupMember[] members, String groupName) {
        // TODO-IMPL
        return null;
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
     */
    public void createGroup(GroupMember[] members, String groupName, GroupListener listener) {
        // TODO-Handle one-shot listener impl

        AllJoynManager.groupManager.createLampGroup(LightingItemUtil.createLampGroup(members),
                groupName, getDefaultLanguage());
    }

    /**
     * Synchronously creates a Preset on the Lighting Controller.
     * <p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
     *
     * @param power
     *            Specifies the Power of the Preset's lamp state
     * @param color
     *            Specifies the Color of the Preset's lamp state
     * @param presetName
     *            Name of the Preset
     *
     * @return  Instance of Preset, or null upon failure
     */
    public Preset createPresetSync(Power power, Color color, String presetName) {
        // TODO-IMPLl
        return null;
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
     */
    public void createPreset(Power power, Color color, String presetName, PresetListener listener) {
        // TODO-Handle one-shot listener impl

        AllJoynManager.presetManager.createPreset(LightingItemUtil.createLampStateFromView(
                power == Power.ON, color.getHue(), color.getSaturation(), color.getBrightness(), color.getColorTemperature()),
                presetName, getDefaultLanguage());
    }

    /**
     * Synchronously creates a TransitionEffect on the Lighting Controller.
     * <p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
     *
     * @param state
     *            Specifies the lamp state of the TransitionEffect
     * @param duration
     *            Specifies how long the TransitionEffect will take
     * @param effectName
     *            Name of the TransitionEffect
     *
     * @return Instance of TransitionEffect, or null upon failure
     */
    public TransitionEffect createTransitionEffectSync(LampState state, long duration, String effectName) {
        // TODO-IMPL
        return null;
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
     */
    public void createTransitionEffect(LampState state, long duration, String effectName, TransitionEffectListener listener) {
        // TODO-IMPL
    }

    /**
     * Synchronously creates a PulseEffect on the Lighting Controller.
     * <p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
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
     *
     * @return Instance of PulseEffect, or null upon failure.
     */
    public PulseEffect createPulseEffectSync(LampState fromState, LampState toState, long period, long duration, long count, String effectName) {
        // TODO-IMPL
        return null;
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
     */
    public void createPulseEffect(LampState fromState, LampState toState, long period, long duration, long count, String effectName, PulseEffectListener listener) {
        // TODO-IMPL
    }

    /**
     * Synchronously creates a SceneElement on the Lighting Controller.
     * <p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
     *
     * @param effect
     *            Specifies the SceneElement's effect
     * @param members
     *            Specifies the GroupMembers for which the effect will be applied
     * @param sceneElementName
     *            Name of the SceneElement
     *
     * @return Instance of SceneElement, or null upon failure
     */
    public SceneElement createSceneElementSync(Effect effect, GroupMember[] members, String sceneElementName) {
        // TODO-IMPL
        return null;
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
     */
    public void createSceneElement(Effect effect, GroupMember[] members, String sceneElementName, SceneElementListener listener) {
        // TODO-IMPL
    }

    /**
     * Synchronously creates a Scene on the Lighting Controller.
     * <p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
     *
     * @param sceneElements
     *            Specifies the SceneElements that belong to the Scene
     * @param sceneName
     *            Name of the Scene
     *
     * @return Instance of Scene, or null upon failure
     */
    public Scene createSceneSync(SceneElement[] sceneElements, String sceneName) {
        // TODO-IMPL
        return null;
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
     */
    public void createScene(SceneElement[] sceneElements, String sceneName, SceneListener listener) {
        // TODO-IMPL
    }

    /**
     * Synchronously creates a MasterScene on the Lighting Controller.
     * <p>
     * This is a blocking call that will block the current thread until the object
     * is successfully created or the create sync timeout is exceeded. The timeout
     * value can be set using {@link #setCreateSyncTimeout(long) createSyncTimeout}.
     *
     * @param scenes
     *            Specifies the Scenes that belong to the MasterScene
     * @param masterSceneName
     *            Name of the MasterScene
     *
     * @return Instance of Scene, or null upon failure
     */
    public MasterScene createMasterSceneSync(Scene[] scenes, String masterSceneName) {
        // TODO-IMPL
        return null;
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
     */
    public void createMasterScene(Scene[] scenes, String masterSceneName, MasterSceneListener listener) {
        // TODO-IMPL
    }

    /**
     * Adds a global listener to receive all Lighting System events associated
     * with the provided listener.
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

        if (listener instanceof InitialSetListener) {
            addInitialSetListener((InitialSetListener) listener);
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
        // TODO-IMPL
    }

    /**
     * Adds a global listener to receive all PulseEffect events.
     *
     * @param listener
     *            The listener to receive all PulseEffect events.
     */
    public void addPulseEffectListener(PulseEffectListener listener) {
        // TODO-IMPL
    }

    /**
     * Adds a global listener to receive all SceneElement events.
     *
     * @param listener
     *            The listener to receive all SceneElement events.
     */
    public void addSceneElementListener(SceneElementListener listener) {
        // TODO-IMPL
    }

    /**
     * Adds a global listener to receive all Scene events.
     *
     * @param listener
     *            The listener to receive all Scene events.
     */
    public void addSceneListener(SceneListener listener) {
        getSceneCollectionManager().addListener(listener);
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
     * Adds a global listener to receive all initial data set events.
     *
     * @param listener
     *            The listener to receive all initial data set  events.
     */
    public void addInitialSetListener(InitialSetListener listener) {
        // TODO-IMPL
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

        if (listener instanceof InitialSetListener) {
            removeInitialSetListener((InitialSetListener) listener);
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
        // TODO-IMPL
    }

    /**
     * Removes a global listener that receives all PulseEffect events.
     *
     * @param listener
     *            The listener that receives all PulseEffect events.
     */
    public void removePulseEffectListener(PulseEffectListener listener) {
        // TODO-IMPL
    }

    /**
     * Removes a global listener that receives all SceneElement events.
     *
     * @param listener
     *            The listener that receives all SceneElement events.
     */
    public void removeSceneElementListener(SceneElementListener listener) {
        // TODO-IMPL
    }

    /**
     * Removes a global listener that receives all Scene events.
     *
     * @param listener
     *            The listener that receives all Scene events.
     */
    public void removeSceneListener(SceneListener listener) {
        getSceneCollectionManager().removeListener(listener);
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
     * Removes a global listener that receives all initial data set events.
     *
     * @param listener
     *            The listener that receives all initial data set events.
     */
    public void removeInitialSetListener(InitialSetListener listener) {
        // TODO-IMPL
    }

    /**
     * Sets the amount of time to wait (in milliseconds) for synchronous
     * create methods to return.
     * <p>
     * If this method is never called, the default timeout value is 30 seconds.
     *
     * @param timeout
     *            The timeout value in milliseconds
     */
    public void setCreateSyncTimeout(long timeout) {
       if (timeout > 0) {
           createSyncTimeout = timeout;
       }
    }

    /**
     * Gets the timeout value (in milliseconds) used for synchronous create
     * method calls.
     *
     * @return The timeout value in milliseconds
     */
    public long getCreateSyncTimeout() {
        return createSyncTimeout;
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
     * Toggles the state of the bundled Lighting Controller Service.
     *
     * @param enabled
     *            Specifies whether the Lighting Controller should be enables or disabled.
     */
    public void setLocalControllerServiceEnabled(boolean enabled) {
        // TODO-IMPL
    }

    /**
     * Specifies whether there is an active network connection. Used when the
     * Lighting Controller Service is enabled.
     *
     * @param connected
     *            Specifies whether the device has an active network connection.
     */
    public void setNetworkConnected(boolean connected) {
        // TODO-IMPL
    }

    // TODO: What else needs to be exposed for ControllerService functionality?

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected LampCollectionManager getLampCollectionManager() {
        return lightingManager.getLampCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected GroupCollectionManager getGroupCollectionManager() {
        return lightingManager.getGroupCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected PresetCollectionManager getPresetCollectionManager() {
        return lightingManager.getPresetCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected SceneCollectionManager getSceneCollectionManager() {
        return lightingManager.getSceneCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected MasterSceneCollectionManager getMasterSceneCollectionManager() {
        return lightingManager.getMasterSceneCollectionManager();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected ControllerManager getControllerManager() {
        return lightingManager.getControllerManager();
    }
}
