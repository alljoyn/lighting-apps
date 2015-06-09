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
package org.allseen.lsf;

public class TransitionEffectV2 extends DefaultNativeClassWrapper {
    public TransitionEffectV2() {
        createNativeObject();
    }

    public TransitionEffectV2(TransitionEffectV2 other) {
        this();

        this.setLampState(other.getLampState());
        this.setPresetID(other.getPresetID());
        this.setTransitionPeriod(other.getTransitionPeriod());
    }

    public native void setLampState(LampState lampState);
    public native LampState getLampState();

    public native void setPresetID(String presetID);
    public native String getPresetID();

    public native void setTransitionPeriod(long transitionPeriod);
    public native long getTransitionPeriod();

    @Override
    protected native void createNativeObject();

    @Override
    protected native void destroyNativeObject();
}
