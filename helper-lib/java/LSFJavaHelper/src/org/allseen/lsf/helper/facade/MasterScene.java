/* Copyright (c) AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.helper.facade;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.LightingItemDataModel;
import org.allseen.lsf.helper.model.LightingItemUtil;
import org.allseen.lsf.helper.model.MasterSceneDataModel;

/**
 * A MasterScene object represents a collection of scene definitions in a lighting system.
 * <p>
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public final class MasterScene extends LightingItem {

    protected MasterSceneDataModel masterModel;

    public MasterScene(String masterSceneID) {
        super();

        masterModel = new MasterSceneDataModel(masterSceneID);
    }

    public void apply() {
        String errorContext = "MasterScene.apply() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.masterSceneManager.applyMasterScene(masterModel.id));
    }

    public void modify(Scene[] scenes) {
        String errorContext = "MasterScene.modify() error";

        if (postInvalidArgIfNull(errorContext, scenes)) {
            String[] sceneIds = new String[scenes.length];
            for (int i = 0; i < scenes.length; i++) {
                sceneIds[i] = scenes[i].getId();
            }

            postErrorIfFailure(errorContext,
                    AllJoynManager.masterSceneManager.updateMasterScene(masterModel.id, LightingItemUtil.createMasterScene(sceneIds)));
        }
    }

    public void add(Scene scene) {
        String errorContext = "MasterScene.add() error";

        if (postInvalidArgIfNull(errorContext, scene)) {
            Set<String> sceneIds = new HashSet<String>(Arrays.asList(masterModel.getMasterScene().getScenes()));
            // only update this master scene if it does not already contains the scene to add
            if (sceneIds.add(scene.getId())) {
                postErrorIfFailure(errorContext,
                    AllJoynManager.masterSceneManager.updateMasterScene(masterModel.id, LightingItemUtil.createMasterScene(
                            sceneIds.toArray(new String[sceneIds.size()]))));
            }
        }
    }

    public void remove(Scene scene) {
        String errorContext = "MasterScene.remove() error";

        if (postInvalidArgIfNull(errorContext, scene)) {
            Set<String> sceneIds = new HashSet<String>(Arrays.asList(masterModel.getMasterScene().getScenes()));
            // only update this master scene if it contains the scene to remove
            if (sceneIds.remove(scene.getId())) {
                postErrorIfFailure(errorContext,
                        AllJoynManager.masterSceneManager.updateMasterScene(masterModel.id, LightingItemUtil.createMasterScene(
                                sceneIds.toArray(new String[sceneIds.size()]))));
            }
        }
    }

    public void delete() {
        String errorContext = "MasterScene.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.masterSceneManager.deleteMasterScene(masterModel.id));
    }

    @Override
    public void rename(String masterSceneName) {
        String errorContext = "MasterScene.rename() error";

        if (postInvalidArgIfNull(errorContext, masterSceneName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.masterSceneManager.setMasterSceneName(masterModel.id, masterSceneName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getMasterSceneDataModel();
    }

    public MasterSceneDataModel getMasterSceneDataModel() {
        return masterModel;
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getMasterSceneCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
