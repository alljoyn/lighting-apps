/*
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
package org.allseen.lsf.sampleapp.scenesv1;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sampleapp.ItemNameAdapter;
import org.allseen.lsf.sampleapp.PageMainContainerFragment;
import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sampleapp.SampleAppActivity;
import org.allseen.lsf.sampleapp.SceneItemInfoFragment;
import org.allseen.lsf.sampleapp.ScenesPageFragment;
import org.allseen.lsf.sampleapp.UpdateBasicSceneNameAdapter;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.Scene;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.NoEffectDataModel;
import org.allseen.lsf.sdk.model.PulseEffectDataModel;
import org.allseen.lsf.sdk.model.SceneDataModel;
import org.allseen.lsf.sdk.model.TransitionEffectDataModel;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TableLayout;
import android.widget.TextView;

public class BasicSceneV1InfoFragment extends SceneItemInfoFragment {
    public static SceneDataModel pendingBasicSceneModel;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        SampleAppActivity activity = (SampleAppActivity) getActivity();

        NoEffectFragment.pendingNoEffect = null;
        TransitionEffectV1Fragment.pendingTransitionEffect = null;
        PulseEffectV1Fragment.pendingPulseEffect = null;

        view = inflater.inflate(R.layout.fragment_basic_scene_info, container, false);
        View statusView = view.findViewById(R.id.infoStatusRow);

        setImageButtonBackgroundResource(statusView, R.id.statusButtonPower, R.drawable.scene_set_icon);

        // item name
        TextView nameLabel = (TextView)statusView.findViewById(R.id.statusLabelName);
        nameLabel.setText(R.string.basic_scene_info_name);
        nameLabel.setClickable(true);
        nameLabel.setOnClickListener(this);

        TextView nameText = (TextView)statusView.findViewById(R.id.statusTextName);
        nameText.setClickable(true);
        nameText.setOnClickListener(this);

        updateBasicSceneInfoFields(activity, pendingBasicSceneModel);

        return view;
    }

    @Override
    public void onActionAdd() {
        EffectV1InfoFragment.pendingBasicSceneElementMembers = new LampGroup();
        EffectV1InfoFragment.pendingBasicSceneElementCapability = new LampCapabilities(true, true, true);

        NoEffectFragment.pendingNoEffect = null;
        TransitionEffectV1Fragment.pendingTransitionEffect = null;
        PulseEffectV1Fragment.pendingPulseEffect = null;

        ((PageMainContainerFragment)parent).showSelectMembersChildFragment();
    }

    @Override
    public void onActionDone() {
        if (pendingBasicSceneModel.id != null && !pendingBasicSceneModel.hasDefaultID()) {
            AllJoynManager.sceneManager.updateScene(pendingBasicSceneModel.id, pendingBasicSceneModel.toScene());
//TODO-DEL? Not sure why this was here:            LightingDirector.get().getLightingSystemManager().getSceneCollectionManagerV1().addScene(pendingBasicSceneModel);
        } else {
            AllJoynManager.sceneManager.createScene(pendingBasicSceneModel.toScene(), pendingBasicSceneModel.getName(), SampleAppActivity.LANGUAGE);
        }

        parent.clearBackStack();
    }

    @Override
    public void onClick(View view) {
        int viewID = view.getId();

        if (viewID == R.id.statusLabelName || viewID == R.id.statusTextName) {
            onHeaderClick();
        } else if (viewID == R.id.detailedItemRowTextHeader || viewID == R.id.detailedItemRowTextDetails) {
            onElementTextClick(view.getTag().toString());
        } else if (viewID == R.id.detailedItemButtonMore) {
            onElementMoreClick(view, view.getTag().toString());
        }
    }

    protected void onHeaderClick() {
        Scene basicScene = LightingDirector.get().getScene(pendingBasicSceneModel.id);
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        ItemNameAdapter basicSceneNameAdapter = new UpdateBasicSceneNameAdapter(basicScene, activity);

        activity.showItemNameDialog(R.string.title_basic_scene_rename, basicSceneNameAdapter);
    }

    protected void onElementTextClick(String elementID) {
        if (pendingBasicSceneModel.noEffects != null) {
            for (NoEffectDataModel elementModel : pendingBasicSceneModel.noEffects) {
                if (elementID.equals(elementModel.id)) {
                    EffectV1InfoFragment.pendingBasicSceneElementMembers = new LampGroup(elementModel.members);
                    EffectV1InfoFragment.pendingBasicSceneElementCapability = new LampCapabilities(elementModel.getCapability());

                    NoEffectFragment.pendingNoEffect = new PendingNoEffect(elementModel);
                    TransitionEffectV1Fragment.pendingTransitionEffect = null;
                    PulseEffectV1Fragment.pendingPulseEffect = null;

                    ((ScenesPageFragment)parent).showSelectMembersChildFragment();
                    return;
                }
            }
        }

        if (pendingBasicSceneModel.transitionEffects != null) {
            for (TransitionEffectDataModel elementModel : pendingBasicSceneModel.transitionEffects) {
                if (elementID.equals(elementModel.id)) {
                    EffectV1InfoFragment.pendingBasicSceneElementMembers = new LampGroup(elementModel.members);
                    EffectV1InfoFragment.pendingBasicSceneElementCapability = new LampCapabilities(elementModel.getCapability());

                    NoEffectFragment.pendingNoEffect = null;
                    TransitionEffectV1Fragment.pendingTransitionEffect = new PendingTransitionEffectV1(elementModel);
                    PulseEffectV1Fragment.pendingPulseEffect = null;

                    ((ScenesPageFragment)parent).showSelectMembersChildFragment();
                    return;
                }
            }
        }

        if (pendingBasicSceneModel.pulseEffects != null) {
            for (PulseEffectDataModel elementModel : pendingBasicSceneModel.pulseEffects) {
                if (elementID.equals(elementModel.id)) {
                    EffectV1InfoFragment.pendingBasicSceneElementMembers = new LampGroup(elementModel.members);
                    EffectV1InfoFragment.pendingBasicSceneElementCapability = new LampCapabilities(elementModel.getCapability());

                    NoEffectFragment.pendingNoEffect = null;
                    TransitionEffectV1Fragment.pendingTransitionEffect = null;
                    PulseEffectV1Fragment.pendingPulseEffect = new PendingPulseEffectV1(elementModel);

                    ((ScenesPageFragment)parent).showSelectMembersChildFragment();
                    return;
                }
            }
        }
    }

    protected void onElementMoreClick(View anchor, String elementID) {
        int count = pendingBasicSceneModel.noEffects.size() + pendingBasicSceneModel.transitionEffects.size() + pendingBasicSceneModel.pulseEffects.size();

        ((SampleAppActivity)getActivity()).onItemButtonMore(parent, SampleAppActivity.Type.ELEMENT, anchor, key, elementID, count > 1);
    }

    @Override
    public void updateInfoFields() {
        updateBasicSceneInfoFields((SampleAppActivity)getActivity(), pendingBasicSceneModel);
    }

    protected void updateBasicSceneInfoFields(SampleAppActivity activity, SceneDataModel basicSceneModel) {
        // Update name and members
        setTextViewValue(view, R.id.statusTextName, basicSceneModel.getName(), 0);

        // Displays list of effects in this scene
        TableLayout elementsTable = (TableLayout) view.findViewById(R.id.sceneInfoElementTable);
        elementsTable.removeAllViews();

        if (basicSceneModel.noEffects != null) {
            for (NoEffectDataModel elementModel : basicSceneModel.noEffects) {
                addElementRow(activity, elementsTable, R.drawable.list_constant_icon, elementModel.id, elementModel.members, R.string.effect_name_none);
            }
        }

        if (basicSceneModel.transitionEffects != null) {
            for (TransitionEffectDataModel elementModel : basicSceneModel.transitionEffects) {
                addElementRow(activity, elementsTable, R.drawable.list_transition_icon, elementModel.id, elementModel.members, R.string.effect_name_transition);
            }
        }

        if (basicSceneModel.pulseEffects != null) {
            for (PulseEffectDataModel elementModel : basicSceneModel.pulseEffects) {
                addElementRow(activity, elementsTable, R.drawable.list_pulse_icon, elementModel.id, elementModel.members, R.string.effect_name_pulse);
            }
        }

        if (elementsTable.getChildCount() == 0) {
            //TODO-CHK Do we show "no effects" here?
        }
    }

    protected void addElementRow(SampleAppActivity activity, TableLayout elementTable, int iconID, String elementID, LampGroup members, int detailsID) {
        addElementRow(activity, elementTable, iconID, elementID, BasicSceneV1Util.createMemberNamesString(activity, members, System.getProperty("line.separator"), R.string.basic_scene_members_none), getString(detailsID));
    }
}