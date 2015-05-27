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
package org.allseen.lsf.sdk.callback;

import java.util.HashMap;
import java.util.Map;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.SceneManagerCallback;
import org.allseen.lsf.SceneWithSceneElements;
import org.allseen.lsf.TrackingID;
import org.allseen.lsf.sdk.manager.AllJoynManager;
import org.allseen.lsf.sdk.manager.LightingSystemManager;
import org.allseen.lsf.sdk.model.SceneDataModelV2;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class HelperSceneManagerCallbackV2 extends SceneManagerCallback {
    protected LightingSystemManager manager;
    protected Map<String, TrackingID> creationTrackingIDs;

    public HelperSceneManagerCallbackV2(LightingSystemManager manager) {
        this.manager = manager;
        this.creationTrackingIDs = new HashMap<String, TrackingID>();
    }

    @Override
    public void getAllSceneIDsReplyCB(ResponseCode responseCode, String[] sceneIDs) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("getAllSceneIDsReplyCB", responseCode, null);
        }

        for (final String sceneID : sceneIDs) {
            postProcessSceneID(sceneID);
        }
    }

    @Override
    public void getSceneNameReplyCB(ResponseCode responseCode, String sceneID, String language, String sceneName) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("getSceneNameReplyCB", responseCode, sceneID);
        }

        postUpdateSceneName(sceneID, sceneName);
    }

    @Override
    public void setSceneNameReplyCB(ResponseCode responseCode, String sceneID, String language) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("setSceneNameReplyCB", responseCode, sceneID);
        }

        AllJoynManager.sceneManager.getSceneName(sceneID, LightingSystemManager.LANGUAGE);
    }

    @Override
    public void scenesNameChangedCB(final String[] sceneIDs) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                boolean containsNewIDs = false;

                for (final String sceneID : sceneIDs) {
                    if (manager.getSceneCollectionManager().hasID(sceneID)) {
                        AllJoynManager.sceneManager.getSceneName(sceneID, LightingSystemManager.LANGUAGE);
                    } else {
                        containsNewIDs = true;
                    }
                }

                if (containsNewIDs) {
                    AllJoynManager.sceneManager.getAllSceneIDs();
                }
            }
        });
    }

    @Override
    public void createSceneWithSceneElementsReplyCB(ResponseCode responseCode, String sceneID, long trackingID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("createSceneReplyCB", responseCode, sceneID, new TrackingID(trackingID));
        } else {
            creationTrackingIDs.put(sceneID, new TrackingID(trackingID));
        }
    }

    @Override
    public void scenesCreatedCB(String[] sceneIDs) {
        AllJoynManager.sceneManager.getAllSceneIDs();
    }

    @Override
    public void updateSceneWithSceneElementsReplyCB(ResponseCode responseCode, String sceneID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("updateSceneReplyCB", responseCode, sceneID);
        }
    }

    @Override
    public void scenesUpdatedCB(String[] sceneIDs) {
        for (String sceneID : sceneIDs) {
            AllJoynManager.sceneManager.getSceneWithSceneElements(sceneID);
        }
    }

    @Override
    public void deleteSceneReplyCB(ResponseCode responseCode, String sceneID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("deleteSceneReplyCB", responseCode, sceneID);
        }
    }

    @Override
    public void scenesDeletedCB(String[] sceneIDs) {
        postDeleteScenes(sceneIDs);
    }

    @Override
    public void getSceneWithSceneElementsReplyCB(ResponseCode responseCode, String sceneID, SceneWithSceneElements scene) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("getSceneReplyCB", responseCode, sceneID);
        }

        postUpdateScene(sceneID, scene);
    }

    @Override
    public void applySceneReplyCB(ResponseCode responseCode, String sceneID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneCollectionManager().sendErrorEvent("applySceneReplyCB", responseCode, sceneID);
        }
    }

    @Override
    public void scenesAppliedCB(String[] sceneIDs) {
        // Currently nothing to do
    }

    protected void postProcessSceneID(final String sceneID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                if (!manager.getSceneCollectionManager().hasID(sceneID)) {
                    postUpdateSceneID(sceneID);
                    AllJoynManager.sceneManager.getSceneName(sceneID, LightingSystemManager.LANGUAGE);
                    AllJoynManager.sceneManager.getSceneWithSceneElements(sceneID);
                }
            }
        });
    }

    protected void postUpdateSceneID(final String sceneID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                if (!manager.getSceneCollectionManager().hasID(sceneID)) {
                    manager.getSceneCollectionManager().addScene(sceneID);
                }
            }
        });

        postSendSceneChanged(sceneID);
    }

    protected void postUpdateScene(final String sceneID, final SceneWithSceneElements scene) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                SceneDataModelV2 sceneModel = manager.getSceneCollectionManager().getModel(sceneID);

                if (sceneModel != null) {
                    boolean wasInitialized = sceneModel.isInitialized();
                    sceneModel.setSceneWithSceneElements(scene);
                    if (wasInitialized != sceneModel.isInitialized()) {
                        postSendSceneInitialized(sceneID);
                    }
                }
            }
        });

        postSendSceneChanged(sceneID);
    }

    protected void postUpdateSceneName(final String sceneID, final String sceneName) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                SceneDataModelV2 sceneModel = manager.getSceneCollectionManager().getModel(sceneID);

                if (sceneModel != null) {
                    boolean wasInitialized = sceneModel.isInitialized();
                    sceneModel.setName(sceneName);
                    if (wasInitialized != sceneModel.isInitialized()) {
                        postSendSceneInitialized(sceneID);
                    }
                }
            }
        });

        postSendSceneChanged(sceneID);
    }

    protected void postDeleteScenes(final String[] sceneIDs) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                for (String sceneID : sceneIDs) {
                    manager.getSceneCollectionManager().removeScene(sceneID);
                }
            }
        });
    }

    protected void postSendSceneChanged(final String sceneID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                manager.getSceneCollectionManager().sendChangedEvent(sceneID);
            }
        });
    }

    protected void postSendSceneInitialized(final String sceneID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                manager.getSceneCollectionManager().sendInitializedEvent(sceneID, creationTrackingIDs.remove(sceneID));
            }
        });
    }
}
