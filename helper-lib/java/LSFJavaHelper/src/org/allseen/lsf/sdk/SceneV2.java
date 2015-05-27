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
package org.allseen.lsf.sdk;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.LightingItemDataModel;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.SceneDataModelV2;

public final class SceneV2 extends Scene {

    protected SceneDataModelV2 sceneModel;

    public SceneV2(String sceneID) {
        this(new SceneDataModelV2(sceneID));
    }

    public SceneV2(SceneDataModelV2 sceneModel) {
        super();

        this.sceneModel = sceneModel;
    }

    public void modify(SceneElement[] elements) {
        String errorContext = "SceneV2.modify() error";

        if (postInvalidArgIfNull(errorContext, elements)) {

            String[] sceneElementIds = new String[elements.length];
            for (int i = 0; i < elements.length; i++) {
                sceneElementIds[i] = elements[0].getId();
            }

            postErrorIfFailure(errorContext,
                    AllJoynManager.sceneManager.updateSceneWithSceneElements(sceneModel.id, LightingItemUtil.createSceneWithSceneElements(sceneElementIds)));
        }
    }

    public void add(SceneElement element) {
        String errorContext = "SceneV2.add() error";

        if (postInvalidArgIfNull(errorContext, element)) {
            Set<String> sceneElementIds = new HashSet<String>(Arrays.asList(sceneModel.getSceneWithSceneElements().getSceneElements()));
            // only update this SceneElement if it does not already contain the Scene to add
            if (sceneElementIds.add(element.getId())) {
                postErrorIfFailure(errorContext,
                    AllJoynManager.sceneManager.updateSceneWithSceneElements(sceneModel.id, LightingItemUtil.createSceneWithSceneElements(
                            sceneElementIds.toArray(new String[sceneElementIds.size()]))));
            }
        }
    }

    public void remove(SceneElement element) {
        String errorContext = "SceneV2.remove() error";

        if (postInvalidArgIfNull(errorContext, element)) {
            Set<String> sceneElementIds = new HashSet<String>(Arrays.asList(sceneModel.getSceneWithSceneElements().getSceneElements()));
            // only update this SceneElement if it contains the scene to remove
            if (sceneElementIds.remove(element.getId())) {
                postErrorIfFailure(errorContext,
                    AllJoynManager.sceneManager.updateSceneWithSceneElements(sceneModel.id, LightingItemUtil.createSceneWithSceneElements(
                            sceneElementIds.toArray(new String[sceneElementIds.size()]))));
            }
        }
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getSceneDataModel();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    public SceneDataModelV2 getSceneDataModel() {
        return sceneModel;
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getSceneCollectionManagerV2().sendErrorEvent(name, status, getId());
            }
        });
    }
}
