/*
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 */
package org.allseen.lsf.sdk;

import org.allseen.lsf.PresetPulseEffect;
import org.allseen.lsf.sdk.model.EffectType;

/**
 * Base interface implemented by all Lighting items that are effects.
 */
public interface Effect extends LightingItemInterface, DeletableItem {

    /**
     * Constant specifying preset effect type.
     */
    public static final String EFFECT_TYPE_PRESET = EffectType.None.toString();

    /**
     * Constant specifying transition effect type.
     */
    public static final String EFFECT_TYPE_TRANSITION = EffectType.Transition.toString();

    /**
     * Constant specifying pulse effect type.
     */
    public static final String EFFECT_TYPE_PULSE = EffectType.Pulse.toString();

    /**
     * Constant specifying preset to use current state of GroupMember as starting state.
     */
    public static final String PRESET_ID_USE_CURRENT_STATE = PresetPulseEffect.PRESET_ID_CURRENT_STATE;

    /**
     * Applies the current effect to the provided Lighting item.
     *
     * @param member Lighting item to apply the effect
     */
    public void applyTo(GroupMember member);
}