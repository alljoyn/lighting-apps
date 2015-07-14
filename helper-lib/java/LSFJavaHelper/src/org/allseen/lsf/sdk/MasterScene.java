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

import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.model.LightingItemDataModel;
import org.allseen.lsf.sdk.model.LightingItemUtil;
import org.allseen.lsf.sdk.model.MasterSceneDataModel;

/**
 * A MasterScene object represents a collection of Scene definitions in a lighting system.
 */
public class MasterScene extends SceneItem {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            MasterSceneDataModel.defaultName = defaultName;
        }
    }

    protected MasterSceneDataModel masterModel;

    protected MasterScene(String masterSceneID) {
        super();

        masterModel = new MasterSceneDataModel(masterSceneID);
    }

    /**
     * Applies the Master Scene to the Lighting System.
     */
    @Override
    public void apply() {
        String errorContext = "MasterScene.apply() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.masterSceneManager.applyMasterScene(masterModel.id));
    }

    /**
     * Modifies the Master Scene with the array of Scenes passed as a parameter.
     *
     * @param scenes The array of Scenes.
     */
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

    /**
     * Adds a Scene to the Master Scene.
     *
     * @param scene The Scene to be added.
     */
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

    /**
     * Removes a Scene from the Master Scene.
     *
     * @param scene The Scene to be removed.
     */
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

    /**
     * Deletes the Master Scene.
     */
    @Override
    public void delete() {
        String errorContext = "MasterScene.delete() error";

        postErrorIfFailure(errorContext,
                AllJoynManager.masterSceneManager.deleteMasterScene(masterModel.id));
    }

    /**
     * Renames the Master Scene.
     *
     * @param masterSceneName The new name for the Mster Scene.
     */
    @Override
    public void rename(String masterSceneName) {
        String errorContext = "MasterScene.rename() error";

        if (postInvalidArgIfNull(errorContext, masterSceneName)) {
            postErrorIfFailure(errorContext,
                    AllJoynManager.masterSceneManager.setMasterSceneName(masterModel.id, masterSceneName, LightingDirector.get().getDefaultLanguage()));
        }
    }

    /**
     * Returns all the Scene IDs of the Scenes in the Master Scene in an array.
     *
     * @return The Scene IDs of the Scenes in the Master Scene in an array.
     */
    public String[] getSceneIDs() {
        return masterModel.getMasterScene().getScenes();
    }

    //TODO-DOC
    public Scene[] getScenes() {
        //TODO-CHK Do we need to insert null "placeholders"?
        return LightingDirector.get().getScenes(Arrays.asList(getSceneIDs()));
    }

    /**
     * Returns boolean true if the Master Scene contains the Lighting Item
     * specified as a component, false otherwise.
     *
     * @param item The Lighting Item to be confirmed a component of the Master Scene.
     * @return  boolean true if the Master Scene contains the Lighting Item
     * specified as a component, false otherwise.
     */
    @Override
    public boolean hasComponent(LightingItem item) {
        String errorContext = "MasterScene.hasComponent() error";
        return postInvalidArgIfNull(errorContext, item) ? hasScene(item.getId()) : false;
    }

    /**
     * Returns boolean true if the Master Scene contains the Scene specified, false otherwise.
     *
     * @param scene The Scene to be confirmed a component of the Master Scene.
     * @return boolean true if the Master Scene contains the Scene specified, false otherwise.
     */
    public boolean hasScene(Scene scene) {
        String errorContext = "MasterScene.hasScene() error";
        return postInvalidArgIfNull(errorContext, scene) ? hasScene(scene.getId()) : false;
    }

    protected boolean hasScene(String sceneID) {
        return masterModel.containsBasicScene(sceneID);
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getMasterSceneDataModel();
    }

    protected MasterSceneDataModel getMasterSceneDataModel() {
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
