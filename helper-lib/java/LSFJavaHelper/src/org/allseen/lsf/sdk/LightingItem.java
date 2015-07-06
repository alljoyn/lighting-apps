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

import org.allseen.lsf.sdk.model.LightingItemDataModel;
import org.allseen.lsf.sdk.model.LightingItemSortableTag;

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

    public LightingItemSortableTag getTag() {
        return getItemDataModel().tag;
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

    @Override
    public LightingItem[] getDependents() {
        Collection<LightingItem> dependents = getDependentCollection();
        return dependents.toArray(new LightingItem[dependents.size()]);
    }

    @Override
    public LightingItem[] getComponents() {
        Collection<LightingItem> components = getComponentCollection();
        return components.toArray(new LightingItem[components.size()]);
    }

    public boolean hasComponent(LightingItem item) {
        // Default implementation -- subclasses may override for efficiency
        return getComponentCollection().contains(item);
    }

    protected Collection<LightingItem> getDependentCollection() {
        // Default implementation is an empty list -- subclasses must override if they can be a component of another item
        return new ArrayList<LightingItem>();
    }

    protected Collection<LightingItem> getComponentCollection() {
        // Default implementation is an empty list -- subclasses must override if they have other items as components
        return new ArrayList<LightingItem>();
    }

    protected boolean postInvalidArgIfNull(String name, Object obj) {
        if (obj == null) {
            postError(new Throwable().getStackTrace()[1].getMethodName(), ResponseCode.ERR_INVALID_ARGS);
            return false;
        }

        return true;
    }

    protected boolean postErrorIfFailure(String name, ControllerClientStatus status) {
        if (status != ControllerClientStatus.OK) {
            postError(new Throwable().getStackTrace()[1].getMethodName(), ResponseCode.ERR_FAILURE);
            return false;
        }

        return true;
    }

    protected void postError(ResponseCode status) {
        postError(new Throwable().getStackTrace()[1].getMethodName(), status);
    }

    public abstract void rename(String name);
    protected abstract LightingItemDataModel getItemDataModel();
    protected abstract void postError(String name, ResponseCode status);
}
