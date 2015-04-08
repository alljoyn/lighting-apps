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
package org.allseen.lsf.helper.manager;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public abstract class LightingItemCollectionManager<ADAPTER, LISTENER, MODEL> extends LightingItemListenerManager<LISTENER> {

    protected final Map<String, ADAPTER> itemAdapters = new HashMap<String, ADAPTER>();

    public LightingItemCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public boolean hasID(String itemID) {
        return itemAdapters.containsKey(itemID);
    }

    protected Collection<String> getIDCollection() {
        return itemAdapters.keySet();
    }

    public Iterator<String> getIDIterator() {
        return getIDCollection().iterator();
    }

    public String[] getIDArray() {
        return getIDArray(new String[size()]);
    }

    public String[] getIDArray(String[] itemIDs) {
        return getIDCollection().toArray(itemIDs);
    }

    public int size() {
        return itemAdapters.size();
    }

    protected ADAPTER getAdapter(String itemID) {
        return itemAdapters.get(itemID);
    }

    protected Collection<ADAPTER> removeAllAdapters() {
        List<ADAPTER> list = new ArrayList<ADAPTER>(size());
        Iterator<ADAPTER> i = getAdapters().iterator();

        while (i.hasNext()) {
            ADAPTER item = i.next();

            i.remove();
            list.add(item);

            sendRemovedEvent(item);
        }

        return list;
    }

    protected ADAPTER removeAdapter(String itemID) {
        ADAPTER item = itemAdapters.remove(itemID);

        sendRemovedEvent(item);

        return item;
    }

    protected Collection<ADAPTER> getAdapters() {
        return itemAdapters.values();
    }

    @Override
    public void addListener(LISTENER listener) {
        super.addListener(listener);

        Iterator<ADAPTER> i = itemAdapters.values().iterator();

        while (i.hasNext()) {
            sendChangedEvent(listener, i.next());
        }
    }

    public void sendChangedEvent(String itemID) {
        for (LISTENER listener : itemListeners) {
            sendChangedEvent(listener, getAdapter(itemID));
        }
    }

    public void sendRemovedEvent(ADAPTER item) {
        for (LISTENER listener : itemListeners) {
            sendRemovedEvent(listener, item);
        }
    }

    public void sendErrorEvent(String name, ResponseCode responseCode) {
        sendErrorEvent(name, responseCode, null);
    }

    public void sendErrorEvent(String name, ResponseCode responseCode, String itemID) {
        sendErrorEvent(new LightingItemErrorEvent(name, responseCode, itemID));
    }

    public void sendErrorEvent(LightingItemErrorEvent errorEvent) {
        for (LISTENER listener : itemListeners) {
            sendErrorEvent(listener, errorEvent);
        }
    }

    protected abstract void sendChangedEvent(LISTENER listener, ADAPTER item);
    protected abstract void sendRemovedEvent(LISTENER listener, ADAPTER item);
    protected abstract void sendErrorEvent(LISTENER listener, LightingItemErrorEvent errorEvent);

    public abstract MODEL getModel(String itemID);
}