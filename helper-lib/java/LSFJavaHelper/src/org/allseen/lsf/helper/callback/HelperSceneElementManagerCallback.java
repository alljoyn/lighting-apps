/*
 * Copyright AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.helper.callback;

import java.util.Arrays;
import java.util.HashSet;

import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.SceneElement;
import org.allseen.lsf.SceneElementManagerCallback;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.manager.LightingSystemManager;
import org.allseen.lsf.helper.model.SceneElementDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class HelperSceneElementManagerCallback extends SceneElementManagerCallback {
    protected LightingSystemManager manager;

    public HelperSceneElementManagerCallback(LightingSystemManager manager) {
        super();

        this.manager = manager;
    }

    @Override
    public void getAllSceneElementIDsReplyCB(ResponseCode responseCode, String[] sceneElementIDs) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneElementCollectionManager().sendErrorEvent("getAllSceneElementIDsReplyCB", responseCode, null);
        }

        for (final String sceneElementID : sceneElementIDs) {
            postProcessSceneElementID(sceneElementID);
        }
    }

    @Override
    public void getSceneElementNameReplyCB(ResponseCode responseCode, String sceneElementID, String language, String sceneElementName) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneElementCollectionManager().sendErrorEvent("", responseCode, sceneElementID);
        }

        postUpdateSceneElementName(sceneElementID, sceneElementName);
    }

    @Override
    public void setSceneElementNameReplyCB(ResponseCode responseCode, String sceneElementID, String language) {
        if (!responseCode.equals(ResponseCode.OK)){
            manager.getSceneElementCollectionManager().sendErrorEvent("", responseCode, sceneElementID);
        }

        AllJoynManager.sceneElementManager.getSceneElementName(sceneElementID, language);
    }

    @Override
    public void sceneElementsNameChangedCB(final String[] sceneElementIDs) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                boolean containsNewIDs = false;

                for (final String sceneElementID : sceneElementIDs) {
                    if (manager.getSceneElementCollectionManager().hasID(sceneElementID)) {
                        AllJoynManager.sceneElementManager.getSceneElementName(sceneElementID, LightingSystemManager.LANGUAGE);
                    } else {
                        containsNewIDs = true;
                    }
                }

                if (containsNewIDs) {
                    AllJoynManager.sceneElementManager.getAllSceneElementIDs();
                }
            }
        });
    }

    @Override
    public void createSceneElementReplyCB(ResponseCode responseCode, String sceneElementID, long trackingID) {
        if (!responseCode.equals(ResponseCode.OK)){
            manager.getPulseEffectCollectionManager().sendErrorEvent("createSceneElementReplyCB", responseCode, sceneElementID);
        }
    }

    @Override
    public void sceneElementsCreatedCB(String[] sceneElementIDs) {
        AllJoynManager.sceneElementManager.getAllSceneElementIDs();
    }

    @Override
    public void updateSceneElementReplyCB(ResponseCode responseCode, String sceneElementID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getTransitionEffectCollectionManager().sendErrorEvent("updateTransitionEffectReplyCB", responseCode, sceneElementID);
        }
    }

    @Override
    public void sceneElementsUpdatedCB(String[] sceneElementIDs) {
        for (String sceneElementID : sceneElementIDs) {
            AllJoynManager.sceneElementManager.getSceneElement(sceneElementID);
        }
    }

    @Override
    public void deleteSceneElementReplyCB(ResponseCode responseCode, String sceneElementID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneElementCollectionManager().sendErrorEvent("deleteSceneElementReplyCB", responseCode, sceneElementID);
        }
    }

    @Override
    public void sceneElementsDeletedCB(String[] sceneElementIDs) {
        postDeleteSceneElements(sceneElementIDs);
    }

    @Override
    public void getSceneElementReplyCB(ResponseCode responseCode, String sceneElementID, SceneElement sceneElement) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneElementCollectionManager().sendErrorEvent("getSceneElementReplyCB", responseCode, sceneElementID);
        }

        postUpdateSceneElement(sceneElementID, sceneElement);
    }

    @Override
    public void applySceneElementReplyCB(ResponseCode responseCode, String sceneElementID) {
        if (!responseCode.equals(ResponseCode.OK)) {
            manager.getSceneElementCollectionManager().sendErrorEvent("applySceneElementReplyCB", responseCode, sceneElementID);
        }
    }

    @Override
    public void sceneElementsAppliedCB(String[] sceneElementIDs) {
        // nothing to do; intentionally left empty
    }

    protected void postProcessSceneElementID(final String sceneElementID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                if (!manager.getSceneElementCollectionManager().hasID(sceneElementID)) {
                    postUpdateSceneElementID(sceneElementID);
                    AllJoynManager.sceneElementManager.getSceneElementName(sceneElementID, LightingSystemManager.LANGUAGE);
                    AllJoynManager.sceneElementManager.getSceneElement(sceneElementID);
                }
            }
        });
    }

    protected void postUpdateSceneElementID(final String sceneElementID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                if (!manager.getSceneElementCollectionManager().hasID(sceneElementID)) {
                    manager.getSceneElementCollectionManager().addSceneElement(sceneElementID);
                }
            }
        });

        postSendSceneElementChanged(sceneElementID);
    }

    protected void postUpdateSceneElementName(final String sceneElementID, final String sceneElementName) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                SceneElementDataModel sceneElementModel = manager.getSceneElementCollectionManager().getModel(sceneElementID);

                if (sceneElementModel != null) {
                    sceneElementModel.setName(sceneElementName);
                }
            }
        });

        postSendSceneElementChanged(sceneElementID);
    }

    protected void postUpdateSceneElement(final String sceneElementID, final SceneElement sceneElement) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                SceneElementDataModel basicSceneElementModel = manager.getSceneElementCollectionManager().getModel(sceneElementID);

                if (basicSceneElementModel != null) {
                    basicSceneElementModel.setEffectId(sceneElement.getEffectID());
                    basicSceneElementModel.setLamps(new HashSet<String>(Arrays.asList(sceneElement.getLamps())));
                    basicSceneElementModel.setGroups(new HashSet<String>(Arrays.asList(sceneElement.getLampGroups())));
                }
            }
        });

        postSendSceneElementChanged(sceneElementID);
    }

    protected void postDeleteSceneElements(final String[] sceneElementIDs) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                for (String sceneElementID : sceneElementIDs) {
                    manager.getSceneElementCollectionManager().removeSceneElement(sceneElementID);
                }
            }
        });
    }

    protected void postSendSceneElementChanged(final String sceneElementID) {
        manager.getQueue().post(new Runnable() {
            @Override
            public void run() {
                manager.getSceneElementCollectionManager().sendChangedEvent(sceneElementID);
            }
        });
    }
}
