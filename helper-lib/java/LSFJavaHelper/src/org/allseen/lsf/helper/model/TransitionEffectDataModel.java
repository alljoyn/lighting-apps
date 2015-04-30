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
package org.allseen.lsf.helper.model;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class TransitionEffectDataModel extends ColorItemDataModel {
    public static final char TAG_PREFIX_TRANSITION = 'T';

    public static String defaultName = "<Loading transition effect info...>";
    public static long defaultDuration = 5000;

    private String presetID;
    private long duration;

    public TransitionEffectDataModel() {
        this(null);
    }

    public TransitionEffectDataModel(String transitionEffectID) {
        this(transitionEffectID, null);
    }

    public TransitionEffectDataModel(String transitionEffectID, String transitionEffectName) {
        super(transitionEffectID, TAG_PREFIX_TRANSITION, transitionEffectName != null ? transitionEffectName : defaultName);

        setDuration(defaultDuration);
        setPresetID(null);
    }

    public String getPresetID() {
        return presetID;
    }

    public void setPresetID(String transtionEffectPresetID) {
        presetID = transtionEffectPresetID;
    }

    public long getDuration() {
        return duration;
    }

    public void setDuration(long transitionEffectDuration) {
        duration = transitionEffectDuration;
    }
}
