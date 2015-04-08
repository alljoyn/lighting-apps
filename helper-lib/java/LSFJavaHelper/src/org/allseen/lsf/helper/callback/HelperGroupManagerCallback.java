/*
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
package org.allseen.lsf.helper.callback;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.allseen.lsf.LampDetails;
import org.allseen.lsf.LampGroup;
import org.allseen.lsf.LampGroupManagerCallback;
import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.manager.GroupCollectionManager;
import org.allseen.lsf.helper.manager.LightingSystemManager;
import org.allseen.lsf.helper.model.AllLampsDataModel;
import org.allseen.lsf.helper.model.ColorAverager;
import org.allseen.lsf.helper.model.ColorStateConverter;
import org.allseen.lsf.helper.model.GroupDataModel;
import org.allseen.lsf.helper.model.LampCapabilities;
import org.allseen.lsf.helper.model.LampDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class HelperGroupManagerCallback extends LampGroupManagerCallback {
    public LightingSystemManager manager;

    protected final ColorAverager averageHue = new ColorAverager();
    protected final ColorAverager averageSaturation = new ColorAverager();
    protected final ColorAverager averageBrightness = new ColorAverager();
    protected final ColorAverager averageColorTemp = new ColorAverager();

    protected Set<String> groupIDsWithPendingMembers = new HashSet<String>();
    protected Set<String> groupIDsWithPendingFlatten = new HashSet<String>();

    public HelperGroupManagerCallback(LightingSystemManager manager) {
        super();

        this.manager = manager;
    }

    public void refreshAllLampGroupIDs() {
        int count = manager.getGroupCollectionManager().size();

        if (count > 0) {
            getAllLampGroupIDsReplyCB(ResponseCode.OK, manager.getGroupCollectionManager().getIDArray());
        }
    }

    @Override
    public void getAllLampGroupIDsReplyCB(ResponseCode responseCode, String[] groupIDs) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("getAllLampGroupIDsReplyCB", responseCode);
        }

        postProcessLampGroupID(AllLampsDataModel.ALL_LAMPS_GROUP_ID, true, true);

        for (final String groupID : groupIDs) {
            postProcessLampGroupID(groupID, true, true);
        }
    }

    @Override
    public void getLampGroupNameReplyCB(ResponseCode responseCode, String groupID, String language, String groupName) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("getLampGroupNameReplyCB", responseCode, groupID);
            AllJoynManager.groupManager.getLampGroupName(groupID, LightingSystemManager.LANGUAGE);
        } else {
            postUpdateLampGroupName(groupID, groupName);
        }
    }

    @Override
    public void setLampGroupNameReplyCB(ResponseCode responseCode, String groupID, String language) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("setLampGroupNameReplyCB", responseCode, groupID);
        }

        AllJoynManager.groupManager.getLampGroupName(groupID, LightingSystemManager.LANGUAGE);
    }

    @Override
    public void lampGroupsNameChangedCB(final String[] groupIDs) {
        for (String groupID : groupIDs) {
            postProcessLampGroupID(groupID, true, false);
        }
    }

    @Override
    public void createLampGroupReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("createLampGroupReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void lampGroupsCreatedCB(String[] groupIDs) {
        for (final String groupID : groupIDs) {
            postProcessLampGroupID(groupID, true, true);
        }
    }

    @Override
    public void getLampGroupReplyCB(ResponseCode responseCode, String groupID, LampGroup lampGroup) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("getLampGroupReplyCB", responseCode, groupID);
            AllJoynManager.groupManager.getLampGroup(groupID);
        } else {
            postUpdateLampGroup(groupID, lampGroup);
        }
    }

    @Override
    public void deleteLampGroupReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("deleteLampGroupReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void lampGroupsDeletedCB(String[] groupIDs) {
        postDeleteGroups(groupIDs);
    }

    @Override
    public void transitionLampGroupStateOnOffFieldReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("transitionLampGroupStateOnOffFieldReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void transitionLampGroupStateHueFieldReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("transitionLampGroupStateHueFieldReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void transitionLampGroupStateSaturationFieldReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("transitionLampGroupStateSaturationFieldReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void transitionLampGroupStateBrightnessFieldReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("transitionLampGroupStateBrightnessFieldReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void transitionLampGroupStateColorTempFieldReplyCB(ResponseCode responseCode, String groupID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getGroupCollectionManager().sendErrorEvent("transitionLampGroupStateColorTempFieldReplyCB", responseCode, groupID);
        }
    }

    @Override
    public void lampGroupsUpdatedCB(String[] groupIDs) {
        for (String groupID : groupIDs) {
            postProcessLampGroupID(groupID, false, true);
        }
    }

    protected void postProcessLampGroupID(final String groupID, final boolean needName, final boolean needState) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                boolean getName = needName;
                boolean getState = needState;

                if (!manager.getGroupCollectionManager().hasID(groupID)) {
                    manager.getGroupCollectionManager().addGroup(groupID);

                    getName = true;
                    getState = true;
                }

                if (getName) {
                    AllJoynManager.groupManager.getLampGroupName(groupID, LightingSystemManager.LANGUAGE);
                }

                if (getState) {
                    groupIDsWithPendingMembers.add(groupID);
                    AllJoynManager.groupManager.getLampGroup(groupID);
                }
            }
        });
    }

    protected void postUpdateLampGroupName(final String groupID, final String groupName) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                GroupDataModel groupModel = manager.getGroupCollectionManager().getModel(groupID);

                if (groupModel != null) {
                    groupModel.setName(groupName);
                }
            }
        });

        postSendGroupChanged(groupID);
    }

    protected void postUpdateLampGroup(final String groupID, final LampGroup lampGroup) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                GroupDataModel groupModel = manager.getGroupCollectionManager().getModel(groupID);

                groupIDsWithPendingMembers.remove(groupID);

                if (groupModel != null) {
                    groupModel.members = lampGroup;
                }

                groupIDsWithPendingFlatten.add(groupID);

                if (groupIDsWithPendingMembers.size() == 0) {
                    for (String groupID : groupIDsWithPendingFlatten) {
                        postFlattenLampGroup(groupID);
                    }

                    groupIDsWithPendingFlatten.clear();

                    postUpdateLampGroupState(groupModel);
                }
            }
        });
    }

    protected void postFlattenLampGroup(final String groupID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                GroupCollectionManager groupCollectionManager = manager.getGroupCollectionManager();
                Group group = groupCollectionManager.getGroup(groupID);

                if (group != null) {
                    groupCollectionManager.flattenGroup(group);
                }
            }
        });
    }

    public void postUpdateDependentLampGroups(final String lampID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                Iterator<Group> i = manager.getGroupCollectionManager().getGroupIterator();

                while(i.hasNext()) {
                    GroupDataModel groupModel = i.next().getGroupDataModel();
                    Set<String> lampIDs = groupModel.getLamps();

                    if (lampIDs != null && lampIDs.contains(lampID)) {
                        postUpdateLampGroupState(groupModel);
                    }
                }
            }
        });
    }

    protected void postUpdateLampGroupState(final GroupDataModel groupModel) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                LampCapabilities capability = new LampCapabilities();
                int countOn = 0;
                int countOff = 0;
                int viewColorTempGroupMin = -1;
                int viewColorTempGroupMax = -1;

                averageHue.reset();
                averageSaturation.reset();
                averageBrightness.reset();
                averageColorTemp.reset();

                for (String lampID : groupModel.getLamps()) {
                    LampDataModel lampModel = manager.getLampCollectionManager().getModel(lampID);

                    if (lampModel != null) {
                        LampDetails lampDetails = lampModel.getDetails();

                        capability.includeData(lampModel.getCapability());

                        if ( lampModel.state.getOnOff()) {
                            countOn++;
                        } else {
                            countOff++;
                        }

                        if (lampDetails.hasColor()) {
                            averageHue.add(lampModel.state.getHue());
                            averageSaturation.add(lampModel.state.getSaturation());
                        }

                        if (lampDetails.isDimmable()) {
                            averageBrightness.add(lampModel.state.getBrightness());
                        }

                        boolean hasVariableColorTemp = lampDetails.hasVariableColorTemp();
                        int viewColorTempLampMin = lampDetails.getMinTemperature();
                        int viewColorTempLampMax = hasVariableColorTemp ? lampDetails.getMaxTemperature() : viewColorTempLampMin;
                        boolean validColorTempLampMin = viewColorTempLampMin >= ColorStateConverter.VIEW_COLORTEMP_MIN && viewColorTempLampMin <= ColorStateConverter.VIEW_COLORTEMP_MAX;
                        boolean validColorTempLampMax = viewColorTempLampMax >= ColorStateConverter.VIEW_COLORTEMP_MIN && viewColorTempLampMax <= ColorStateConverter.VIEW_COLORTEMP_MAX;

                        if (hasVariableColorTemp) {
                            averageColorTemp.add(lampModel.state.getColorTemp());
                        } else if (validColorTempLampMin) {
                            averageColorTemp.add(ColorStateConverter.convertColorTempViewToModel(viewColorTempLampMin));
                        }

                        if (validColorTempLampMin && validColorTempLampMax) {
                            if (viewColorTempGroupMin == -1 || viewColorTempGroupMin > viewColorTempLampMin) {
                                viewColorTempGroupMin = viewColorTempLampMin;
                            }

                            if (viewColorTempGroupMax == -1 || viewColorTempGroupMax < viewColorTempLampMax) {
                                viewColorTempGroupMax = viewColorTempLampMax;
                            }
                        }
                     } else {
                        //TODO-FIX Log.d(SampleAppActivity.TAG, "missing lamp: " + lampID);
                    }
                }

                groupModel.setCapability(capability);

                groupModel.state.setOnOff(countOn > 0);
                groupModel.state.setHue(averageHue.getAverage());
                groupModel.state.setSaturation(averageSaturation.getAverage());
                groupModel.state.setBrightness(averageBrightness.getAverage());
                groupModel.state.setColorTemp(averageColorTemp.getAverage());

                groupModel.uniformity.power = countOn == 0 || countOff == 0;
                groupModel.uniformity.hue = averageHue.isUniform();
                groupModel.uniformity.saturation = averageSaturation.isUniform();
                groupModel.uniformity.brightness = averageBrightness.isUniform();
                groupModel.uniformity.colorTemp = averageColorTemp.isUniform();

                groupModel.viewColorTempMin = viewColorTempGroupMin != -1 ? viewColorTempGroupMin : ColorStateConverter.VIEW_COLORTEMP_MIN;
                groupModel.viewColorTempMax = viewColorTempGroupMax != -1 ? viewColorTempGroupMax : ColorStateConverter.VIEW_COLORTEMP_MAX;
            }
        });

        postSendGroupChanged(groupModel.id);
    }

    protected void postDeleteGroups(final String[] groupIDs) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                for (String groupID : groupIDs) {
                    manager.getGroupCollectionManager().removeGroup(groupID);
                }
            }
        });
    }

    protected void postSendGroupChanged(final String groupID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                manager.getGroupCollectionManager().sendChangedEvent(groupID);
            }
        });
    }
}