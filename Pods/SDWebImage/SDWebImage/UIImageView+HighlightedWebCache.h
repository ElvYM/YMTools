/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

<<<<<<< HEAD
#import "SDWebImageCompat.h"

#if SD_UIKIT

=======
#import <UIKit/UIKit.h>
#import "SDWebImageCompat.h"
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
#import "SDWebImageManager.h"

/**
 * Integrates SDWebImage async downloading and caching of remote images with UIImageView for highlighted state.
 */
@interface UIImageView (HighlightedWebCache)

/**
 * Set the imageView `highlightedImage` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url The url for the image.
 */
<<<<<<< HEAD
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setHighlightedImageWithURL:(NSURL *)url;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url     The url for the image.
 * @param options The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 */
<<<<<<< HEAD
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(SDWebImageOptions)options NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setHighlightedImageWithURL:(NSURL *)url options:(SDWebImageOptions)options;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `highlightedImage` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                            completed:(nullable SDExternalCompletionBlock)completedBlock NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setHighlightedImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(SDWebImageOptions)options
                            completed:(nullable SDExternalCompletionBlock)completedBlock;
=======
- (void)sd_setHighlightedImageWithURL:(NSURL *)url options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 * @param progressBlock  A block called while image is downloading
<<<<<<< HEAD
 *                       @note the progress block is executed on a background queue
=======
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(SDWebImageOptions)options
                             progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                            completed:(nullable SDExternalCompletionBlock)completedBlock;

@end

#endif
=======
- (void)sd_setHighlightedImageWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

/**
 * Cancel the current download
 */
- (void)sd_cancelCurrentHighlightedImageLoad;

@end


@interface UIImageView (HighlightedWebCacheDeprecated)

- (void)setHighlightedImageWithURL:(NSURL *)url __deprecated_msg("Method deprecated. Use `sd_setHighlightedImageWithURL:`");
- (void)setHighlightedImageWithURL:(NSURL *)url options:(SDWebImageOptions)options __deprecated_msg("Method deprecated. Use `sd_setHighlightedImageWithURL:options:`");
- (void)setHighlightedImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setHighlightedImageWithURL:completed:`");
- (void)setHighlightedImageWithURL:(NSURL *)url options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setHighlightedImageWithURL:options:completed:`");
- (void)setHighlightedImageWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setHighlightedImageWithURL:options:progress:completed:`");

- (void)cancelCurrentHighlightedImageLoad __deprecated_msg("Use `sd_cancelCurrentHighlightedImageLoad`");

@end
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
