/* Copyright (c) AllSeen Alliance. All rights reserved.
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
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.PresetDataModel;

/**
 * A Preset object represents a predefined color state in a lighting system.
 */
public class Preset extends MutableColorItem implements Effect {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            PresetDataModel.defaultName = defaultName;
        }
    }

    protected PresetDataModel presetModel;

    protected Preset(String presetID) {
        this(presetID, null);
    }

    protected Preset(String presetID, String presetName) {
        super();

        presetModel = new PresetDataModel(presetID, presetName);
    }

    /**
     * Applies the Preset to a GroupMember.
     *
     * @param member The GroupMember the Preset will be applied to.
     */
    @Override
    public void applyTo(GroupMember member) {
        String errorContext = "Preset.applyTo() error";

        if (postInvalidArgIfNull(errorContext, member)) {
            member.applyPreset(this);
        }
    }

    /**
     * Changes the Power and Color values of the Preset to the passed
     * in parameters.
     *
     * @param power The desired Power state.
     * @param color The desired Color state.
     */
    public void modify(Power power, Color color) {
        String errorContext = "Preset.modify() error";

        if (postInvalidArgIfNull(errorContext, power) && postInvalidArgIfNull(errorContext, color)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.presetManager.updatePreset(presetModel.id, LightingItemUtil.createLampStateFromView(
                            power == Power.ON, color.getHue(), color.getSaturation(), color.getBrightness(),
                            color.getColorTemperature())));
        }
    }

    /**
     * Renames the Preset.
     *
     * @param presetName The new name for the Preset.
     */
    @Override
    public void rename(String presetName) {
        String errorContext = "Preset.rename() error";

        if (postInvalidArgIfNull(errorContext, presetName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.presetManager.setPresetName(presetModel.id, presetName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Deletes the Preset.
     */
    @Override
    public void delete() {
        String errorContext = "Preset.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.presetManager.deletePreset(presetModel.id));
    }

    /**
     * Sets the Power value of the Preset to ON if the boolean parameter is
     * true, OFF otherwise.
     *
     * @param powerOn The boolean value that determines the Power state of the Preset.
     */
    @Override
    public void setPowerOn(boolean powerOn) {
        modify((powerOn)? Power.ON : Power.OFF, getColor());
    }

    /**
     * Sets the Color HSVT values of the Preset to those of the parameters.
     *
     * @param hueDegrees The hue component of the desired color, in degrees (0-360)
     * @param saturationPercent The saturation component of the desired color, in percent (0-100)
     * @param brightnessPercent The brightness component of the desired color, in percent (0-100)
     * @param colorTempDegrees The color temperature component of the desired color, in degrees Kelvin (2700-9000)
     */
    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        modify(getPower(), new Color(hueDegrees, saturationPercent, brightnessPercent, colorTempDegrees));
    }

    /**
     * Returns boolean true if the Preset is equivalent to the parameter Preset,
     * false otherwise.
     *
     * @param that The Preset for comparison.
     * @return boolean true if the Preset is equivalent to the parameter Preset,
     * false otherwise.
     */
    public boolean stateEquals(Preset that) {
        return getColorDataModel().stateEquals(that.getColorDataModel());
    }

    /**
     * Returns boolean true if the Preset's Power and Color states are
     * equivalent to the parameter's Power and Color states, false otherwise.
     *
     * @param that The MyLampState for comparison.
     * @return boolean true if the Preset is equivalent to the parameter,
     * false otherwise.
     */
    public boolean stateEquals(MyLampState state) {
        return stateEquals(state.getPower(), state.getColor());
    }

    /**
     * Returns boolean true if the Preset's Power and Color states are
     * equivalent to the corresponding parameters, false otherwise.
     *
     * @param power The Power for comparison.
     * @param color The Color for comparison.
     * @return boolean true if the Preset's Power and Color states are
     * equivalent to the corresponding parameters, false otherwise.
     */
    public boolean stateEquals(Power power, Color color) {
        return getColorDataModel().stateEquals(
                power == Power.ON,
                ColorStateConverter.convertHueViewToModel(color.getHue()),
                ColorStateConverter.convertSaturationViewToModel(color.getSaturation()),
                ColorStateConverter.convertBrightnessViewToModel(color.getBrightness()),
                ColorStateConverter.convertColorTempViewToModel(color.getHue()));
    }

    @Override
    protected Collection<LightingItem> getDependentCollection() {
        LightingDirector director = LightingDirector.get();
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(director.getSceneCollectionManager().getScenesCollection(new HasComponentFilter<SceneV1>(Preset.this)));
        dependents.addAll(director.getTransitionEffectCollectionManager().getTransitionEffectsCollection(new HasComponentFilter<TransitionEffect>(Preset.this)));
        dependents.addAll(director.getPulseEffectCollectionManager().getPulseEffectsCollection(new HasComponentFilter<PulseEffect>(Preset.this)));

        return dependents;
    }

    protected PresetDataModel getPresetDataModel() {
        return presetModel;
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getPresetDataModel();
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getPresetCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
