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
package org.allseen.lsf.sampleapp.scenesv1;

import org.allseen.lsf.sampleapp.DimmableItemPresetsFragment;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.Preset;

public class SceneElementV1PresetsFragment extends DimmableItemPresetsFragment {

    @Override
    protected MyLampState getItemLampState() {
        MyLampState lampState;

        if (NoEffectFragment.pendingNoEffect != null) {
            lampState = NoEffectFragment.pendingNoEffect.state;
        } else if (TransitionEffectV1Fragment.pendingTransitionEffect != null) {
            lampState = TransitionEffectV1Fragment.pendingTransitionEffect.state;
        } else if (key2 != PulseEffectV1Fragment.STATE2_ITEM_TAG) {
            lampState = PulseEffectV1Fragment.pendingPulseEffect.startState;
        } else {
            lampState = PulseEffectV1Fragment.pendingPulseEffect.endState;
        }

        return lampState;
    }

    @Override
    protected void doApplyPreset(Preset preset) {
        if (NoEffectFragment.pendingNoEffect != null) {
            NoEffectFragment.pendingNoEffect.presetID = preset.getId();
            NoEffectFragment.pendingNoEffect.state = preset.getState();
        } else if (TransitionEffectV1Fragment.pendingTransitionEffect != null) {
            TransitionEffectV1Fragment.pendingTransitionEffect.presetID = preset.getId();
            TransitionEffectV1Fragment.pendingTransitionEffect.state = preset.getState();
        } else if (key2 != PulseEffectV1Fragment.STATE2_ITEM_TAG) {
            PulseEffectV1Fragment.pendingPulseEffect.startPresetID = preset.getId();
            PulseEffectV1Fragment.pendingPulseEffect.startState = preset.getState();
        } else {
            PulseEffectV1Fragment.pendingPulseEffect.endPresetID = preset.getId();
            PulseEffectV1Fragment.pendingPulseEffect.endState = preset.getState();
        }
    }
}
