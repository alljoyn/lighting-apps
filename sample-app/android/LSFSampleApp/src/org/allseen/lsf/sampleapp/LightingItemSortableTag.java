/*
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.sampleapp;

import java.util.Locale;

/*
 * This class is designed to be immutable so that it is safer to use
 * as an external marker for the current sorted state of a containing
 * object. Should the containing object later need to update its
 * sorting state, it will have to create a new instance of this class.
 * Any external marker would therefore be left in the old state, and a
 * comparison would reveal that resorting is necessary.
 */
public class LightingItemSortableTag implements Comparable<LightingItemSortableTag> {

    public final String sortableName;
    public final String tieBreaker;

    public LightingItemSortableTag(String id, char prefix, String name) {
        super();

        this.sortableName = prefix + name.toLowerCase(Locale.ENGLISH);
        this.tieBreaker = id;
    }

    public LightingItemSortableTag(LightingItemSortableTag other) {
        super();

        this.sortableName = other.sortableName;
        this.tieBreaker = other.tieBreaker;
    }

    @Override
    public int compareTo(LightingItemSortableTag other) {
        int comparison = sortableName.compareTo(other.sortableName);

        return comparison != 0 ? comparison : tieBreaker.compareTo(other.tieBreaker);
    }

    @Override
    public String toString() {
        return "{" + sortableName + ", " + tieBreaker + "}";
    }
}