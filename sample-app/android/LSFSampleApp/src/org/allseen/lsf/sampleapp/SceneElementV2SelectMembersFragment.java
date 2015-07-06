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

import java.util.Collection;

import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.ColorAverager;
import android.view.Menu;
import android.view.MenuInflater;

public class SceneElementV2SelectMembersFragment extends SceneItemSelectMembersFragment {

    public SceneElementV2SelectMembersFragment() {
        super(R.string.label_scene_element);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        SampleAppActivity activity = (SampleAppActivity)getActivity();

        activity.updateActionBar(isAddMode() ? R.string.title_scene_element_add : R.string.title_scene_element_edit, false, false, true, false, true);
    }

    @Override
    protected String getHeaderText() {
        return getString(R.string.scene_element_select_members);
    }

    @Override
    protected String getPendingItemID() {
        return SceneElementV2InfoFragment.pendingSceneElement.id;
    }

    @Override
    protected int getMixedSelectionMessageID() {
        return R.string.mixing_lamp_types_message_scene_element;
    }

    @Override
    protected int getMixedSelectionPositiveButtonID() {
        return R.string.create_scene_element;
    }

    @Override
    protected Collection<String> getPendingGroupIDs() {
        return SceneElementV2InfoFragment.pendingSceneElement.groups;
    }

    @Override
    protected Collection<String> getPendingLampIDs() {
        return SceneElementV2InfoFragment.pendingSceneElement.lamps;
    }

    @Override
    protected void setPendingMemberIDs(Collection<String> lampIDs, Collection<String> groupIDs) {
        SceneElementV2InfoFragment.pendingSceneElement.lamps = lampIDs;
        SceneElementV2InfoFragment.pendingSceneElement.groups = groupIDs;
    }

    @Override
    protected void setPendingCapability(LampCapabilities capability) {
        SceneElementV2InfoFragment.pendingSceneElement.capability = capability;
    }

    @Override
    protected boolean getPendingMembersHaveEffects() {
        return SceneElementV2InfoFragment.pendingSceneElement.hasEffects;
    }

    @Override
    protected void setPendingMembersHaveEffects(boolean haveEffects) {
        SceneElementV2InfoFragment.pendingSceneElement.hasEffects = haveEffects;
    }

    @Override
    protected int getPendingMembersMinColorTemp() {
        return SceneElementV2InfoFragment.pendingSceneElement.minColorTemp;
    }

    @Override
    protected void setPendingMembersMinColorTemp(int minColorTemp) {
        SceneElementV2InfoFragment.pendingSceneElement.minColorTemp = minColorTemp;
    }

    @Override
    protected int getPendingMembersMaxColorTemp() {
        return SceneElementV2InfoFragment.pendingSceneElement.maxColorTemp;
    }

    @Override
    protected void setPendingMembersMaxColorTemp(int maxColorTemp) {
        SceneElementV2InfoFragment.pendingSceneElement.maxColorTemp = maxColorTemp;
    }

    @Override
    protected ColorAverager getPendingColorTempAverager() {
        return SceneElementV2InfoFragment.pendingSceneElement.colorTempAverager;
    }

    @Override
    protected void updatePendingColorTempAverager(int viewColorTemp) {
        getPendingColorTempAverager().add(viewColorTemp);
    }

    @Override
    public void onActionNext() {
        if (processSelection()) {
            ((ScenesPageFragment)parent).showSelectEffectChildFragment();
        }
    }
//TODO-IMPL
//    @Override
//    protected void processSelection(SampleAppActivity activity, List<String> lampIDs, List<String> groupIDs, List<String> sceneIDs) {
//        SceneElementInfoFragment.pendingSceneElement.lamps = lampIDs;
//        SceneElementInfoFragment.pendingSceneElement.groups = groupIDs;
//        List<GroupMember> members = new ArrayList<GroupMember>();
//
//        members.addAll(Arrays.asList(LightingDirector.get().getLamps(lampIDs)));
//        members.addAll(Arrays.asList(LightingDirector.get().getGroups(groupIDs)));
//
//        if (!isAddMode()) {
//            Group group = LightingDirector.get().getGroup(GroupInfoFragment.pendingGroupID);
//
//            if (group != null) {
//                group.modify(members.toArray(new GroupMember[members.size()]));
//            }
//        } else {
//            LightingDirector.get().createGroup(members.toArray(new GroupMember[members.size()]), GroupInfoFragment.pendingGroupName, null);
//        }
//    }


    //TODO-REF Common
    protected boolean isAddMode() {
        String pendingSceneElementID = getPendingItemID();

        return pendingSceneElementID == null || pendingSceneElementID.isEmpty();
    }
}
