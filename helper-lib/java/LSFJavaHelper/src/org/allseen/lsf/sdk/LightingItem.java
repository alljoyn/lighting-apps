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

import org.allseen.lsf.ControllerClientStatus;
import org.allseen.lsf.ResponseCode;
import org.allseen.lsf.sdk.model.LightingItemDataModel;

/**
 * Abstract base class for items in a Lighting system.
 * <p>
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public abstract class LightingItem implements LightingItemInterface {
    @Override
    public String getName() {
        return getItemDataModel().getName();
    }

    @Override
    public String getId() {
        return getItemDataModel().id;
    }

    public boolean isInitialized() {
        return getItemDataModel().isInitialized();
    }

    @Override
    public int hashCode() {
        return getId().hashCode();
    }

    @Override
    public boolean equals(Object other) {
        boolean equivalent = false;

        if (other != null && other instanceof LightingItem) {
            equivalent = getId().equals(((LightingItem) other).getId());
        }

        return equivalent;
    }


    protected boolean postInvalidArgIfNull(String name, Object obj) {
        if (obj == null) {
            postError(name, ResponseCode.ERR_INVALID_ARGS);
            return false;
        }

        return true;
    }

    protected boolean postErrorIfFailure(String name, ControllerClientStatus status) {
        if (status != ControllerClientStatus.OK) {
            postError(name, ResponseCode.ERR_FAILURE);
            return false;
        }

        return true;
    }

    public abstract void rename(String name);
    protected abstract LightingItemDataModel getItemDataModel();
    protected abstract void postError(String name, ResponseCode status);
}
