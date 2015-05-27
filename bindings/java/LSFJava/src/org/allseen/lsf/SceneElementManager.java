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
package org.allseen.lsf;

public class SceneElementManager extends BaseNativeClassWrapper {
    public static final int MAX_SCENE_ELEMENTS = 100;

    public SceneElementManager(ControllerClient controller, SceneElementManagerCallback callback) {
        createNativeObject(controller, callback);
    }

    public native ControllerClientStatus getAllSceneElementIDs();
    public native ControllerClientStatus getSceneElementName(String sceneElementID, String language);
    public native ControllerClientStatus setSceneElementName(String sceneElementID, String sceneElementName, String language);
    public native ControllerClientStatus createSceneElement(TrackingID trackingID, SceneElement sceneElement, String sceneElementName, String language);
    public native ControllerClientStatus updateSceneElement(String sceneElementID, SceneElement sceneElement);
    public native ControllerClientStatus deleteSceneElement(String sceneElementID);
    public native ControllerClientStatus getSceneElement(String sceneElementID);
    public native ControllerClientStatus applySceneElement(String sceneElementID);
    public native ControllerClientStatus getSceneElementVersion(String sceneElementID);
    public native ControllerClientStatus getSceneElementDataSet(String sceneElementID, String language);

    protected native void createNativeObject(ControllerClient controller, SceneElementManagerCallback callback);

    @Override
    protected native void destroyNativeObject();
}
