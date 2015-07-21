/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "LSFSDKGroupDelegate.h"

/**
 * Provides a base class for developers to extend and implement to receive all Group related events in the
 * Lighting system. Any method of the LSFSDKGroupDelegate interface that is not overridden in the subclass will
 * be treated as a no-op.
 *
 * **Note:** Once implemented, the subclass must be registered with the LSFSDKLightingDirector in order
 * to receive Group callbacks. See [LSFSDKLightingDirector addGroupDelegate:] for more information.
 */
@interface LSFSDKGroupDelegateBase : NSObject <LSFSDKGroupDelegate>

@end
