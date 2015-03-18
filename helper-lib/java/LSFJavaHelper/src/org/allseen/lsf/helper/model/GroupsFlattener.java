/*
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.allseen.lsf.helper.facade.Group;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class GroupsFlattener {
    protected Set<String> groupIDSet;
    protected Set<String> lampIDSet;
    protected int duplicates;

    public GroupsFlattener() {
        super();
    }

    public void flattenGroups(Map<String, Group> groups) {
        for (Group group : groups.values()) {
            flattenGroup(groups, group);
        }
    }

    public void flattenGroup(Map<String, Group> groups, Group group) {
        GroupDataModel groupModel = group.getGroupDataModel();

        groupIDSet = new HashSet<String>();
        lampIDSet = new HashSet<String>();
        duplicates = 0;

        walkGroups(groups, groupModel);
        walkLamps(groups);

        groupModel.setGroups(groupIDSet);
        groupModel.setLamps(lampIDSet);
        groupModel.duplicates = duplicates;
    }

    protected void walkGroups(Map<String, Group> groups, GroupDataModel parentModel) {
        if (!groupIDSet.contains(parentModel.id)) {
            groupIDSet.add(parentModel.id);

            for (String childGroupID : parentModel.members.getLampGroups()) {
                Group childGroup = groups.get(childGroupID);
                GroupDataModel childModel = childGroup != null ? childGroup.getGroupDataModel() : null;

                if (childModel != null) {
                    walkGroups(groups, childModel);
                }
            }
        } else {
            duplicates++;
        }
    }

    protected void walkLamps(Map<String, Group> groups) {
        for (String groupID : groupIDSet) {
            Group group = groups.get(groupID);
            GroupDataModel groupModel = group != null ? group.getGroupDataModel() : null;

            if (groupModel != null) {
                Collections.addAll(lampIDSet, groupModel.members.getLamps());
            }
        }
    }
}