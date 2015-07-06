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

import org.allseen.lsf.sdk.model.ControllerDataModel;
import org.allseen.lsf.sdk.model.LightingItemDataModel;

// This class represents the client's info on a device providing the Lighting
// Controller Service (LSF) functionality (currently only the lead controller
// is exposed). In contrast, the LightingController class is an implementation
// of the LSF, and is used by devices that want to provide the LSF functionality.
public class Controller extends LightingItem {
    public static void setDefaultName(String defaultName) {
        if (defaultName != null) {
            ControllerDataModel.defaultName = defaultName;
        }
    }
    protected ControllerDataModel controllerModel;

    /**
     * Constructs a Controller.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * the Controller directly, but should instead get it from the {@link LightingDirector} using the
     * {@link LightingDirector#getLeadController()} method.</b>
     */
    protected Controller() {
        controllerModel = new ControllerDataModel();
    }

    @Override
    public void rename(String name) {
        // This method is not yet implemented
        postError(ResponseCode.ERR_FAILURE);
    }

    public boolean isConnected() {
        return getControllerDataModel().connected;
    }

    public long getVersion() {
        return getControllerDataModel().version;
    }

    protected ControllerDataModel getControllerDataModel() {
        return controllerModel;
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getControllerDataModel();
    }

    @Override
    protected void postError(final String name, final ResponseCode status) {
        LightingDirector.get().getLightingSystemManager().getQueue().post(new Runnable() {
            @Override
            public void run() {
                LightingDirector.get().getControllerManager().sendErrorEvent(name, status);
            }
        });
    }
}
