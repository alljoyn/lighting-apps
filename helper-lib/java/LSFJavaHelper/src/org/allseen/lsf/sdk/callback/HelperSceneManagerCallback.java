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

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.Scene;
import org.allseen.lsf.SceneManagerCallback;
import org.allseen.lsf.SceneWithSceneElements;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class HelperSceneManagerCallback extends SceneManagerCallback {

    protected final SceneManagerCallback[] managerCBs;

    public HelperSceneManagerCallback(SceneManagerCallback[] sceneManagerCBs) {
        this.managerCBs = sceneManagerCBs;
    }

    @Override
    public void getAllSceneIDsReplyCB(ResponseCode responseCode, String[] sceneIDs) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.getAllSceneIDsReplyCB(responseCode, sceneIDs);
        }
    }

    @Override
    public void getSceneNameReplyCB(ResponseCode responseCode, String sceneID, String language, String sceneName) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.getSceneNameReplyCB(responseCode, sceneID, language, sceneName);
        }
    }

    @Override
    public void setSceneNameReplyCB(ResponseCode responseCode, String sceneID, String language) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.setSceneNameReplyCB(responseCode, sceneID, language);
        }
    }

    @Override
    public void scenesNameChangedCB(String[] sceneIDs) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.scenesNameChangedCB(sceneIDs);
        }
    }

    @Override
    public void createSceneReplyCB(ResponseCode responseCode, String sceneID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.createSceneReplyCB(responseCode, sceneID);
        }
    }

    @Override
    public void scenesCreatedCB(String[] sceneIDs) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.scenesCreatedCB(sceneIDs);
        }
    }

    @Override
    public void updateSceneReplyCB(ResponseCode responseCode, String sceneID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.updateSceneReplyCB(responseCode, sceneID);
        }
    }

    @Override
    public void scenesUpdatedCB(String[] sceneIDs) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.scenesUpdatedCB(sceneIDs);
        }
    }

    @Override
    public void deleteSceneReplyCB(ResponseCode responseCode, String sceneID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.deleteSceneReplyCB(responseCode, sceneID);
        }
    }

    @Override
    public void scenesDeletedCB(String[] sceneIDs) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.scenesDeletedCB(sceneIDs);
        }
    }

    @Override
    public void getSceneReplyCB(ResponseCode responseCode, String sceneID, Scene scene) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.getSceneReplyCB(responseCode, sceneID, scene);
        }
    }

    @Override
    public void applySceneReplyCB(ResponseCode responseCode, String sceneID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.applySceneReplyCB(responseCode, sceneID);
        }
    }

    @Override
    public void scenesAppliedCB(String[] sceneIDs) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.scenesAppliedCB(sceneIDs);
        }
    }

    @Override
    public void createSceneWithTrackingReplyCB(ResponseCode responseCode, String sceneID, long trackingID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.createSceneWithTrackingReplyCB(responseCode, sceneID, trackingID);
        }
    }

    @Override
    public void createSceneWithSceneElementsReplyCB(ResponseCode responseCode, String sceneID, long trackingID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.createSceneWithSceneElementsReplyCB(responseCode, sceneID, trackingID);
        }
    }

    @Override
    public void updateSceneWithSceneElementsReplyCB(ResponseCode responseCode, String sceneID) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.updateSceneWithSceneElementsReplyCB(responseCode, sceneID);
        }
    }

    @Override
    public void getSceneWithSceneElementsReplyCB(ResponseCode responseCode, String sceneID, SceneWithSceneElements scene) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.getSceneWithSceneElementsReplyCB(responseCode, sceneID, scene);
        }
    }

    @Override
    public void getSceneVersionReplyCB(ResponseCode responseCode, String sceneID, long sceneVersion) {
        for (SceneManagerCallback managerCB : managerCBs) {
            managerCB.getSceneVersionReplyCB(responseCode, sceneID, sceneVersion);
        }
    }
}
