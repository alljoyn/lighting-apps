/* Copyright (c) AllSeen Alliance. All rights reserved.
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
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.LampState;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.AllLampsDataModel;
import org.allseen.lsf.sdk.model.ColorItemDataModel;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.GroupDataModel;
import org.allseen.lsf.sdk.model.LightingItemUtil;

/**
 * This class represents a Group in the Lighting system. Groups can contains Lamps and Groups.
 * <p>
 * <b>Note: This class is not meant to be instantiated directly. Groups should be retrieved
 * from the LightingDirector using the {@link LightingDirector#getGroups()} method.</b>
 */
public class Group extends GroupMember implements DeletableItem {
    /**
     * Specifies the default name of the Group.
     *
     * @param defaultName Default name of the Group
     */
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            GroupDataModel.defaultName = defaultName;
        }
    }

    protected GroupDataModel groupModel;

    /**
     * Constructs a Group using the specified ID.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * Groups directly, but should instead get them from the {@link LightingDirector} using the
     * {@link LightingDirector#getGroups()} method.</b>
     *
     * @param groupID The ID of the group
     */
    protected Group(String groupID) {
        this(groupID, null);
    }

    /**
     * Constructs a Group using the specified ID and name.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * Groups directly, but should instead get them from the {@link LightingDirector} using the
     * {@link LightingDirector#getGroups()} method.</b>
     *
     * @param groupID The ID of the group
     * @param groupName The name of the group
     */
    protected Group(String groupID, String groupName) {
        super();

        groupModel = AllLampsDataModel.ALL_LAMPS_GROUP_ID.equals(groupID) ? AllLampsDataModel.instance : new GroupDataModel(groupID, groupName);
    }

    /**
     * Changes the power state of the current Group.
     *
     * @param powerOn True for on, false for off
     */
    @Override
    public void setPowerOn(boolean powerOn) {
        String errorContext = "Group.setPowerOn() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.groupManager.transitionLampGroupStateOnOffField(groupModel.id, powerOn));
    }

    /**
     * Changes the color state of the current Group to the provided HSVT color.
     *
     * @param hueDegrees The hue component of the desired color (0-360)
     * @param saturationPercent The saturation component of the desired color (0-100)
     * @param brightnessPercent The brightness component of the desired color (0-100)
     * @param colorTempDegrees The color temperature component of the desired color (1000-20000)
     */
    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        LampState lampState = new LampState(groupModel.getState());

        ColorStateConverter.convertViewToModel(hueDegrees, saturationPercent, brightnessPercent, colorTempDegrees, lampState);

        String errorContext = "Group.setColorHsvt() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.groupManager.transitionLampGroupState(groupModel.id, lampState, 0));
    }

    /**
     * Adds a member to the current Group.
     *
     * @param member The GroupMember object to be added to the Group
     */
    public void add(GroupMember member) {
        String errorContext = "Group.add() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            Set<String> lamps = new HashSet<String>(Arrays.asList(groupModel.members.getLamps()));
            Set<String> groups = new HashSet<String>(Arrays.asList(groupModel.members.getLampGroups()));

            if (member instanceof Lamp) {
                lamps.add(member.getId());
            } else if (member instanceof Group) {
                groups.add(member.getId());
            }

            postErrorIfFailure(errorContext,
                    AllJoynManager.groupManager.updateLampGroup(groupModel.id, LightingItemUtil.createLampGroup(
                            lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()]))));
        }
    }

    /**
     * Removes a member from the current Group.
     *
     * @param member The GroupMember object to be removed from the Group
     */
    public void remove(GroupMember member) {
        String errorContext = "Group.remove() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            Set<String> lamps = new HashSet<String>(Arrays.asList(groupModel.members.getLamps()));
            Set<String> groups = new HashSet<String>(Arrays.asList(groupModel.members.getLampGroups()));


            boolean didRemove = lamps.remove(member.getId()) || groups.remove(member.getId());

            if (didRemove) {
                postErrorIfFailure(errorContext,
                        AllJoynManager.groupManager.updateLampGroup(groupModel.id, LightingItemUtil.createLampGroup(
                                lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()]))));
            }
        }
    }

    /**
     * Replaces the current Group memebers with the provided GroupMember array.
     *
     * @param members The array of GroupMembers
     */
    public void modify(GroupMember[] members) {
        String errorContext = "Group.modify() error";

        if (postInvalidArgIfNull(errorContext, members)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.groupManager.updateLampGroup(groupModel.id, GroupMember.createLampGroup(members)));
        }
    }

    /**
     * Deletes the current Group from the Lighting system.
     */
    @Override
    public void delete() {
        String errorContext = "Group.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.groupManager.deleteLampGroup(groupModel.id));
    }

    /**
     * Applies the provided Preset to the current Group.
     *
     * @param preset Preset to apply to the current Group
     */
    @Override
    public void applyPreset(Preset preset) {
        String errorContext = "Group.applyPreset() error";

        if (postInvalidArgIfNull(errorContext, preset)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.groupManager.transitionLampGroupStateToPreset(groupModel.id, preset.getPresetDataModel().id, 0));
        }
    }

    /**
     * Applies the provided Effect to the current Group.
     *
     * @param effect Effect to apply to the current Group
     */
    @Override
    public void applyEffect(Effect effect) {
        String errorCotext = "Group.applyEffect() error";

        if (postInvalidArgIfNull(errorCotext, effect)) {
            if (effect instanceof Preset) {
                applyPreset((Preset) effect);
            } else if (effect instanceof TransitionEffect) {
                postErrorIfFailure(errorCotext,
                        AllJoynManager.transitionEffectManager.applyTransitionEffectOnLampGroups(effect.getId(), new String [] { groupModel.id }));
            } else if (effect instanceof PulseEffect) {
                postErrorIfFailure(errorCotext,
                        AllJoynManager.pulseEffectManager.applyPulseEffectOnLampGroups(effect.getId(), new String [] { groupModel.id }));
            }
        }
    }

    /**
     * Renames the current Group using the provided name.
     *
     * @param groupName The new name for the Group
     */
    @Override
    public void rename(String groupName) {
        String errorContext = "Group.rename() error";

        if (postInvalidArgIfNull(errorContext, groupName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.groupManager.setLampGroupName(groupModel.id, groupName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Tests to see if the current Group contains the specified Lighting item.
     *
     * @param item Lighting item to be confirmed present in the Group
     *
     * @return Returns true if the Group contains the specified Lighting item, false otherwise
     */
    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "Group.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasLampID(item.getId()) || hasGroupID(item.getId()) : false;
    }

    /**
     * Tests to see if the current Group contains the specified Lamp.
     *
     * @param lamp The Lamp to be confirmed present in the Group
     *
     * @return Returns true if the Group contains the specified Lamp, false otherwise
     */
    public boolean hasLamp(Lamp lamp) {
        String errorContext = "Group.hasLamp() error";
        return postInvalidArgIfNull(errorContext, lamp) ? hasLampID(lamp.getId()) : false;
    }

    /**
     * Tests to see if the current Group contains the specified Group.
     *
     * @param group The Group to be confirmed present in the Group
     *
     * @return Returns true if the Group contains the specified Group, false otherwise
     */
    public boolean hasGroup(Group group) {
        String errorContext = "Group.hasGroup() error";
        return postInvalidArgIfNull(errorContext, group) ? hasGroupID(group.getId()) : false;
    }

    /**
     * Tests to see if the current Group contains the specified Lamp ID.
     *
     * @param lampID The Lamp ID to be confirmed present in the Group.
     *
     * @return Returns true if the Group contains the specified lamp ID, false otherwise
     */
    public boolean hasLampID(String lampID) {
        return groupModel.containsLamp(lampID);
    }

    /**
     * Tests to see if the current Group contains the specified Group ID.
     *
     * @param groupID The Group ID to be confirmed present in the Group.
     *
     * @return Returns true if the Group contains the specified group ID, false otherwise
     */
    public boolean hasGroupID(String groupID) {
        return groupModel.containsGroup(groupID);
    }

    /**
     * Returns an array of Lamps that are members of the current Group.
     *
     * @return Array of all Lamps in the current Group
     */
    public Lamp[] getLamps() {
        return LightingDirector.get().getLamps(getLampIDs());
    }

    /**
     * Returns an array of Groups that are members of the current Group.
     *
     * @return Array of all Groups in the current Group
     */
    public Group[] getGroups() {
        return LightingDirector.get().getGroups(getGroupIDs());
    }

    /**
     * Returns an array of Lamp IDs that are members of the current Group.
     *
     * @return Array of all Lamp IDs in the current Group
     */
    public Collection<String> getLampIDs() {
        return groupModel.getLamps();
    }

    /**
     * Returns an array of Group IDs that are members of the current Group.
     *
     * @return Array of all Group IDs in the current Group
     */
    public Collection<String> getGroupIDs() {
        return groupModel.getGroups();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    @Override
    protected void addTo(Collection<String> lampIDs, Collection<String> groupIDs) {
        groupIDs.add(getId());
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    @Override
    protected Collection<LightingItem> getDependentCollection() {
        LightingDirector director = LightingDirector.get();
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(director.getGroupCollectionManager().getGroupCollection(new HasComponentFilter<Group>(Group.this)));
        dependents.addAll(director.getSceneCollectionManager().getScenesCollection(new HasComponentFilter<SceneV1>(Group.this)));
        dependents.addAll(director.getSceneElementCollectionManager().getSceneElementsCollection(new HasComponentFilter<SceneElement>(Group.this)));

        return dependents;
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    @Override
    protected Collection<LightingItem> getComponentCollection() {
        Collection<LightingItem> components = new ArrayList<LightingItem>();

        components.addAll(Arrays.asList(getLamps()));
        components.addAll(Arrays.asList(getGroups()));

        return components;
    }

    /**
     * Returns the absolute minimum color temperature value supported by the Lamps in the current Group.
     *
     * @return The Lamps minimum color temperature value
     */
    public int getColorTempMin() {
        return getGroupDataModel().viewColorTempMin;
    }

    /**
     * Returns the absolute maximum color temperature value supported by the Lamps in the current Group.
     *
     * @return The Lamps maximum color temperature value
     */
    public int getColorTempMax() {
        return getGroupDataModel().viewColorTempMax;
    }

    /**
     * Tests to see if the current Group is the AllLampsGroup.
     *
     * @return Returns true if the current Group is the AllLampsGroup, false otherwise
     */
    public boolean isAllLampsGroup() {
        return AllLampsDataModel.ALL_LAMPS_GROUP_ID.equals(groupModel.id);
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getGroupDataModel();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected GroupDataModel getGroupDataModel() {
        return groupModel;
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getGroupCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}