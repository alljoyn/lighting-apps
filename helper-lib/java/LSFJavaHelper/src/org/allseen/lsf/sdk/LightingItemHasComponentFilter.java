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
package org.allseen.lsf.sdk;

import org.allseen.lsf.sdk.model.LightingItemFilter;

/**
 * A LightingItemHasComponentFilter is used to filter items with a specified component.
 *
 * @param <ITEM> The item type to be filtered.
 */
public class LightingItemHasComponentFilter<ITEM extends LightingItem> implements LightingItemFilter<ITEM> {
    protected LightingItem component;

    /**
     * Constructs a Lighting Item Filter for a specified component.
     *
     * @param component The component to be filtered for each tem
     * passed to the filter.
     */
    public LightingItemHasComponentFilter(LightingItem component) {
        this.component = component;
    }

    /**
     * Returns a boolean true if the item contains the specified component,
     * false otherwise.
     *
     * @return Returns a boolean true if the item contains the specified component,
     * false otherwise.
     */
    @Override
    public boolean passes(ITEM item) {
        return item.hasComponent(component);
    }
}
