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

import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.Scene;
import org.allseen.lsf.sdk.SceneV2;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class BasicSceneV2InfoFragment extends SceneItemInfoFragment {
    public static PendingSceneV2 pendingSceneV2 = null;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_basic_scene_v2_info, container, false);

        View statusView = view.findViewById(R.id.infoStatusRow);

        setImageButtonBackgroundResource(statusView, R.id.statusButtonPower, R.drawable.scene_set_icon);

        // Name
        TextView nameLabel = (TextView)statusView.findViewById(R.id.statusLabelName);
        nameLabel.setText(R.string.basic_scene_info_name);
        nameLabel.setClickable(true);
        nameLabel.setOnClickListener(this);

        TextView nameText = (TextView)statusView.findViewById(R.id.statusTextName);
        nameText.setClickable(true);
        nameText.setOnClickListener(this);

        // Members
        View rowMembers = view.findViewById(R.id.sceneV2InfoRowMembers);
        rowMembers.setClickable(true);
        rowMembers.setOnClickListener(this);

        setTextViewValue(rowMembers, R.id.sceneMembersRowLabel, getString(R.string.basic_scene_info_elements), 0);

        updateInfoFields();

        return view;
    }

    @Override
    public void updateInfoFields() {
        updateBasicSceneInfoFields();
    }

    protected void updateBasicSceneInfoFields() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        Scene basicScene = LightingDirector.get().getScene(key);

        // Update name
        setTextViewValue(view, R.id.statusTextName, basicScene.getName(), 0);

        if (basicScene instanceof SceneV2) {
            // update members
            String members = Util.createSceneElementNamesString(activity, (SceneV2)basicScene);

            setTextViewValue(view.findViewById(R.id.sceneV2InfoRowMembers), R.id.sceneMembersRowText, members, 0);
        } else {
            Log.e(SampleAppActivity.TAG, "Invalid scene type");
        }
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_basic_scene_info, false, false, false, false, true);
    }

    @Override
    public void onClick(View view) {
        int viewID = view.getId();

        if (viewID == R.id.statusLabelName || viewID == R.id.statusTextName) {
            onHeaderClick();
        } else if (viewID == R.id.sceneInfoRowMembers){
            onMembersClick();
        }
    }

    protected void onHeaderClick() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        Scene basicScene = LightingDirector.get().getScene(key);

        activity.showItemNameDialog(R.string.title_basic_scene_rename, new UpdateBasicSceneNameAdapter(basicScene, activity));
    }

    protected void onMembersClick() {
        Scene basicScene = LightingDirector.get().getScene(key);

        if (basicScene instanceof SceneV2) {
            pendingSceneV2 = new PendingSceneV2((SceneV2)basicScene);

            ((ScenesPageFragment)parent).showSelectMembersChildFragment();
        } else {
            Log.e(SampleAppActivity.TAG, "Invalid scene type");
        }
    }
}