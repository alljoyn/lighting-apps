/*
 * Copyright (c) AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.sampleapp;

import java.util.Iterator;

import org.allseen.lsf.sdk.MasterScene;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.MasterSceneDataModel;

public class UpdateMasterSceneNameAdapter extends UpdateItemNameAdapter {

    public UpdateMasterSceneNameAdapter(MasterSceneDataModel masterSceneModel, SampleAppActivity activity) {
        super(masterSceneModel, activity);
    }

    @Override
    protected void doUpdateName() {
        AllJoynManager.masterSceneManager.setMasterSceneName(itemModel.id, itemModel.getName(), SampleAppActivity.LANGUAGE);
    }

    @Override
    protected String getDuplicateNameMessage() {
        return activity.getString(R.string.duplicate_name_message_scene);
    }

    @Override
    protected boolean duplicateName(String name) {
        Iterator<MasterScene> i = activity.systemManager.getMasterSceneCollectionManager().getMasterSceneIterator();

        while (i.hasNext()) {
            if (i.next().getMasterSceneDataModel().getName().equals(name) && !name.equals(itemModel.getName())) {
                return true;
            }
        }

        return false;
    }
}