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
import org.allseen.lsf.sdk.model.TransitionEffectDataModelV2;

/**
 * A Transition Effect object represents a predefined gradual transition between two color states in a lamp.
 */
public class TransitionEffect extends ColorItem implements Effect {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            TransitionEffectDataModelV2.defaultName = defaultName;
        }
    }

    protected TransitionEffectDataModelV2 transitionEffectModel;

    protected TransitionEffect(String transitionEffectId) {
        this(transitionEffectId, null);
    }

    protected TransitionEffect(String transitionEffectId, String transitionEffectName) {
        super();

        transitionEffectModel = new TransitionEffectDataModelV2(transitionEffectId, transitionEffectName);
    }

    /**
     * Applies the Transition Effect to the specified Group Member.
     *
     * @param member The Group Member the Transition Effect will be applied to.
     */
    @Override
    public void applyTo(GroupMember member) {
        String errorContext = "TransitionEffect.applyTo() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            member.applyEffect(this);
        }
    }

    /**
     * Replaces the Transition Effect's LampState and duration values with
     * those specified as parameters.
     *
     * @param state The new LampState.
     * @param duration The new duration, in milliseconds.
     */
    public void modify(LampState state, long duration) {
        String errorContext = "TransitionEffect.modify() error";

        if (postInvalidArgIfNull(errorContext, state)) {
            if (state instanceof Preset) {
                postErrorIfFailure(errorContext,
                        AllJoynManager.transitionEffectManager.updateTransitionEffect(transitionEffectModel.id,
                                LightingItemUtil.createTransitionEffect(((Preset)state).getPresetDataModel(), duration)));
            } else {
                postErrorIfFailure(errorContext,
                        AllJoynManager.transitionEffectManager.updateTransitionEffect(transitionEffectModel.id,
                                LightingItemUtil.createTransitionEffect(state.getPowerOn(), state.getColorHsvt(), duration)));
            }
        }
    }

    /**
     * Renames the Transition Effect using the String specified.
     *
     * @param effectName The new name for the Transition Effect.
     */
    @Override
    public void rename(String effectName) {
        String errorContext = "TransitionEffect.rename() error";

        if (postInvalidArgIfNull(errorContext, effectName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.transitionEffectManager.setTransitionEffectName(transitionEffectModel.id, effectName,
                            LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Deletes the Transition Effect.
     */
    @Override
    public void delete() {
        String errorContext = "TransitionEffect.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.transitionEffectManager.deleteTransitionEffect(transitionEffectModel.id));
    }

    //TODO-DOC
    public Preset getPreset() {
        return LightingDirector.get().getPreset(getPresetID());
    }

    public String getPresetID() {
        return transitionEffectModel.getPresetID();
    }

    public long getDuration() {
        return transitionEffectModel.getDuration();
    }

    /**
     * Returns boolean true if the Transition Effect contains the Lighting Item specified,
     * false otherwise.
     *
     * @param item The Lighting Item to be confirmed a component of the Transition Effect.
     * @return boolean true if the Transition Effect contains the Lighting Item parameter,
     * false otherwise.
     */
    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "TransitionEffect.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasPreset(item.getId()) : false;
    }

    /**
     * Returns boolean true if the Transition Effect contains the Preset specified,
     * false otherwise.
     *
     * @param preset The Preset to be confirmed a component of the Transition Effect.
     * @return boolean true if the Transition Effect contains the Preset specified,
     * false otherwise.
     */
    public boolean hasPreset(Preset preset) {
        String errorContext = "TransitionEffect.hasPreset() error";
        return postInvalidArgIfNull(errorContext, preset) ? hasPreset(preset.getId()) : false;
    }

    protected boolean hasPreset(String presetID) {
        return transitionEffectModel.containsPreset(presetID);
    }

    protected TransitionEffectDataModelV2 getTransitionEffectDataModel() {
        return transitionEffectModel;
    }

    @Override
    protected Collection<LightingItem> getDependentCollection() {
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(LightingDirector.get().getSceneElementCollectionManager().getSceneElementsCollection(new LightingItemHasComponentFilter<SceneElement>(TransitionEffect.this)));

        return dependents;
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getTransitionEffectDataModel();
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getTransitionEffectCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
