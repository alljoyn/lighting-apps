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

public class SceneElementManagerCallback extends DefaultNativeClassWrapper {

    public SceneElementManagerCallback() {
        createNativeObject();
    }

    public void getAllSceneElementIDsReplyCB(ResponseCode responseCode, String[] sceneElementIDs)                                       { }
    public void getSceneElementNameReplyCB(ResponseCode responseCode, String sceneElementID, String language, String sceneElementName)  { }
    public void setSceneElementNameReplyCB(ResponseCode responseCode, String sceneElementID, String language)                           { }
    public void sceneElementsNameChangedCB(String[] sceneElementIDs)                                                                    { }
    public void createSceneElementReplyCB(ResponseCode responseCode, String sceneElementID, long trackingID)                            { }
    public void sceneElementsCreatedCB(String[] sceneElementIDs)                                                                        { }
    public void updateSceneElementReplyCB(ResponseCode responseCode, String sceneElementID)                                             { }
    public void sceneElementsUpdatedCB(String[] sceneElementIDs)                                                                        { }
    public void deleteSceneElementReplyCB(ResponseCode responseCode, String sceneElementID)                                             { }
    public void sceneElementsDeletedCB(String[] sceneElementIDs)                                                                        { }
    public void getSceneElementReplyCB(ResponseCode responseCode, String sceneElementID, SceneElement sceneElement)                     { }
    public void applySceneElementReplyCB(ResponseCode responseCode, String sceneElementID)                                              { }
    public void sceneElementsAppliedCB(String[] sceneElementIDs)                                                                        { }

    @Override
    protected native void createNativeObject();

    @Override
    protected native void destroyNativeObject();
}
