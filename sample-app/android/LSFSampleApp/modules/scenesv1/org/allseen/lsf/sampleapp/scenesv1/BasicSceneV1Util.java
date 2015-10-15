/*
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.sampleapp.scenesv1;

import java.util.ArrayList;
import java.util.List;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sampleapp.MemberNamesOptions;
import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sampleapp.SampleAppActivity;
import org.allseen.lsf.sampleapp.Util;
import org.allseen.lsf.sdk.Group;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.Scene;
import org.allseen.lsf.sdk.SceneV1;
import org.allseen.lsf.sdk.model.NoEffectDataModel;
import org.allseen.lsf.sdk.model.PulseEffectDataModel;
import org.allseen.lsf.sdk.model.SceneDataModel;
import org.allseen.lsf.sdk.model.TransitionEffectDataModel;

public class BasicSceneV1Util {
    public static SceneDataModel createSceneDataModelFrom(SceneV1 scene) {
        return (new SceneV1(scene) {
            public SceneDataModel extractModel() {
                return getSceneDataModel();
            }
        }).extractModel();
    }

    // Creates a details string, containing a list of all lamps and groups in a basic scene
    public static String createMemberNamesString(SampleAppActivity activity, Scene basicScene, String separator) {
        String details = null;

        if (basicScene instanceof SceneV1) {
            SceneDataModel basicSceneModel = BasicSceneV1Util.createSceneDataModelFrom((SceneV1)basicScene);

            if (basicSceneModel.noEffects != null) {
                for (NoEffectDataModel elementModel : basicSceneModel.noEffects) {
                    details = createMemberNamesString(activity, details, elementModel.members, separator, R.string.basic_scene_members_none);
                }
            }

            if (basicSceneModel.transitionEffects != null) {
                for (TransitionEffectDataModel elementModel : basicSceneModel.transitionEffects) {
                    details = createMemberNamesString(activity, details, elementModel.members, separator, R.string.basic_scene_members_none);
                }
            }

            if (basicSceneModel.pulseEffects != null) {
                for (PulseEffectDataModel elementModel : basicSceneModel.pulseEffects) {
                    details = createMemberNamesString(activity, details, elementModel.members, separator, R.string.basic_scene_members_none);
                }
            }
        }

        if (details == null || details.isEmpty()) {
            details = "[unknown members]";
        }

        return details;
    }

    // Creates a details string, appending a list of all lamps and subgroups in a lamp group to a previously created detail string
    protected static String createMemberNamesString(SampleAppActivity activity, String previous, LampGroup members, String separator, int noMembersStringID) {
        String current = createMemberNamesString(activity, members, separator, noMembersStringID);

        if (previous != null && !previous.isEmpty()) {
            current = previous + separator + current;
        }

        return current;
    }

    protected static String createMemberNamesString(SampleAppActivity activity, LampGroup members, String separator, int noMembersStringID) {
        List<String> groupNames = new ArrayList<String>();
        List<String> lampNames = new ArrayList<String>();

        for (String groupID : members.getLampGroups()) {
            Group group = LightingDirector.get().getGroup(groupID);
            groupNames.add(group != null ? group.getName() : String.format(activity.getString(R.string.member_group_not_found), groupID));
        }

        for (String lampID : members.getLamps()) {
            Lamp lamp = LightingDirector.get().getLamp(lampID);
            lampNames.add(lamp != null ? lamp.getName() : String.format(activity.getString(R.string.member_lamp_not_found), lampID));
        }

        return Util.createMemberNamesString(activity, groupNames, lampNames, separator, noMembersStringID);
    }

    // Creates a details string, containing a list of all lamps and subgroups in a lamp group
    public static String formatMemberNamesString(SampleAppActivity activity, LampGroup members, MemberNamesOptions options, int maxCount, int noMembersID) {
        return formatMemberNamesString(activity, members, options, maxCount, noMembersID > 0 ? activity.getString(noMembersID) : "");
    }

    public static String formatMemberNamesString(SampleAppActivity activity, LampGroup members, MemberNamesOptions options, int maxCount, String noMembers) {
        return Util.formatMemberNamesString(activity, members.getLamps(), members.getLampGroups(), options, maxCount, noMembers);
    }
}