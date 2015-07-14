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

import org.allseen.lsf.sdk.listener.GroupCollectionListener;

/**
 * The listener interface for receiving information about Groups in the lighting
 * system.
 */
public interface GroupListener extends GroupCollectionListener<Group, LightingItemErrorEvent> {
    //TODO-DOC
    @Override
    public void onGroupInitialized(TrackingID trackingId, Group group);

    @Override
    public void onGroupChanged(Group group);

    @Override
    public void onGroupRemoved(Group group);

    @Override
    public void onGroupError(LightingItemErrorEvent error);
}
