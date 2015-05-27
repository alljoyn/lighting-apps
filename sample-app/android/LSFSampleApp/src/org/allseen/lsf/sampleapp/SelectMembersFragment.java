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
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.facade.Lamp;
import org.allseen.lsf.helper.facade.SceneV1;
import org.allseen.lsf.helper.model.AllLampsDataModel;
import org.allseen.lsf.helper.model.GroupDataModel;
import org.allseen.lsf.helper.model.LampCapabilities;
import org.allseen.lsf.helper.model.LampDataModel;
import org.allseen.lsf.helper.model.SceneDataModel;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public abstract class SelectMembersFragment extends SelectableItemTableFragment {

    protected int labelStringID;
    protected Set<String> selectedItems;

    public SelectMembersFragment(int labelStringID) {
        this.labelStringID = labelStringID;
    }

    protected boolean showGroups() {
        return !showScenes();
    }

    protected boolean showLamps() {
        return !showScenes();
    }

    protected boolean showScenes() {
        return false;
    }

    protected boolean confirmMixedSelection() {
        return true;
    }

    @Override
    protected boolean isItemSelected(String groupID) {
        return (selectedItems != null) && (selectedItems.contains(groupID));
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View root = super.onCreateView(inflater, container, savedInstanceState);
        String itemID = getPendingItemID();
        SampleAppActivity activity = (SampleAppActivity) getActivity();

        if (itemID == null) {
            itemID = "";
        }

        getPendingSelection();

        if (showGroups()) {
            Iterator<Group> i = activity.systemManager.getGroupCollectionManager().getGroupIterator();

            while(i.hasNext()) {
                GroupDataModel groupModel = i.next().getGroupDataModel();
                GroupDataModel pendingGroupModel = ((SampleAppActivity)getActivity()).pendingGroupModel;
                String pendingGroupModelID = pendingGroupModel != null ? pendingGroupModel.id : "";
                boolean otherIsParent = pendingGroupModelID != null && groupModel.getGroups() != null && groupModel.getGroups().contains(pendingGroupModelID);

                if (groupModel != null && !itemID.equals(groupModel.id) && !AllLampsDataModel.ALL_LAMPS_GROUP_ID.equals(groupModel.id) && !otherIsParent) {
                    updateSelectableItemRow(inflater, root, groupModel.id, groupModel.tag, R.drawable.scene_lightbulbs_icon, groupModel.getName(), isItemSelected(groupModel.id));
                }
            }
        }

        if (showLamps()) {
            Iterator<Lamp> i = activity.systemManager.getLampCollectionManager().getLampIterator();

            while (i.hasNext()){
                LampDataModel lampModel = i.next().getLampDataModel();

                if (lampModel != null && !itemID.equals(lampModel.id)) {
                    updateSelectableItemRow(inflater, root, lampModel.id, lampModel.tag, R.drawable.group_lightbulb_icon, lampModel.getName(), isItemSelected(lampModel.id));
                }
            }
        }

        if (showScenes()) {
            Iterator<SceneV1> i = activity.systemManager.getSceneCollectionManagerV1().getSceneIterator();

            while (i.hasNext()){
                SceneDataModel sceneModel = i.next().getSceneDataModel();

                if (sceneModel != null && !itemID.equals(sceneModel.id)) {
                    updateSelectableItemRow(inflater, root, sceneModel.id, sceneModel.tag, R.drawable.scene_set_icon, sceneModel.getName(), isItemSelected(sceneModel.id));
                }
            }
        }

        return root;
    }

    @Override
    public void onActionDone() {
        if (processSelection()) {
            parent.clearBackStack();
        }
    }

    protected void getPendingSelection() {
        selectedItems = null;

        if (showGroups() || showLamps()) {
            LampGroup pendingMembers = getPendingMembers();

            if (pendingMembers != null) {
                if (selectedItems == null) {
                    selectedItems = new HashSet<String>();
                }

                if (showGroups()) {
                    selectedItems.addAll(Arrays.asList(pendingMembers.getLampGroups()));
                }

                if (showLamps()) {
                    selectedItems.addAll(Arrays.asList(pendingMembers.getLamps()));
                }
            }
        }

        if (showScenes()) {
            String[] pendingScenes = getPendingScenes();

            if (pendingScenes != null) {
                if (selectedItems == null) {
                    selectedItems = new HashSet<String>();
                }

                selectedItems.addAll(Arrays.asList(pendingScenes));
            }
        }
    }

    protected LampGroup getPendingMembers() {
        return null;
    }

    protected String getPendingItemID() {
        return null;
    }

    protected String[] getPendingScenes() {
        return null;
    }

    protected boolean processLampID(SampleAppActivity activity, String lampID, List<String> lampIDs, LampCapabilities capability) {
        LampDataModel lampModel = activity.systemManager.getLampCollectionManager().getModel(lampID);
        boolean found = lampModel != null;

        if (found) {
            lampIDs.add(lampID);
            capability.includeData(lampModel.getCapability());
        }

        return found;
    }

    protected boolean processGroupID(SampleAppActivity activity, String groupID, List<String> groupIDs, LampCapabilities capability) {
        GroupDataModel groupModel = activity.systemManager.getGroupCollectionManager().getModel(groupID);
        boolean found = groupModel != null;

        if (found) {
            groupIDs.add(groupID);
            capability.includeData(groupModel.getCapability());
        }

        return found;
    }

    protected boolean processSceneID(SampleAppActivity activity, String sceneID, List<String> sceneIDs, LampCapabilities capability) {
        SceneDataModel sceneModel = activity.systemManager.getSceneCollectionManagerV1().getModel(sceneID);
        boolean found = sceneModel != null;

        if (found) {
            sceneIDs.add(sceneID);
            //TODO-FIX capability.includeData(sceneModel.getCapability());
        }

        return found;
    }

    protected boolean processSelection() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        LampCapabilities capability = new LampCapabilities();

        List<String> selectedItemIDs = getSelectedIDs();

        List<String> lampIDs = new ArrayList<String>();
        List<String> groupIDs = new ArrayList<String>();
        List<String> sceneIDs = new ArrayList<String>();

        for (int index = 0; index < selectedItemIDs.size(); index++) {
            String itemID = selectedItemIDs.get(index);

            if (processLampID(activity, itemID, lampIDs, capability)) {
                Log.d(SampleAppActivity.TAG, "Adding lamp ID: " + itemID);
            } else if (processGroupID(activity, itemID, groupIDs, capability)) {
                Log.d(SampleAppActivity.TAG, "Adding group ID: " + itemID);
            } else if (processSceneID(activity, itemID, sceneIDs, capability)) {
                Log.d(SampleAppActivity.TAG, "Adding scene ID: " + itemID);
            } else {
                Log.w(SampleAppActivity.TAG, "Couldn't find itemID " + itemID);
            }
        }

        int count = lampIDs.size() + groupIDs.size() + sceneIDs.size();
        boolean valid = count > 0;

        if (valid) {
            processSelection(activity, lampIDs, groupIDs, sceneIDs, capability);
        } else {
            String text = String.format(getResources().getString(R.string.toast_members_missing), getResources().getString(labelStringID));
            activity.showToast(text);
        }

        return valid;
    }

    protected void processSelection(final SampleAppActivity activity, final List<String> lampIDs, final List<String> groupIDs, final List<String> sceneIDs, LampCapabilities capability) {
        if (confirmMixedSelection() && capability.isMixed()) {
            // detected a mixed group of lamps
            AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(getActivity());
            alertDialogBuilder.setTitle(R.string.mixing_lamp_types);
            alertDialogBuilder.setMessage(getMixedSelectionMessageID());
            alertDialogBuilder.setPositiveButton(getMixedSelectionPositiveButtonID(), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int id) {
                    processSelection(activity, lampIDs, groupIDs, sceneIDs);
                }
            });
            alertDialogBuilder.setNegativeButton(R.string.back, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int id) {
                    dialog.cancel();
                }
            });

            // create alert dialog and show it
            AlertDialog alertDialog = alertDialogBuilder.create();
            alertDialog.show();
        } else {
            processSelection(activity, lampIDs, groupIDs, sceneIDs);
        }
    }

    protected abstract void processSelection(SampleAppActivity activity, List<String> lampIDs, List<String> groupIDs, List<String> sceneIDs);
    protected abstract int getMixedSelectionMessageID();
    protected abstract int getMixedSelectionPositiveButtonID();
}
