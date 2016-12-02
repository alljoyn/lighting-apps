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

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sdk.model.LightingItemUtil;

/**
 * Abstract base class for Lighting items that can be included in a Lighting Group.
 */
public abstract class GroupMember extends MutableColorItem {

    /**
     * Returns a boolean indicating if the GroupMember is a Lamp.
     *
     * @return boolean Returns a default value of false
     */
    public boolean isLamp() {
        return false;
    }

    /**
     * Returns a boolean indicating if the GroupMember is a Group.
     *
     * @return boolean Returns a default value of false
     */
    public boolean isGroup() {
        return false;
    }

    /**
     * Applies the provided Preset to the current GroupMember.
     *
     * @param preset Preset to apply to the current GroupMember
     */
    public abstract void applyPreset(Preset preset);

    /**
     * Applies the provided Effect to the current GroupMember.
     *
     * @param effect Effect to apply to the current GroupMember
     */
    public abstract void applyEffect(Effect effect);

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected abstract void addTo(Collection<String> lampIDs, Collection<String> groupIDs);

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected static LampGroup createLampGroup(GroupMember[] groupMembers) {
        Set<String> lampIDs = new HashSet<String>();
        Set<String> groupIDs = new HashSet<String>();

        if (groupMembers != null) {
            for (GroupMember member : groupMembers) {
                member.addTo(lampIDs, groupIDs);
            }
        }

        return LightingItemUtil.createLampGroup(
                lampIDs.toArray(new String[lampIDs.size()]),
                groupIDs.toArray(new String[groupIDs.size()]));
    }
}