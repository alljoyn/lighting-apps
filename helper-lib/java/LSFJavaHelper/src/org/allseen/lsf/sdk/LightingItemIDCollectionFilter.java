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

import java.util.Collection;

import org.allseen.lsf.sdk.model.LightingItemFilter;

/**
 * A LightingItemIDCollectionFilter is used to filter items with an itemID that matches
 * one of a specified collection of itemID Strings.
 *
 * @param <ITEM> The item type to be filtered.
 */
public class LightingItemIDCollectionFilter<ITEM extends LightingItem> implements LightingItemFilter<ITEM> {
    protected Collection<String> itemIDs;

    /**
     * Constructs a Lighting Item Filter for a specified itemID Strings.
     *
     * @param itemIDs The itemIDs to be filtered for in each Item
     * passed to the filter.
     */
    public LightingItemIDCollectionFilter(Collection<String> itemIDs) {
        this.itemIDs = itemIDs;
    }

    /**
     * Returns a boolean true if the item contains one of the specified itemIDs,
     * false otherwise.
     *
     * @return boolean true if the item contains on of the specified itemIDs,
     * false otherwise.
     */
    @Override
    public boolean passes(ITEM item) {
        return itemIDs.contains(item.getId());
    }
}
