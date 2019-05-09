/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

<<<<<<< HEAD
#import "SDWebImageCompat.h"
#import "SDWebImageOperation.h"

// These methods are used to support canceling for UIView image loading, it's designed to be used internal but not external.
// All the stored operations are weak, so it will be dalloced after image loading finished. If you need to store operations, use your own class to keep a strong reference for them.
@interface UIView (WebCacheOperation)

/**
 *  Set the image load operation (storage in a UIView based weak map table)
=======
#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

@interface UIView (WebCacheOperation)

/**
 *  Set the image load operation (storage in a UIView based dictionary)
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
 *
 *  @param operation the operation
 *  @param key       key for storing the operation
 */
<<<<<<< HEAD
- (void)sd_setImageLoadOperation:(nullable id<SDWebImageOperation>)operation forKey:(nullable NSString *)key;
=======
- (void)sd_setImageLoadOperation:(id)operation forKey:(NSString *)key;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 *  Cancel all operations for the current UIView and key
 *
 *  @param key key for identifying the operations
 */
<<<<<<< HEAD
- (void)sd_cancelImageLoadOperationWithKey:(nullable NSString *)key;
=======
- (void)sd_cancelImageLoadOperationWithKey:(NSString *)key;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 *  Just remove the operations corresponding to the current UIView and key without cancelling them
 *
 *  @param key key for identifying the operations
 */
<<<<<<< HEAD
- (void)sd_removeImageLoadOperationWithKey:(nullable NSString *)key;
=======
- (void)sd_removeImageLoadOperationWithKey:(NSString *)key;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

@end
