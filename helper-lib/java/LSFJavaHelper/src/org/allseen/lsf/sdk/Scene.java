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
 * A Scene object represents a set of lamps and associated states in a lighting system, and can be
 * used to apply the states to the lamps.
 */
public abstract class Scene extends SceneItem {
    @Override
    public void apply() {
        String errorContext = "Scene.apply() error";

        postErrorIfFailure(errorContext,
            AllJoynManager.sceneManager.applyScene(this.getId()));
    }

    @Override
    public void rename(String sceneName) {
        String errorContext = "Scene.rename() error";

        if (postInvalidArgIfNull(errorContext, sceneName)) {
            postErrorIfFailure(errorContext,
                AllJoynManager.sceneManager.setSceneName(this.getId(), sceneName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    @Override
    public void delete() {
        AllJoynManager.sceneManager.deleteScene(this.getId());
    }

    @Override
    protected Collection<LightingItem> getDependentCollection() {
        LightingDirector director = LightingDirector.get();
        Collection<LightingItem> dependents = new ArrayList<LightingItem>();

        dependents.addAll(director.getMasterSceneCollectionManager().getMasterScenesCollection(new LightingItemHasComponentFilter<MasterScene>(Scene.this)));

        return dependents;
    }
}
