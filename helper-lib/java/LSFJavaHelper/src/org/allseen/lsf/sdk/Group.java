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
 * A Group object represents a set of lamps in a lighting system, and can be used to send the
 * same command to all of them.
 *
 * Groups can contain lamps and other groups.
 */
public class Group extends GroupMember implements DeletableItem {

    /**
     * Sets the default name for Groups, using the string provided.
     *
     * @param defaultName The new default name for Groups.
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
     * Sends a command to turn all constituent lamps in the Group on or off.
     *
     * @param powerOn Pass in true for on, false for off
     */
    @Override
    public void setPowerOn(boolean powerOn) {
        String errorContext = "Group.setPowerOn() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.groupManager.transitionLampGroupStateOnOffField(groupModel.id, powerOn));
    }

    /**
     * Sends a command to change the color of all constituent lamps in the Group.
     *
     * @param hueDegrees The hue component of the desired color, in degrees (0-360)
     * @param saturationPercent The saturation component of the desired color, in percent (0-100)
     * @param brightnessPercent The brightness component of the desired color, in percent (0-100)
     * @param colorTempDegrees The color temperature component of the desired color, in degrees Kelvin (1000-20000)
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
     * Adds a member to the Group.
     *
     * @param member The GroupMember object to be added to the Group.
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
     * Removes a member from the Group.
     *
     * @param member the GroupMember object to be removed from the Group.
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
     * Modifies the Group with the given GroupMember array.
     *
     * @param members the array of GroupMembers.
     */
    public void modify(GroupMember[] members) {
        String errorContext = "Group.modify() error";

        if (postInvalidArgIfNull(errorContext, members)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.groupManager.updateLampGroup(groupModel.id, GroupMember.createLampGroup(members)));
        }
    }

    /**
     * Deletes the Group from the lighting system.
     *
     * @see org.allseen.lsf.sdk.DeletableItem#delete()
     */
    @Override
    public void delete() {
        String errorContext = "Group.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.groupManager.deleteLampGroup(groupModel.id));
    }

    /**
     * Applies a Preset to every member of the Group.
     *
     * @param preset The Preset to be applied.
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
     * Applies an Effect to every member of the Group.
     *
     * @param effect The Effect to be applied.
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
     * Renames the Group.
     *
     * @param groupName The new name of the Group.
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
     * Returns a boolean representing whether or not the Group contains a specified Lighting Item.
     *
     * @param item The Lighting Item to be confirmed present in the Group.
     *
     * @return boolean representing whether or not the Group contains a specified Lighting Item.
     */
    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "Group.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasLampID(item.getId()) || hasGroupID(item.getId()) : false;
    }

    /**
     * Returns a boolean representing whether or not the Group contains a specified Lamp.
     *
     * @param lamp The Lamp to be confirmed present in the Group.
     *
     * @return boolean representing whether or not the Group contains a specified Lamp.
     */
    public boolean hasLamp(Lamp lamp) {
        String errorContext = "Group.hasLamp() error";
        return postInvalidArgIfNull(errorContext, lamp) ? hasLampID(lamp.getId()) : false;
    }

    /**
     * Returns a boolean representing whether or not the Group contains a specified Group.
     *
     * @param group The Group to be confirmed present.
     *
     * @return boolean representing whether or not the Group contains a specified Group.
     */
    public boolean hasGroup(Group group) {
        String errorContext = "Group.hasGroup() error";
        return postInvalidArgIfNull(errorContext, group) ? hasGroupID(group.getId()) : false;
    }

    /**
     * Returns a boolean representing whether or not the Group contains a specified Lamp ID.
     *
     * @param lampID The Lamp ID to be confirmed present in the Group.
     *
     * @return boolean representing whether or not the Group contains a specified Lamp ID.
     */
    public boolean hasLampID(String lampID) {
        return groupModel.containsLamp(lampID);
    }

    /**
     * Returns a boolean representing whether or not the Group contains a specified Group ID.
     *
     * @param groupID The Group ID to be confirmed present in the Group.
     *
     * @return boolean representing whether or not the Group contains a specified Group ID.
     */
    public boolean hasGroupID(String groupID) {
        return groupModel.containsGroup(groupID);
    }

    /**
     * Returns all instantiated Lamps in the lighting system.
     *
     * @return an array of all the Lamps in the lighting system.
     */
    public Lamp[] getLamps() {
        return LightingDirector.get().getLamps(getLampIDs());
    }

    /**
     * Returns all instantiated Groups in the lighting system.
     *
     * @return an array of all the Groups in the lighting system.
     */
    public Group[] getGroups() {
        return LightingDirector.get().getGroups(getGroupIDs());
    }

    /**
     * Returns a Collection of all Lamp IDs in the Group.
     *
     * @return A Collection of Strings of Lamp IDs in the Group.
     */
    public Collection<String> getLampIDs() {
        return groupModel.getLamps();
    }

    /**
     * Returns a Collection of all Group IDs in the Group.
     *
     * @return A Collection of Strings of Group IDs in the Group.
     */
    public Collection<String> getGroupIDs() {
        return groupModel.getGroups();
    }

    @Override
    protected void addTo(Collection<String> lampIDs, Collection<String> groupIDs) {
        groupIDs.add(getId());
    }

    @Override
    protected Collection<LightingItem> getDependentCollection() {
        LightingDirector director = LightingDirector.get();
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(director.getGroupCollectionManager().getGroupCollection(new LightingItemHasComponentFilter<Group>(Group.this)));
        dependents.addAll(director.getSceneCollectionManager().getScenesCollection(new LightingItemHasComponentFilter<SceneV1>(Group.this)));
        dependents.addAll(director.getSceneElementCollectionManager().getSceneElementsCollection(new LightingItemHasComponentFilter<SceneElement>(Group.this)));

        return dependents;
    }

    @Override
    protected Collection<LightingItem> getComponentCollection() {
        Collection<LightingItem> components = new ArrayList<LightingItem>();

        components.addAll(Arrays.asList(getLamps()));
        components.addAll(Arrays.asList(getGroups()));

        return components;
    }

    public int getColorTempMin() {
        return getGroupDataModel().viewColorTempMin;
    }

    public int getColorTempMax() {
        return getGroupDataModel().viewColorTempMax;
    }

    public boolean isAllLampsGroup() {
        return AllLampsDataModel.ALL_LAMPS_GROUP_ID.equals(groupModel.id);
    }

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
