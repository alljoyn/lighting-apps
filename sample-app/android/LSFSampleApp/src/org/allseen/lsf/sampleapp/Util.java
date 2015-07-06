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
package org.allseen.lsf.sampleapp;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.allseen.lsf.sdk.Group;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.LightingItem;
import org.allseen.lsf.sdk.MasterScene;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.Preset;
import org.allseen.lsf.sdk.SceneElement;
import org.allseen.lsf.sdk.SceneV2;

public class Util {
    public static boolean isDuplicateName(LightingItem[] items, String itemName) {
        for (LightingItem item : items) {
            if (item.getName().equals(itemName)) {
                return true;
            }
        }

        return false;
    }

    // Creates a details string, containing a list of all lamps and subgroups in a lamp group
    public static String createMemberNamesString(SampleAppActivity activity, Group group, String separator, int noMembersStringID) {
        return createMemberNamesString(activity, group.getGroupIDs(), group.getLampIDs(), separator, R.string.member_group_not_found, R.string.member_lamp_not_found, noMembersStringID);
    }

    public static String createMemberNamesString(SampleAppActivity activity, SceneElement sceneElement, String separator, int noMembersStringID) {
        return createMemberNamesString(activity, sceneElement.getGroupIDs(), sceneElement.getLampIDs(), separator, R.string.member_group_not_found, R.string.member_lamp_not_found, noMembersStringID);
    }

    public static String createMemberNamesString(SampleAppActivity activity, Collection<String> groupIDs, Collection<String> lampIDs, String separator, int groupNotFoundStringID, int lampNotFoundStringID, int noMembersStringID) {
        List<String> groupNames = new ArrayList<String>();
        List<String> lampNames = new ArrayList<String>();

        for (String groupID : groupIDs) {
            Group group = LightingDirector.get().getGroup(groupID);
            groupNames.add(group != null ? group.getName() : String.format(activity.getString(groupNotFoundStringID), groupID));
        }

        for (String lampID : lampIDs) {
            Lamp lamp = LightingDirector.get().getLamp(lampID);
            lampNames.add(lamp != null ? lamp.getName() : String.format(activity.getString(lampNotFoundStringID), lampID));
        }

        return createMemberNamesString(activity, groupNames, lampNames, separator, noMembersStringID);
    }

    public static String createMemberNamesString(SampleAppActivity activity, List<String> groupNames, List<String> lampNames, String separator, int noMembersStringID) {
        Collections.sort(groupNames);
        Collections.sort(lampNames);

        StringBuilder sb = new StringBuilder();

        for (String groupName : groupNames) {
            sb.append(groupName + separator);
        }

        for (String lampName : lampNames) {
            sb.append(lampName + separator);
        }

        String details = sb.toString();

        if (details.length() > separator.length()) {
            // drop the last comma and space
            details = details.substring(0, details.length() - separator.length());
        } else if (noMembersStringID > 0) {
            details = activity.getString(noMembersStringID);
        } else {
            details = "";
        }

        return details;
    }

    // Creates a string containing a sorted comma-separated list of preset names that match the specified state
    public static String createPresetNamesString(SampleAppActivity activity, MyLampState itemState) {
        List<String> presetNames = new ArrayList<String>();
        Preset[] presets = LightingDirector.get().getPresets();

        for (Preset preset : presets) {
            if (preset.stateEquals(itemState)) {
                presetNames.add(preset.getName());
            }
        }

        String flattenedPresetNames = sortAndFlattenNameList(presetNames);

        return !flattenedPresetNames.isEmpty() ? flattenedPresetNames : activity.getString(R.string.title_presets_save_new);
    }

    // Creates a details string, containing a list of all scenes
    public static String createSceneNamesString(SampleAppActivity activity, MasterScene masterScene) {
        return createSceneItemNamesString(activity, masterScene.getScenes(), R.string.member_scene_not_found, R.string.master_scene_members_none);
    }

    public static String createSceneElementNamesString(SampleAppActivity activity, SceneV2 basicScene) {
        return createSceneItemNamesString(activity, basicScene.getSceneElements(), R.string.member_scene_element_not_found, R.string.basic_scene_members_none);
    }

    public static String createSceneItemNamesString(SampleAppActivity activity, LightingItem[] sceneItems, int notFoundID, int noMembersID) {
        List<String> sceneItemNames = new ArrayList<String>();

        for (LightingItem lightingItem : sceneItems) {
            sceneItemNames.add(lightingItem.isInitialized() ? lightingItem.getName() : String.format(activity.getString(notFoundID), lightingItem.getId()));
        }

        String flattenedItemNames = sortAndFlattenNameList(sceneItemNames);

        return !flattenedItemNames.isEmpty() ? flattenedItemNames : activity.getString(noMembersID);
    }

    public static String sortAndFlattenNameList(List<String> names) {
        Collections.sort(names);

        StringBuilder sb = new StringBuilder();

        for (String name : names) {
            sb.append(name + ", ");
        }

        String flattenedNames = sb.toString();

        if (flattenedNames.length() > 2) {
            // drop the last comma and space
            flattenedNames = flattenedNames.substring(0, flattenedNames.length() - 2);
        }

        return flattenedNames;
    }
}
