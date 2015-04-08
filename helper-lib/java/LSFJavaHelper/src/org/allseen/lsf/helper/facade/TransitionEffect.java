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

import org.allseen.lsf.helper.model.ColorItemDataModel;
import org.allseen.lsf.helper.model.TransitionEffectDataModel;

public class TransitionEffect extends ColorItem implements Effect {

    private TransitionEffectDataModel transitionEffectModel;

    public TransitionEffect(String transitionEffectId) {
        // TODO-IMPL
    }

    public TransitionEffect(String transitionEffectId, String transitionEffectName) {
        // TODO-IMPL
    }

    public void applyTo(GroupMember member) {
        member.applyEffect(this);
    }

    public void modify(LampState state, long duration) {
        // TODO-IMPL
    }

    @Override
    public void rename(String effectName) {
        // TODO-IMPL
    }

    public void delete() {
        // TODO-IMPl
    }

    @Override
    public void setPowerOn(boolean powerOn) {
        // TODO Auto-generated method stub

    }

    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        // TODO Auto-generated method stub
    }

    public TransitionEffectDataModel getTransistionEffectDataModel() {
        return transitionEffectModel;
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getTransistionEffectDataModel();
    }
}
