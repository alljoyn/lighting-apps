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
import org.allseen.lsf.helper.model.TransitionEffectDataModel;

public class TransitionEffect extends ColorItem implements Effect {

    private TransitionEffectDataModel transitionEffectModel;

    public TransitionEffect(String transitionEffectId) {
        this(transitionEffectId, null);
    }

    public TransitionEffect(String transitionEffectId, String transitionEffectName) {
        super();

        transitionEffectModel = new TransitionEffectDataModel(transitionEffectId, transitionEffectName);
    }

    public void applyTo(GroupMember member) {
//        member.applyEffect(this);
        // TODO-FIX to use above impl
        if (member instanceof Lamp) {
            AllJoynManager.transitionEffectManager.applyTransitionEffectOnLamps(transitionEffectModel.id, new String[] { member.getColorDataModel().id });
        } else if (member instanceof Group) {
            AllJoynManager.transitionEffectManager.applyTransitionEffectOnLampGroups(transitionEffectModel.id, new String [] { member.getColorDataModel().id });
        }
    }

    public void modify(LampState state, long duration) {
        if (state instanceof Preset) {
            AllJoynManager.transitionEffectManager.updateTransitionEffect(transitionEffectModel.id, LightingItemUtil.createTransitionEffect((Preset) state, duration));
        } else {
            AllJoynManager.transitionEffectManager.updateTransitionEffect(transitionEffectModel.id,
                    LightingItemUtil.createTransitionEffect(state.getPowerOn(), state.getColorHsvt(), duration));
        }
    }

    @Override
    public void rename(String effectName) {
        AllJoynManager.transitionEffectManager.setTransitionEffectName(transitionEffectModel.id, effectName,
                LightingDirector.get().getDefaultLanguage());
    }

    public void delete() {
        AllJoynManager.transitionEffectManager.deleteTransitionEffect(transitionEffectModel.id);
    }

    public TransitionEffectDataModel getTransitionEffectDataModel() {
        return transitionEffectModel;
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getTransitionEffectDataModel();
    }
}
