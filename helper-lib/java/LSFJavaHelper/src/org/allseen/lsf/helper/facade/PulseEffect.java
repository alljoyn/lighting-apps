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
package org.allseen.lsf.helper.facade;

import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.ColorItemDataModel;
import org.allseen.lsf.helper.model.LightingItemUtil;
import org.allseen.lsf.helper.model.PulseEffectDataModel;

public class PulseEffect extends ColorItem implements Effect {

    private PulseEffectDataModel pulseEffectModel;

    public PulseEffect(String pulseEffectId) {
        this(pulseEffectId, null);
    }

    public PulseEffect(String pulseEffectId, String pulseEffectName) {
        super();

        pulseEffectModel = new PulseEffectDataModel(pulseEffectId, pulseEffectName);
    }

    public void applyTo(GroupMember member) {
//        member.applyEffect(this);
     // TODO-FIX to use above impl
        if (member instanceof Lamp) {
            AllJoynManager.pulseEffectManager.applyPulseEffectOnLamps(pulseEffectModel.id, new String[] { member.getColorDataModel().id });
        } else if (member instanceof Group) {
            AllJoynManager.pulseEffectManager.applyPulseEffectOnLampGroups(pulseEffectModel.id, new String [] { member.getColorDataModel().id });
        }
    }

    public void modify(LampState fromState, LampState toState, long period, long duration, long count) {
        if (fromState instanceof Preset && toState instanceof Preset) {
            AllJoynManager.pulseEffectManager.updatePulseEffect(pulseEffectModel.id,
                    LightingItemUtil.createPulseEffect((Preset)fromState, (Preset)toState, period, duration, count));
        } else {
            AllJoynManager.pulseEffectManager.updatePulseEffect(pulseEffectModel.id,
                    LightingItemUtil.createPulseEffect(fromState.getPowerOn(), fromState.getColorHsvt(), toState.getPowerOn(), toState.getColorHsvt(), period, duration, count));
        }
    }

    @Override
    public void rename(String effectName) {
        AllJoynManager.pulseEffectManager.setPulseEffectName(pulseEffectModel.id, effectName, LightingDirector.get().getDefaultLanguage());
    }

    public void delete() {
        AllJoynManager.pulseEffectManager.deletePulseEffect(pulseEffectModel.id);
    }

    public PulseEffectDataModel getPulseEffectDataModel() {
        return pulseEffectModel;
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getPulseEffectDataModel();
    }
}
