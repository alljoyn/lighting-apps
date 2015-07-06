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

import org.allseen.lsf.sdk.model.LightingItemDataModel;
import org.allseen.lsf.sdk.model.SceneDataModel;

public class SceneV1 extends Scene {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            SceneDataModel.defaultName = defaultName;
        }
    }

    protected SceneDataModel sceneModel;

    /**
     * Constructs a Scene using the specified ID.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * Scenes directly, but should instead get them from the {@link LightingDirector} using the
     * {@link LightingDirector#getScenes()} method.</b>
     *
     * @param sceneID The ID of the scene
     */
    protected SceneV1(String sceneID) {
        this(new SceneDataModel(sceneID));
    }

    protected SceneV1(SceneV1 scene) {
        this(new SceneDataModel(scene.getSceneDataModel()));
    }

    protected SceneV1(SceneDataModel sceneModel) {
        super();

        this.sceneModel = sceneModel;
    }

    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "SceneV1.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasPreset(item.getId()) || hasGroup(item.getId()) : false;
    }

    public boolean hasPreset(Preset preset) {
        String errorContext = "SceneV1.hasPreset() error";
        return postInvalidArgIfNull(errorContext, preset) ? hasPreset(preset.getId()) : false;
    }

    public boolean hasGroup(Group group) {
        String errorContext = "SceneV1.hasGroup() error";
        return postInvalidArgIfNull(errorContext, group) ? hasGroup(group.getId()) : false;
    }

    protected boolean hasPreset(String presetID) {
        return sceneModel.containsPreset(presetID);
    }

    protected boolean hasGroup(String groupID) {
        return sceneModel.containsGroup(groupID);
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getSceneDataModel();
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    protected SceneDataModel getSceneDataModel() {
        return sceneModel;
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getSceneCollectionManager().sendErrorEvent(name, status, getId());
            }
        });
    }
}
