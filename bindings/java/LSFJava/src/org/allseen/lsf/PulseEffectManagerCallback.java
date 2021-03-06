/*
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
 *    
 *    SPDX-License-Identifier: Apache-2.0
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *    
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *    
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *    
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
*/
package org.allseen.lsf;

import org.allseen.lsf.sdk.ResponseCode;

public class PulseEffectManagerCallback extends DefaultNativeClassWrapper {

    public PulseEffectManagerCallback() {
        createNativeObject();
    }

    public void getPulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID, PulseEffectV2 pulseEffect)                     { }
    public void applyPulseEffectOnLampsReplyCB(ResponseCode responseCode, String pulseEffectID, String[] lampIDs)                   { }
    public void applyPulseEffectOnLampGroupsReplyCB(ResponseCode responseCode, String pulseEffectID, String[] lampGroupIDs)         { }
    public void getAllPulseEffectIDsReplyCB(ResponseCode responseCode, String[] pulseEffectIDs)                                     { }
    public void getPulseEffectNameReplyCB(ResponseCode responseCode, String pulseEffectID, String language, String pulseEffectName) { }
    public void setPulseEffectNameReplyCB(ResponseCode responseCode, String pulseEffectID, String language)                         { }
    public void pulseEffectsNameChangedCB(String[] pulseEffectIDs)                                                                  { }
    public void createPulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID, long trackingID)                          { }
    public void pulseEffectsCreatedCB(String[] pulseEffectIDs)                                                                      { }
    public void updatePulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID)                                           { }
    public void pulseEffectsUpdatedCB(String[] pulseEffectIDs)                                                                      { }
    public void deletePulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID)                                           { }
    public void pulseEffectsDeletedCB(String[] pulseEffectIDs)                                                                      { }

    @Override
    protected native void createNativeObject();

    @Override
    protected native void destroyNativeObject();
}