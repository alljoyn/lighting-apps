/*
 * Copyright AllSeen Alliance. All rights reserved.
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
import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sdk.model.LightingItemUtil;

/**
 * Abstract base class for Mutable Color Items in a group.
 *
 */
public abstract class GroupMember extends MutableColorItem {

    /**
     * Returns a boolean indicating the GroupMember is not a Lamp object.
     *
     * @return boolean false.
     */
    public boolean isLamp() {
        return false;
    }

    /**
     * Returns a boolean indicating the GroupMember is not a Group object.
     *
     * @return boolean false.
     */
    public boolean isGroup() {
        return false;
    }

    public abstract void applyPreset(Preset preset);
    public abstract void applyEffect(Effect effect);
    protected abstract void addTo(Collection<String> lampIDs, Collection<String> groupIDs);

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
