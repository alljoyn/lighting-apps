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

import java.util.ArrayList;
import java.util.Collection;

import org.allseen.lsf.sdk.manager.AllJoynManager;

/**
 * Abstract base class that represents generic Scene behavior in the Lighting system. Generic scenes
 * can be applied, renamed, and deleted.
 */
public abstract class Scene extends SceneItem {

    /**
     * Applies the current Scene in the Lighting system.
     */
    @Override
    public void apply() {
        String errorContext = "Scene.apply() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.sceneManager.applyScene(this.getId()));
    }

    /**
     * Renames the current Scene using the provided name.
     *
     * @param sceneName The new name for the Scene
     */
    @Override
    public void rename(String sceneName) {
        String errorContext = "Scene.rename() error";

        if (postInvalidArgIfNull(errorContext, sceneName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.sceneManager.setSceneName(this.getId(), sceneName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Deletes the current Scene in the Lighting system.
     */
    @Override
    public void delete() {
        AllJoynManager.sceneManager.deleteScene(this.getId());
    }

    /**
     * <b>WARNING: This method is not intended to be used by clients, and may change or be
     * removed in subsequent releases of the SDK.</b>
     */
    @Override
    protected Collection<LightingItem> getDependentCollection() {
        LightingDirector director = LightingDirector.get();
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(director.getMasterSceneCollectionManager().getMasterScenesCollection(new HasComponentFilter<MasterScene>(Scene.this)));

        return dependents;
    }
}
