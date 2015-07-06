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

import org.allseen.lsf.sdk.Effect;
import org.allseen.lsf.sdk.Preset;
import org.allseen.lsf.sdk.PulseEffect;
import org.allseen.lsf.sdk.SceneElement;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.TransitionEffect;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.TextView;

public class SceneElementV2InfoFragment extends PageFrameChildFragment implements View.OnClickListener {
    public static PendingSceneElementV2 pendingSceneElement = new PendingSceneElementV2();

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_scene_element_info, container, false);

        // Icon
        View statusView = view.findViewById(R.id.sceneElementInfoStatus);

        setImageButtonBackgroundResource(statusView, R.id.statusButtonPower, R.drawable.scene_element_set_icon);

        // Name
        TextView nameLabel = (TextView)statusView.findViewById(R.id.statusLabelName);
        nameLabel.setText(R.string.scene_element_info_name);
        nameLabel.setClickable(true);
        nameLabel.setOnClickListener(this);

        TextView nameText = (TextView)statusView.findViewById(R.id.statusTextName);
        nameText.setClickable(true);
        nameText.setOnClickListener(this);

        // Members
        View membersView = view.findViewById(R.id.sceneElementInfoMembers);
        membersView.setClickable(true);
        membersView.setOnClickListener(this);

        setTextViewValue(membersView, R.id.nameValueNameText, getString(R.string.scene_element_info_members), 0);

        // Effect
        View effectView = view.findViewById(R.id.sceneElementInfoEffect);
        effectView.setClickable(true);
        effectView.setOnClickListener(this);

        // Update values
        SampleAppActivity activity = (SampleAppActivity) getActivity();
        SceneElement sceneElement = LightingDirector.get().getSceneElement(key);

        updateSceneElementInfoFields(activity, sceneElement);

        return view;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_scene_element_info, false, false, false, false, true);
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
        SceneElement sceneElement = LightingDirector.get().getSceneElement(key);

        activity.showItemNameDialog(R.string.title_scene_element_rename, new UpdateSceneElementNameAdapter(sceneElement, activity));
    }

    protected void onMembersClick() {
        pendingSceneElement.init(LightingDirector.get().getSceneElement(key));

        ((ScenesPageFragment)parent).showSelectMembersChildFragment();
    }

    public void updateInfoFields() {
        updateSceneElementInfoFields((SampleAppActivity)getActivity(), LightingDirector.get().getSceneElement(key));
    }

    protected void updateSceneElementInfoFields(SampleAppActivity activity, SceneElement sceneElement) {
        // Update name and members
        setTextViewValue(view.findViewById(R.id.sceneElementInfoStatus), R.id.statusTextName, sceneElement.getName(), 0);
        setTextViewValue(view.findViewById(R.id.sceneElementInfoMembers), R.id.nameValueValueText, Util.createMemberNamesString(activity, sceneElement, ", ", R.string.scene_element_members_none), 0);

        updateEffectFields(activity, view.findViewById(R.id.sceneElementInfoEffect), sceneElement.getEffect());
    }

    protected void updateEffectFields(SampleAppActivity activity, View effectView, Effect effect) {
        int iconID =
            effect instanceof Preset            ? R.drawable.list_constant_icon :
            effect instanceof TransitionEffect  ? R.drawable.list_transition_icon :
            effect instanceof PulseEffect       ? R.drawable.list_pulse_icon :
            /* unknown effect */                  R.drawable.list_constant_icon;

        ((ImageButton)effectView.findViewById(R.id.detailedItemButtonIcon)).setImageResource(iconID);

        TextView textHeader = (TextView)effectView.findViewById(R.id.detailedItemRowTextHeader);
        textHeader.setText(effect.getName());
        textHeader.setTag(effect.getId());
        textHeader.setClickable(true);
        textHeader.setOnClickListener(this);

        TextView textDetails = (TextView)effectView.findViewById(R.id.detailedItemRowTextDetails);
        textDetails.setText("");
        textDetails.setTag(effect.getId());
        textDetails.setClickable(true);
        textDetails.setOnClickListener(this);

        ImageButton moreButton = (ImageButton)effectView.findViewById(R.id.detailedItemButtonMore);
        moreButton.setImageResource(R.drawable.group_more_menu_icon);
        moreButton.setTag(effect.getId());
        moreButton.setOnClickListener(this);
    }
}
