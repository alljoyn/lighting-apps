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

import org.allseen.lsf.LampState;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class PulseEffectDataModel extends ColorItemDataModel {
    public static final char TAG_PREFIX_PULSE = 'p';

    public static String defaultName = "<Loading pulse effect info...>";
    public static long defaultPeriod = 1000;
    public static long defaultDuration = 500;
    public static long defaultCount = 10;

    private LampState endState;
    private String startPresetID;
    private String endPresetID;
    private long period;
    private long duration;
    private long count;
    private boolean startWithCurrent;

    public PulseEffectDataModel() {
        this((String)null);
    }

    public PulseEffectDataModel(String pulseEffectID) {
        this(pulseEffectID, null);
    }

    public PulseEffectDataModel(String pulseEffectID, String pulseEffectName) {
        super(pulseEffectID, TAG_PREFIX_PULSE, pulseEffectName != null ? pulseEffectName : defaultName);

        setEndState(null);
        setStartPresetID(null);
        setEndPresetID(null);
        setPeriod(defaultPeriod);
        setDuration(defaultDuration);
        setCount(defaultCount);
        setStartWithCurrent(false);
    }

    public PulseEffectDataModel(PulseEffectDataModel other) {
        super(other);

        LampState otherEndState = other.getEndState();
        if (otherEndState != null) {
            setEndState(new LampState(otherEndState));
        } else {
            setEndState(null);
        }

        setStartPresetID(other.getStartPresetID());
        setEndPresetID(other.getEndPresetID());
        setPeriod(other.getPeriod());
        setDuration(other.getDuration());
        setCount(other.getCount());
        setStartWithCurrent(other.isStartWithCurrent());
    }

    public LampState getEndState() {
        return endState;
    }

    public void setEndState(LampState state) {
        endState = state;
    }

    public String getStartPresetID() {
        return startPresetID;
    }

    public void setStartPresetID(String presetID) {
        startPresetID = presetID;
    }

    public String getEndPresetID() {
        return endPresetID;
    }

    public void setEndPresetID(String endPresetID) {
        this.endPresetID = endPresetID;
    }

    public long getPeriod() {
        return period;
    }

    public void setPeriod(long period) {
        this.period = period;
    }

    public long getDuration() {
        return duration;
    }

    public void setDuration(long duration) {
        this.duration = duration;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public boolean isStartWithCurrent() {
        return startWithCurrent;
    }

    public void setStartWithCurrent(boolean startWithCurrent) {
        this.startWithCurrent = startWithCurrent;
    }
}
