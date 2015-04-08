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
package org.allseen.lsf.sampleapp;

import org.allseen.lsf.helper.model.AllLampsDataModel;
import org.allseen.lsf.helper.model.ColorItemDataModel;
import org.allseen.lsf.helper.model.ColorStateConverter;
import org.allseen.lsf.helper.model.GroupDataModel;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class GroupInfoFragment extends DimmableItemInfoFragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = super.onCreateView(inflater, container, savedInstanceState);
        String groupID = key;

        itemType = SampleAppActivity.Type.GROUP;

        ((TextView)statusView.findViewById(R.id.statusLabelName)).setText(R.string.label_group_name);

        // displays members of this group
        TextView membersLabel = (TextView)(view.findViewById(R.id.groupInfoMembers).findViewById(R.id.nameValueNameText));
        membersLabel.setText(R.string.group_info_label_members);
        membersLabel.setClickable(true);
        membersLabel.setOnClickListener(this);

        TextView membersValue = (TextView)(view.findViewById(R.id.groupInfoMembers).findViewById(R.id.nameValueValueText));
        membersValue.setClickable(true);
        membersValue.setOnClickListener(this);

        updateInfoFields(((SampleAppActivity)getActivity()).systemManager.getGroupCollectionManager().getModel(groupID));

        return view;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_group_info, false, false, false, false, true);
    }

    @Override
    public void onClick(View view) {
        int viewID = view.getId();

        if (viewID == R.id.nameValueNameText || viewID == R.id.nameValueValueText) {
            if ((parent != null) && (!AllLampsDataModel.ALL_LAMPS_GROUP_ID.equals(key))) {
                GroupDataModel groupModel = ((SampleAppActivity)getActivity()).systemManager.getGroupCollectionManager().getModel(key);

                if (groupModel != null) {
                    ((SampleAppActivity)getActivity()).pendingGroupModel = new GroupDataModel(groupModel);
                    ((PageMainContainerFragment)parent).showSelectMembersChildFragment();
                }
            }
        } else {
            super.onClick(view);
        }
    }

    public void updateInfoFields(GroupDataModel groupModel) {
        if (groupModel.id.equals(key)) {
            stateAdapter.setCapability(groupModel.getCapability());
            super.updateInfoFields(groupModel);

            String details = Util.createMemberNamesString((SampleAppActivity)getActivity(), groupModel.members, ", ", R.string.group_info_members_none);
            TextView membersValue = (TextView)(view.findViewById(R.id.groupInfoMembers).findViewById(R.id.nameValueValueText));

            if (details != null && !details.isEmpty()) {
                membersValue.setText(details);
            }
        }
    }

    @Override
    protected int getLayoutID() {
        return R.layout.fragment_group_info;
    }

    @Override
    protected int getColorTempMin() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        GroupDataModel groupModel = activity.systemManager.getGroupCollectionManager().getModel(key);

        return groupModel != null ? groupModel.viewColorTempMin : ColorStateConverter.VIEW_COLORTEMP_MIN;
    }

    @Override
    protected int getColorTempSpan() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        GroupDataModel groupModel = activity.systemManager.getGroupCollectionManager().getModel(key);

        return groupModel != null ? groupModel.viewColorTempMax - groupModel.viewColorTempMin : ColorStateConverter.VIEW_COLORTEMP_SPAN;
    }

    @Override
    protected long getColorTempDefault() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        GroupDataModel groupModel = activity.systemManager.getGroupCollectionManager().getModel(key);

        return groupModel.state.getColorTemp();
    }

    @Override
    protected void onHeaderClick() {
        if (!AllLampsDataModel.ALL_LAMPS_GROUP_ID.equals(key)) {
            SampleAppActivity activity = (SampleAppActivity)getActivity();
            GroupDataModel groupModel = activity.systemManager.getGroupCollectionManager().getModel(key);

            activity.showItemNameDialog(R.string.title_group_rename, new UpdateGroupNameAdapter(groupModel, (SampleAppActivity) getActivity()));
        }
    }

    @Override
    protected ColorItemDataModel getColorItemDataModel(String groupID){
        return ((SampleAppActivity)getActivity()).systemManager.getGroupCollectionManager().getModel(groupID);
    }
}