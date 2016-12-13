/*
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.test;

import java.util.Arrays;

import junit.framework.TestCase;

import org.allseen.lsf.LampState;
import org.allseen.lsf.NativeLibraryLoader;
import org.allseen.lsf.StateTransitionEffect;

public class StateTransitionEffectTest extends TestCase {
    private static final NativeLibraryLoader LIBS = NativeLibraryLoader.LIBS;

    private StateTransitionEffect StateTransitionEffect;

    @Override
    protected void setUp() throws Exception
    {
        StateTransitionEffect = new StateTransitionEffect();

        super.setUp();
    }

    @Override
    protected void tearDown() throws Exception
    {
        StateTransitionEffect = null;

        super.tearDown();
    }

    public void testBasicSet()
    {
        String[] lampGroupIDs = new String[] { "A", "B", "C", "D", "E" };
        String[] lampIDs = new String[] { "F", "G", "H" };
        int transitionPeriod = 100;
        LampState lampState = new LampState();
        int brightness = 2;

        lampState.setBrightness(brightness);

        StateTransitionEffect.setLamps(lampIDs);
        StateTransitionEffect.setLampGroups(lampGroupIDs);
        StateTransitionEffect.setTransitionPeriod(transitionPeriod);
        StateTransitionEffect.setLampState(lampState);

        assertTrue(Arrays.deepEquals(StateTransitionEffect.getLamps(), lampIDs));
        assertTrue(Arrays.deepEquals(StateTransitionEffect.getLampGroups(), lampGroupIDs));
        assertTrue(StateTransitionEffect.getTransitionPeriod() == transitionPeriod);
        assertTrue(StateTransitionEffect.getLampState().getBrightness() == brightness);
    }
}