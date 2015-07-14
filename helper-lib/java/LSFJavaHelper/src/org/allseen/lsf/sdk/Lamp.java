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

import java.util.Collection;

import org.allseen.lsf.LampState;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.ColorItemDataModel;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.LampDataModel;

/**
 * A Lamp object represents a lamp in a lighting system, and can be used to send commands
 * to it.
 */
public class Lamp extends GroupMember {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            LampDataModel.defaultName = defaultName;
        }
    }

    protected LampDataModel lampModel;

    /**
     * Constructs a Lamp using the specified ID.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * Lamps directly, but should instead get them from the {@link LightingDirector} using the
     * {@link LightingDirector#getLamps()} method.</b>
     *
     * @param lampID The ID of the lamp
     */
    protected Lamp(String lampID) {
        this(lampID, null);
    }

    /**
     * Constructs a Lamp using the specified ID and name.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * Lamps directly, but should instead get them from the {@link LightingDirector} using the
     * {@link LightingDirector#getLamps()} method.</b>
     *
     * @param lampID The ID of the lamp
     * @param lampName The name of the lamp
     */
    protected Lamp(String lampID, String lampName) {
        super();

        lampModel = new LampDataModel(lampID, lampName);
    }

    @Override
    public void applyPreset(Preset preset) {
        String errorContext = "Lamp.applyPreset error";

        if (postInvalidArgIfNull(errorContext, preset)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.lampManager.transitionLampStateToPreset(lampModel.id, preset.getPresetDataModel().id, 0));
        }
    }

    @Override
    public void applyEffect(Effect effect) {
        String errorContext = "Lamp.applyEffect() error";

        if (postInvalidArgIfNull(errorContext, effect)) {
            if (effect instanceof Preset) {
                applyPreset((Preset) effect);
            } else if (effect instanceof TransitionEffect) {
                postErrorIfFailure(errorContext,
                        AllJoynManager.transitionEffectManager.applyTransitionEffectOnLamps(effect.getId(), new String[] { lampModel.id }));
            } else if (effect instanceof PulseEffect) {
                postErrorIfFailure(errorContext,
                        AllJoynManager.pulseEffectManager.applyPulseEffectOnLamps(effect.getId(), new String[] { lampModel.id }));
            }
        }
    }

    /**
     * Sends a command to turn this Lamp on or off.
     *
     * @param powerOn Pass in true for on, false for off
     */
    @Override
    public void setPowerOn(boolean powerOn) {
        String errorContext = "Lamp.setPowerOn() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.lampManager.transitionLampStateOnOffField(lampModel.id, powerOn));
    }

    /**
     * Sends a command to change the color of this Lamp.
     *
     * @param hueDegrees The hue component of the desired color, in degrees (0-360)
     * @param saturationPercent The saturation component of the desired color, in percent (0-100)
     * @param brightnessPercent The brightness component of the desired color, in percent (0-100)
     * @param colorTempDegrees The color temperature component of the desired color, in degrees Kelvin (1000-20000)
     */
    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        LampState lampState = new LampState(lampModel.getState());

        ColorStateConverter.convertViewToModel(hueDegrees, saturationPercent, brightnessPercent, colorTempDegrees, lampState);

        String errorContext = "Lamp.setColorHsvt() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.lampManager.transitionLampState(lampModel.id, lampState, 0));
    }

    /**
     * Renames the Lamp with the specified String.
     *
     * @param lampName The new name for the Lamp.
     */
    @Override
    public void rename(String lampName) {
        String errorContext = "Lamp.rename() error";

        if (postInvalidArgIfNull(errorContext, lampName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.lampManager.setLampName(lampModel.id, lampName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Returns a LampAbout object specific to the Lamp.
     *
     * @return The Lamp's About information.
     */
    public LampAbout getAbout() {
        return new LampAbout(lampModel.getAbout());
    }

    /**
     * Returns a LampDetails object specific to the Lamp.
     *
     * @return The Lamp's Details.
     */
    public LampDetails getDetails() {
        LampDetails lampDetails = lampModel.getDetails();

        return lampDetails != null ? lampDetails : EmptyLampDetails.instance;
    }

    /**
     * Returns a LampParameters object specific to the Lamp. If null,
     * it returns an EmptyLampParameters instance.
     *
     * @return The Lamp's Parameters.
     */
    public LampParameters getParameters() {
        LampParameters lampParams = lampModel.getParameters();

        return lampParams != null ? lampParams : EmptyLampParameters.instance;
    }

    /**
     * Returns the minimum Color Temperature value supported by the Lamp.
     *
     * @return The Lamp's minimum Color Temperature Value.
     */
    public int getColorTempMin() {
        return getDetails().getMinTemperature();
    }

    /**
     * Returns the maximum Color Temperature value supported by the Lamp.
     *
     * @return The Lamp's maximum Color Temperature Value.
     */
    public int getColorTempMax() {
        return getDetails().getMaxTemperature();
    }

    @Override
    protected void addTo(Collection<String> lampIDs, Collection<String> groupIDs) {
        lampIDs.add(getId());
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getLampDataModel();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected LampDataModel getLampDataModel() {
        return lampModel;
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getLampCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
