/*
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
*/
package org.allseen.lsf.sampleapp.scenesv1;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sampleapp.EffectInfoFragment;
import org.allseen.lsf.sampleapp.PageFrameParentFragment;
import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sdk.ColorAverager;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.model.ColorStateConverter;

public abstract class EffectV1InfoFragment extends EffectInfoFragment {
    public static LampGroup pendingBasicSceneElementMembers;
    public static LampCapabilities pendingBasicSceneElementCapability;
    public static ColorAverager pendingBasicSceneElementColorTempAverager = new ColorAverager();
    public static boolean pendingBasicSceneElementMembersHaveEffects;
    public static int pendingBasicSceneElementMembersMinColorTemp;
    public static int pendingBasicSceneElementMembersMaxColorTemp;

    @Override
    public int getTitleID() {
        return R.string.title_basic_scene_element_add;
    }

    @Override
    protected String getLampStateViewAdapterTag() {
        return STATE_ITEM_TAG;
    }

    @Override
    protected LampCapabilities getPendingMembersCapability() {
        return pendingBasicSceneElementCapability;
    }

    @Override
    public void onActionDone() {
        updatePendingSceneElement();

        pendingBasicSceneElementMembers = null;
        pendingBasicSceneElementCapability = null;

        NoEffectFragment.pendingNoEffect = null;
        TransitionEffectV1Fragment.pendingTransitionEffect = null;
        PulseEffectV1Fragment.pendingPulseEffect = null;

        parent.popBackStack(PageFrameParentFragment.CHILD_TAG_INFO);
    }

    @Override
    protected int getColorTempMin() {
        return pendingBasicSceneElementMembersMinColorTemp;
    }

    @Override
    protected int getColorTempSpan() {
        return pendingBasicSceneElementMembersMaxColorTemp - pendingBasicSceneElementMembersMinColorTemp;
    }

    @Override
    protected int getColorTempDefault() {
        return ColorStateConverter.convertColorTempModelToView(pendingBasicSceneElementColorTempAverager.getAverage());
    }

    protected abstract void updatePendingSceneElement();
}