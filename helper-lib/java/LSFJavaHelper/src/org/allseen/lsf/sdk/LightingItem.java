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
 */
public abstract class LightingItem implements LightingItemInterface {

    /**
     * Returns the name of the Lighting Item.
     *
     * @return The name of the Lighting Item.
     */
    @Override
    public String getName() {
        return getItemDataModel().getName();
    }

    /**
     * Returns the ID of the Lighting Item.
     *
     * @return the ID of the Lighting Item.
     */
    @Override
    public String getId() {
        return getItemDataModel().id;
    }

    /**
     * Returns the sortable tag of the Lighting Item.
     *
     * @return The sortable tag of the Lighting Item.
     */
    public LightingItemSortableTag getTag() {
        return getItemDataModel().tag;
    }

    /**
     * Returns a boolean true if the Lighting Item is initialized.
     *
     * @return boolean true if the Lighting Item is initialized.
     */
    public boolean isInitialized() {
        return getItemDataModel().isInitialized();
    }

    /**
     * Returns the hash code of the Lighting Item.
     *
     * @return the hash code of the Lighting Item.
     */
    @Override
    public int hashCode() {
        return getId().hashCode();
    }

    /**
     * Returns boolean true if the Lighting Item is equivalent to the other object.
     *
     * @param other The other Object.
     * @return boolean true if the Lighting Item is equivalent to the other object.
     */
    @Override
    public boolean equals(Object other) {
        boolean equivalent = false;

        if (other != null && other instanceof LightingItem) {
            equivalent = getId().equals(((LightingItem) other).getId());
        }

        return equivalent;
    }

    /**
     * Returns an array of dependent Lighting Items.
     *
     * @return Array of dependent Lighting Items.
     */
    @Override
    public LightingItem[] getDependents() {
        Collection<LightingItem> dependents = getDependentCollection();
        return dependents.toArray(new LightingItem[dependents.size()]);
    }

    /**
     * Returns an array of component Lighting Items.
     *
     * @return Array of component Lighting Items.
     */
    @Override
    public LightingItem[] getComponents() {
        Collection<LightingItem> components = getComponentCollection();
        return components.toArray(new LightingItem[components.size()]);
    }

    /**
     * Returns boolean true if the Lighting Item has the method parameter as a component.
     *
     * @param item The Lighting Item to be confirmed a component.
     * @return boolean true if the Lighting Item has the method paramter as a component.
     */
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
