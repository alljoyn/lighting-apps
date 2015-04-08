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
package org.allseen.lsf.sampleapp;

import java.util.Iterator;

import org.allseen.lsf.helper.facade.Lamp;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.LampDataModel;

public class UpdateLampNameAdapter extends UpdateItemNameAdapter {

    public UpdateLampNameAdapter(LampDataModel lampModel, SampleAppActivity activity) {
        super(lampModel, activity);
    }

    @Override
    protected void doUpdateName() {
        AllJoynManager.lampManager.setLampName(itemModel.id, itemModel.getName(), SampleAppActivity.LANGUAGE);
    }

    @Override
    protected String getDuplicateNameMessage() {
        return activity.getString(R.string.duplicate_name_message_lamp);
    }

    @Override
    protected boolean duplicateName(String name) {
        Iterator<Lamp> i = activity.systemManager.getLampCollectionManager().getLampIterator();

        while (i.hasNext()) {
            LampDataModel lampModel = i.next().getLampDataModel();

            if (lampModel.getName().equals(name) && !name.equals(itemModel.getName())) {
                return true;
            }
        }

        return false;
    }
}