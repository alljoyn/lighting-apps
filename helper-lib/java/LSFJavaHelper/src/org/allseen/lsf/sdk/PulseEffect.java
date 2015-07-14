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

import java.util.ArrayList;
import java.util.Collection;

import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.ColorItemDataModel;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.PulseEffectDataModelV2;

/**
 * A Pulse Effect object represents a predefined two-color oscillating effect in a lamp.
 */
public class PulseEffect extends ColorItem implements Effect {

    /**
     * Sets the default name for Pulse Effects.
     *
     * @param defaultName The new default name.
     */
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            PulseEffectDataModelV2.defaultName = defaultName;
        }
    }

    protected PulseEffectDataModelV2 pulseEffectModel;

    protected PulseEffect(String pulseEffectId) {
        this(pulseEffectId, null);
    }

    protected PulseEffect(String pulseEffectId, String pulseEffectName) {
        super();

        pulseEffectModel = new PulseEffectDataModelV2(pulseEffectId, pulseEffectName);
    }

    /**
     * Applies the Pulse Effect to the GroupMember provided.
     *
     * @param member The GroupMember the Pulse Effect will be applied to.
     */
    @Override
    public void applyTo(GroupMember member) {
        String errorContext = "PulseEffect.applyTo() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            member.applyEffect(this);
        }
    }

    /**
     * Replaces the Pulse Effect's fromState, toState, period, duration, and count with
     * the corresponding method parameters.
     *
     * @param fromState The new fromState.
     * @param toState The new toState.
     * @param period The new period.
     * @param duration The new duration, in milliseconds.
     * @param count The new count.
     */
    public void modify(LampState fromState, LampState toState, long period, long duration, long count) {
        String errorContext = "PulseEffect.modify() error";

        if (postInvalidArgIfNull(errorContext, fromState) && postInvalidArgIfNull(errorContext, toState)) {
            if (fromState instanceof Preset && toState instanceof Preset) {
                postErrorIfFailure(errorContext,
                        AllJoynManager.pulseEffectManager.updatePulseEffect(pulseEffectModel.id,
                                LightingItemUtil.createPulseEffect(((Preset)fromState).getPresetDataModel(), ((Preset)toState).getPresetDataModel(), period, duration, count)));
            } else {
                postErrorIfFailure(errorContext,
                        AllJoynManager.pulseEffectManager.updatePulseEffect(pulseEffectModel.id,
                                LightingItemUtil.createPulseEffect(fromState.getPowerOn(), fromState.getColorHsvt(), toState.getPowerOn(), toState.getColorHsvt(), period, duration, count)));
            }
        }
    }

    /**
     * Renames the Pulse Effect using the String provided.
     *
     * @param effectName The new name for the Pulse Effect.
     */
    @Override
    public void rename(String effectName) {
        String errorContext = "PulseEffect.rename() error";

        if (postInvalidArgIfNull(errorContext, effectName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.pulseEffectManager.setPulseEffectName(pulseEffectModel.id, effectName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Deletes the Pulse Effect.
     */
    @Override
    public void delete() {
        String errorContext = "PulseEffect.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.pulseEffectManager.deletePulseEffect(pulseEffectModel.id));
    }

    //TODO-DOC
    public boolean isStartWithCurrent() {
        return pulseEffectModel.isStartWithCurrent();
    }
    public MyLampState getStartState() {
        return getState();
    }

    public MyLampState getEndState() {
        return new MyLampState(pulseEffectModel.getEndState());
    }

    public Preset getStartPreset() {
        return LightingDirector.get().getPreset(getStartPresetID());
    }

    public Preset getEndPreset() {
        return LightingDirector.get().getPreset(getEndPresetID());
    }

    public String getStartPresetID() {
        return pulseEffectModel.getStartPresetID();
    }

    public String getEndPresetID() {
        return pulseEffectModel.getEndPresetID();
    }

    public long getPeriod() {
        return pulseEffectModel.getPeriod();
    }

    public long getDuration() {
        return pulseEffectModel.getDuration();
    }

    public long getCount() {
        return pulseEffectModel.getCount();
    }

    /**
     * Returns boolean true if the Pulse Effect contains the Lighting Item parameter,
     * false otherwise.
     *
     * @param item The Lighting Item to be confirmed a component of the Pulse Effect.
     * @return boolean true if the Pulse Effect contains the Lighting Item parameter,
     * false otherwise.
     */
    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "PulseEffect.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasPreset(item.getId()) : false;
    }

    /**
     * Returns boolean true if the Pulse Effect contains the Preset parameter, false otherwise.
     *
     * @param preset The preset to be confirmed a component of the Pulse Effect.
     * @return boolean true if the Pulse Effect contains the Preset parameter, false otherwise.
     */
    public boolean hasPreset(Preset preset) {
        String errorContext = "PulseEffect.hasPreset() error";
        return postInvalidArgIfNull(errorContext, preset) ? hasPreset(preset.getId()) : false;
    }

    protected boolean hasPreset(String presetID) {
        return pulseEffectModel.containsPreset(presetID);
    }

    @Override
    protected Collection<LightingItem> getDependentCollection() {
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(LightingDirector.get().getSceneElementCollectionManager().getSceneElementsCollection(new LightingItemHasComponentFilter<SceneElement>(PulseEffect.this)));

        return dependents;
    }

    protected PulseEffectDataModelV2 getPulseEffectDataModel() {
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
