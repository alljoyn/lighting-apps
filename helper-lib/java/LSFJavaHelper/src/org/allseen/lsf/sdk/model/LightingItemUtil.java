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
package org.allseen.lsf.sdk.model;

import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.LampState;
import org.allseen.lsf.MasterScene;
import org.allseen.lsf.PulseEffect;
import org.allseen.lsf.SceneElement;
import org.allseen.lsf.SceneWithSceneElements;
import org.allseen.lsf.TransitionEffect;
import org.allseen.lsf.sdk.Group;
import org.allseen.lsf.sdk.GroupMember;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.Preset;

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

    public static TransitionEffect createTransitionEffect(boolean powerOn, int[] colorHsvt, long duration) {
        return createTransitionEffect(createLampStateFromView(powerOn, colorHsvt[0], colorHsvt[1], colorHsvt[2], colorHsvt[3]), duration);
    }

    public static TransitionEffect createTransitionEffect(LampState lampState, long duration) {
        TransitionEffect transitionEffect = null;

        if ((lampState != null) && (duration >= 0)) {
            transitionEffect = new TransitionEffect();
            transitionEffect.setLampState(lampState);
            transitionEffect.setTransitionPeriod(duration);
        }

        return transitionEffect;
    }

    public static TransitionEffect createTransitionEffect(Preset preset, long duration) {
        TransitionEffect transitionEffect = null;

        if ((preset != null) && (duration >= 0)) {
            transitionEffect = new TransitionEffect();
            transitionEffect.setPresetID(preset.getPresetDataModel().id);
            transitionEffect.setTransitionPeriod(duration);
        }

        return transitionEffect;
    }

    public static PulseEffect createPulseEffect(boolean fromPowerOn, int[] fromColorHsvt, boolean toPowerOn, int[] toColorHsvt, long period, long duration, long count) {
        return createPulseEffect(
                createLampStateFromView(fromPowerOn, fromColorHsvt[0], fromColorHsvt[1], fromColorHsvt[2], fromColorHsvt[3]),
                createLampStateFromView(toPowerOn, toColorHsvt[0], toColorHsvt[1], toColorHsvt[2], toColorHsvt[3]),
                period, duration, count);
    }

    public static PulseEffect createPulseEffect(LampState fromState, LampState toState, long period, long duration, long count) {
        PulseEffect pulseEffect = null;

        if (fromState != null && toState != null && period > 0 && duration > 0 && count > 0) {
            pulseEffect = new PulseEffect();
            pulseEffect.setFromLampState(fromState);
            pulseEffect.setToLampState(toState);

            pulseEffect.setPulsePeriod(period);
            pulseEffect.setPulseDuration(duration);
            pulseEffect.setNumPulses(count);
        }

        return pulseEffect;
    }

    public static PulseEffect createPulseEffect(Preset fromPreset, Preset toPreset, long period, long duration, long count) {
        PulseEffect pulseEffect = null;

        if (fromPreset != null && toPreset != null && period > 0 && duration > 0 && count > 0) {
            pulseEffect = new PulseEffect();
            pulseEffect.setFromPresetID(fromPreset.getPresetDataModel().id);
            pulseEffect.setToPresetID(toPreset.getPresetDataModel().id);

            pulseEffect.setPulsePeriod(period);
            pulseEffect.setPulseDuration(duration);
            pulseEffect.setNumPulses(count);
        }

        return pulseEffect;
    }

    public static SceneElement createSceneElement(String effectId, GroupMember[] members) {
        SceneElement sceneElement = null;

        if (effectId != null && members != null) {
            LampGroup groupMembers = createLampGroup(members);

            sceneElement = new SceneElement();
            sceneElement.setEffectID(effectId);
            sceneElement.setLamps(groupMembers.getLamps());
            sceneElement.setLampGroups(groupMembers.getLampGroups());
        }

        return sceneElement;
    }

    public static SceneElement createSceneElement(String effectId, String[] lampIds, String[] lampGroupIds) {
        SceneElement sceneElement = null;

        if (effectId != null && lampIds != null && lampGroupIds != null) {
            sceneElement = new SceneElement();
            sceneElement.setEffectID(effectId);
            sceneElement.setLamps(lampIds);
            sceneElement.setLampGroups(lampGroupIds);
        }

        return sceneElement;
    }

    public static MasterScene createMasterScene(String[] sceneIds) {
        MasterScene masterScene = null;

        if (sceneIds != null) {
            masterScene = new MasterScene();
            masterScene.setScenes(sceneIds);
        }

        return masterScene;
    }

    public static SceneWithSceneElements createSceneWithSceneElements(String[] sceneElementIds) {
        SceneWithSceneElements sceneWithElements = null;

        if (sceneElementIds != null) {
            sceneWithElements = new SceneWithSceneElements();
            sceneWithElements.setSceneElements(sceneElementIds);
        }

        return sceneWithElements;
    }
}
