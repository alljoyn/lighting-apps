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

#import "LSFSDKLightingControllerConfiguration.h"

/**
 * Provides a base class for developers to extend or use directly to define the application and device
 * specific properties for the LSFSDKLightingController. This class can be instantiated and passed directly
 * to the LSFSDKLightingController without modification. Developers can override only the functions they wish
 * to change.
 *
 * An example usage of a LightingControllerConfigurationBase can be found in the LSFTutorial project.
 *
 * @warning All parameters are set using hard coded values EXCEPT the absolute save path which must be
 * passed in to the constructor.
 *
 * @warning Once implemented, the configuration must be registered with the LSFSDKLightingController
 * using the [LSFSDKLightingController initializeWithControllerConfiguration:] method.
 */
@interface LSFSDKLightingControllerConfigurationBase : NSObject <LSFSDKLightingControllerConfiguration>
{
    @private NSString *keystoreFilePath;
}

-(id)initWithKeystorePath: (NSString *)keystorePath;

@end