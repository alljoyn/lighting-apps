/* Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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
import org.allseen.lsf.helper.model.PresetDataModel;

/**
 * A Preset object represents a predefined color state in a lighting system.
 * <p>
 * <b>WARNING: This class is not intended to be used by clients, and its
 * interface may change in subsequent releases of the SDK</b>.
 */
public class Preset extends ColorItem implements Effect {

    protected PresetDataModel presetModel;

    public Preset(String presetID) {
        this(presetID, null);
    }

    public Preset(String presetID, String presetName) {
        super();

        presetModel = new PresetDataModel(presetID, presetName);
    }

    @Override
    public void applyTo(GroupMember member) {
        member.applyPreset(this);
    }

    public void modify(Power power, Color color) {
        AllJoynManager.presetManager.updatePreset(presetModel.id, LightingItemUtil.createLampStateFromView(
                power == Power.ON, color.getHue(), color.getSaturation(), color.getBrightness(),
                color.getColorTemperature()));
    }

    @Override
    public void rename(String presetName) {
        AllJoynManager.presetManager.setPresetName(presetModel.id, presetName, LightingDirector.get().getDefaultLanguage());
    }

    public void delete() {
        AllJoynManager.presetManager.deletePreset(presetModel.id);
    }

    public PresetDataModel getPresetDataModel() {
        return presetModel;
    }

    @Override
    public void setPowerOn(boolean powerOn) {
        modify((powerOn)? Power.ON : Power.OFF, getColor());
    }

    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        modify(getPower(), new Color(hueDegrees, saturationPercent, brightnessPercent, colorTempDegrees));
    }

    @Override
    protected ColorItemDataModel getColorDataModel() {
        return getPresetDataModel();
    }
}
