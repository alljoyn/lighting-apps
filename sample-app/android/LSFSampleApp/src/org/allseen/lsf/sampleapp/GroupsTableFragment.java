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

import java.util.Iterator;

import org.allseen.lsf.sdk.model.GroupDataModel;
import org.allseen.lsf.sdk.model.LampCapabilities;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class GroupsTableFragment extends DimmableItemTableFragment {

    public GroupsTableFragment() {
        super();
        type = SampleAppActivity.Type.GROUP;
    }

    @Override
    protected int getInfoButtonImageID() {
        return R.drawable.nav_more_menu_icon;
    }

    @Override
    protected Fragment getInfoFragment() {
        return new GroupInfoFragment();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View root = super.onCreateView(inflater, container, savedInstanceState);
        Iterator<String> i = ((SampleAppActivity)getActivity()).systemManager.getGroupCollectionManager().getIDIterator();

        while(i.hasNext()) {
            addElement(i.next());
        }

        return root;
    }

    @Override
    public void addElement(String id) {
        GroupDataModel groupModel = ((SampleAppActivity) getActivity()).systemManager.getGroupCollectionManager().getModel(id);
        if (groupModel != null) {
            insertDimmableItemRow(getActivity(), groupModel.id, groupModel.tag, groupModel.state.getOnOff(), groupModel.uniformity.power, groupModel.getName(), groupModel.state.getBrightness(), groupModel.uniformity.brightness, 0, groupModel.getCapability().dimmable >= LampCapabilities.SOME);
        }
    }
}
