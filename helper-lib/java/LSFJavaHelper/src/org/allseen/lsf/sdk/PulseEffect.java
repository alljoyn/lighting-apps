/*
 * Copyright AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.sdk;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.ColorItemDataModel;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.PulseEffectDataModelV2;

public class PulseEffect extends ColorItem implements Effect {

    private PulseEffectDataModelV2 pulseEffectModel;

    public PulseEffect(String pulseEffectId) {
        this(pulseEffectId, null);
    }

    public PulseEffect(String pulseEffectId, String pulseEffectName) {
        super();

        pulseEffectModel = new PulseEffectDataModelV2(pulseEffectId, pulseEffectName);
    }

    @Override
    public void applyTo(GroupMember member) {
        String errorContext = "PulseEffect.applyTo() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            member.applyEffect(this);
        }
    }

    public void modify(LampState fromState, LampState toState, long period, long duration, long count) {
        String errorContext = "PulseEffect.modify() error";

        if (postInvalidArgIfNull(errorContext, fromState) && postInvalidArgIfNull(errorContext, toState)) {
            if (fromState instanceof Preset && toState instanceof Preset) {
                postErrorIfFailure(errorContext,
                    AllJoynManager.pulseEffectManager.updatePulseEffect(pulseEffectModel.id,
                            LightingItemUtil.createPulseEffect((Preset)fromState, (Preset)toState, period, duration, count)));
            } else {
                postErrorIfFailure(errorContext,
                    AllJoynManager.pulseEffectManager.updatePulseEffect(pulseEffectModel.id,
                            LightingItemUtil.createPulseEffect(fromState.getPowerOn(), fromState.getColorHsvt(), toState.getPowerOn(), toState.getColorHsvt(), period, duration, count)));
            }
        }
    }

    @Override
    public void rename(String effectName) {
        String errorContext = "PulseEffect.rename() error";

        if (postInvalidArgIfNull(errorContext, effectName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.pulseEffectManager.setPulseEffectName(pulseEffectModel.id, effectName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    public void delete() {
        String errorContext = "PulseEffect.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.pulseEffectManager.deletePulseEffect(pulseEffectModel.id));
    }

    public PulseEffectDataModelV2 getPulseEffectDataModel() {
        return pulseEffectModel;
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getPulseEffectDataModel();
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getPulseEffectCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
