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
package org.allseen.lsf.helper.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.listener.GroupCollectionListener;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;
import org.allseen.lsf.helper.model.GroupDataModel;
import org.allseen.lsf.helper.model.GroupsFlattener;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class GroupCollectionManager extends LightingItemCollectionManager<Group, GroupCollectionListener, GroupDataModel> {

    protected GroupsFlattener groupsFlattener = new GroupsFlattener();

    public GroupCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public Group addGroup(String groupID) {
        return addGroup(groupID, new Group(groupID));
    }

    public Group addGroup(String groupID, Group group) {
        return itemAdapters.put(groupID, group);
    }

    public Group getGroup(String groupID) {
        return getAdapter(groupID);
    }

    public Group[] getGroups() {
        return getAdapters().toArray(new Group[size()]);
    }

    public Iterator<Group> getGroupIterator() {
        return getAdapters().iterator();
    }

    public void flattenGroups() {
        groupsFlattener.flattenGroups(itemAdapters);
    }

    public void flattenGroup(Group group) {
        groupsFlattener.flattenGroup(itemAdapters, group);
    }

    public Collection<Group> removeGroups() {
        return removeAllAdapters();
    }

    public Group removeGroup(String groupID) {
        return removeAdapter(groupID);
    }

    @Override
    protected void sendChangedEvent(GroupCollectionListener listener, Group group) {
        listener.onGroupChanged(group);
    }

    @Override
    protected void sendRemovedEvent(GroupCollectionListener listener, Group group) {
        listener.onGroupRemoved(group);
    }

    @Override
    protected void sendErrorEvent(GroupCollectionListener listener, LightingItemErrorEvent errorEvent) {
        listener.onGroupError(errorEvent);
    }

    @Override
    public GroupDataModel getModel(String groupID) {
        Group group = getAdapter(groupID);

        return group != null ? group.getGroupDataModel() : null;
    }
}