/*
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
 *    
 *    SPDX-License-Identifier: Apache-2.0
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *    
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *    
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *    
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
*/
package org.allseen.lsf.sdk;

import org.allseen.lsf.sdk.listener.GroupCollectionListenerBase;

/**
 * Provides a base class for developers to extend and implement to receive all Group related events in the
 * Lighting system. Any method of the GroupListener interface that is not overridden in the subclass will
 * be treated as a no-op.
 * <p>
 * <b>Note: Once implemented, the subclass must be registered with the LightingDirector in order
 * to receive Group callbacks. See {@link LightingDirector#addGroupListener(GroupListener) addGroupListener}
 * for more information.</b>
 */
public class GroupListenerBase extends GroupCollectionListenerBase<Group, LightingItemErrorEvent> implements GroupListener {

}