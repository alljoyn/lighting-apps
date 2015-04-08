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
package org.allseen.lsf.helper.model;

import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.LampState;
import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.facade.GroupMember;
import org.allseen.lsf.helper.facade.Lamp;

public class LightingItemUtil {

    public static LampState createLampStateFromView(boolean powerOn, int viewHue, int viewSaturation, int viewBrightness, int viewColorTemp) {
        LampState lampState = new LampState();
        lampState.setOnOff(powerOn);
        ColorStateConverter.convertViewToModel(viewHue, viewSaturation, viewBrightness, viewColorTemp, lampState);

        return lampState;
    }

    public static LampGroup createLampGroup(GroupMember[] groupMembers) {
        if (groupMembers == null) {
            return null;
        }

        Set<String> lamps = new HashSet<String>();
        Set<String> groups = new HashSet<String>();

        for (GroupMember member : groupMembers) {
            if (member instanceof Lamp) {
                lamps.add(((Lamp)member).getLampDataModel().id);
            } else if (member instanceof Group) {
                groups.add(((Group)member).getGroupDataModel().id);
            }
        }

        return createLampGroup(lamps.toArray(new String[lamps.size()]), groups.toArray(new String[groups.size()]));
    }

    public static LampGroup createLampGroup(String[] lampIds, String[] groupIds) {
        LampGroup lampGroup = null;

        if ((lampIds != null) && (groupIds != null)) {
            lampGroup = new LampGroup();
            lampGroup.setLamps(lampIds);
            lampGroup.setLampGroups(groupIds);
        }

        return lampGroup;
    }

}
