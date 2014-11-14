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
package org.allseen.lsf.sampleapp;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.allseen.lsf.LampDetails;
import org.allseen.lsf.LampGroup;

import android.view.Menu;
import android.view.MenuInflater;

public class BasicSceneSelectMembersFragment extends SelectMembersFragment {

    public BasicSceneSelectMembersFragment() {
        super(R.string.label_basic_scene);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_basic_scene_element_add, false, false, true, false, true);
    }

    @Override
    protected String getHeaderText() {
        return getString(R.string.basic_scene_select_members);
    }

    @Override
    protected LampGroup getPendingMembers() {
        return ((SampleAppActivity)getActivity()).pendingBasicSceneElementMembers;
    }

    @Override
    protected String getPendingItemID() {
        return ((SampleAppActivity)getActivity()).pendingBasicSceneModel.id;
    }

    @Override
    protected void processSelection(SampleAppActivity activity, List<String> lampIDs, List<String> groupIDs, List<String> sceneIDs, CapabilityData capability) {
        activity.pendingBasicSceneElementCapability = capability;
        super.processSelection(activity, lampIDs, groupIDs, sceneIDs, capability);
    }

    @Override
    protected void processSelection(SampleAppActivity activity, List<String> lampIDs, List<String> groupIDs, List<String> sceneIDs) {
        activity.pendingBasicSceneElementMembers.setLamps(lampIDs.toArray(new String[lampIDs.size()]));
        activity.pendingBasicSceneElementMembers.setLampGroups(groupIDs.toArray(new String[groupIDs.size()]));

        activity.pendingBasicSceneElementMembersHaveEffects = false;
        activity.pendingBasicSceneElementMembersMinColorTemp = -1;
        activity.pendingBasicSceneElementMembersMaxColorTemp = -1;

        activity.pendingBasicSceneElementColorTempAverager.reset();

        processGroupSelection(activity, groupIDs);
        processLampSelection(activity, lampIDs);

        if (activity.pendingBasicSceneElementMembersMinColorTemp == -1) {
            activity.pendingBasicSceneElementMembersMinColorTemp = DimmableItemScaleConverter.VIEW_COLORTEMP_MIN;
        }

        if (activity.pendingBasicSceneElementMembersMaxColorTemp == -1) {
            activity.pendingBasicSceneElementMembersMaxColorTemp = DimmableItemScaleConverter.VIEW_COLORTEMP_MAX;
        }
    }

    protected void processGroupSelection(SampleAppActivity activity, List<String> groupIDs) {
        if (groupIDs.size() > 0) {
            for (Iterator<String> it = groupIDs.iterator(); it.hasNext();) {
                processLampSelection(activity, it.next());
            }
        }
    }

    protected void processLampSelection(SampleAppActivity activity, String groupID) {
        GroupDataModel groupModel = activity.groupModels.get(groupID);

        if (groupModel != null) {
            processLampSelection(activity, groupModel.getLamps());
        }
    }

    protected void processLampSelection(SampleAppActivity activity, Collection<String> lampIDs) {
        if (lampIDs.size() > 0) {
            for (Iterator<String> it = lampIDs.iterator(); it.hasNext();) {
                LampDataModel lampModel = activity.lampModels.get(it.next());

                if (lampModel != null) {
                    LampDetails lampDetails = lampModel.getDetails();

                    if (lampDetails != null) {
                        boolean lampHasEffects = lampDetails.hasEffects();
                        boolean lampHasVariableColorTemp = lampDetails.hasVariableColorTemp();
                        int lampMinTemperature = lampDetails.getMinTemperature();
                        int lampMaxTemperature = lampHasVariableColorTemp ? lampDetails.getMaxTemperature() : lampMinTemperature;
                        boolean lampValidColorTempMin = lampMinTemperature >= DimmableItemScaleConverter.VIEW_COLORTEMP_MIN && lampMinTemperature <= DimmableItemScaleConverter.VIEW_COLORTEMP_MAX;
                        boolean lampValidColorTempMax = lampMaxTemperature >= DimmableItemScaleConverter.VIEW_COLORTEMP_MIN && lampMaxTemperature <= DimmableItemScaleConverter.VIEW_COLORTEMP_MAX;

                        if (lampHasEffects) {
                            activity.pendingBasicSceneElementMembersHaveEffects = true;
                        }

                        if (lampHasVariableColorTemp) {
                            activity.pendingBasicSceneElementColorTempAverager.add(lampModel.state.getColorTemp());
                        } else if (lampValidColorTempMin) {
                            activity.pendingBasicSceneElementColorTempAverager.add(DimmableItemScaleConverter.convertColorTempViewToModel(lampMinTemperature));
                        }

                        if (lampValidColorTempMin && lampValidColorTempMax) {
                            if (lampMinTemperature < activity.pendingBasicSceneElementMembersMinColorTemp || activity.pendingBasicSceneElementMembersMinColorTemp == -1) {
                                activity.pendingBasicSceneElementMembersMinColorTemp = lampMinTemperature;
                            }

                            if (lampMaxTemperature < activity.pendingBasicSceneElementMembersMaxColorTemp || activity.pendingBasicSceneElementMembersMaxColorTemp == -1) {
                                activity.pendingBasicSceneElementMembersMaxColorTemp = lampMaxTemperature;
                            }
                        }
                    }
                }
            }
        }
    }

    @Override
    public void onActionNext() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();

        if (processSelection()) {
            if (activity.pendingBasicSceneElementMembersHaveEffects) {
                if (activity.pendingNoEffectModel != null) {
                    showNoEffectChildFragment(activity);
                } else if (activity.pendingTransitionEffectModel != null) {
                    showTransitionEffectChildFragment(activity);
                } else if (activity.pendingPulseEffectModel != null) {
                    showPulseEffectChildFragment(activity);
                } else {
                    showSelectEffectChildFragment(activity);
                }
            } else {
                if (activity.pendingNoEffectModel == null) {
                    activity.pendingNoEffectModel = new NoEffectDataModel();
                }

                showNoEffectChildFragment(activity);
            }
        }
    }

    protected void showSelectEffectChildFragment(SampleAppActivity activity) {
        activity.pendingNoEffectModel = null;
        activity.pendingTransitionEffectModel = null;
        activity.pendingPulseEffectModel = null;

        ((ScenesPageFragment)parent).showSelectEffectChildFragment();
    }

    protected void showNoEffectChildFragment(SampleAppActivity activity) {
        activity.pendingTransitionEffectModel = null;
        activity.pendingPulseEffectModel = null;

        ((ScenesPageFragment)parent).showNoEffectChildFragment();
    }

    protected void showTransitionEffectChildFragment(SampleAppActivity activity) {
        activity.pendingNoEffectModel = null;
        activity.pendingPulseEffectModel = null;

        ((ScenesPageFragment)parent).showTransitionEffectChildFragment();
    }

    protected void showPulseEffectChildFragment(SampleAppActivity activity) {
        activity.pendingNoEffectModel = null;
        activity.pendingTransitionEffectModel = null;

        ((ScenesPageFragment)parent).showPulseEffectChildFragment();
    }

    @Override
    protected int getMixedSelectionMessageID() {
        return R.string.mixing_lamp_types_message_scene;
    }

    @Override
    protected int getMixedSelectionPositiveButtonID() {
        return R.string.create_scene;
    }
}