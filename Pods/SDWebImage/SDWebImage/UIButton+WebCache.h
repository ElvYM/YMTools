/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompat.h"
<<<<<<< HEAD

#if SD_UIKIT

=======
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
#import "SDWebImageManager.h"

/**
 * Integrates SDWebImage async downloading and caching of remote images with UIButtonView.
 */
@interface UIButton (WebCache)

<<<<<<< HEAD
#pragma mark - Image

/**
 * Get the current image URL.
 */
- (nullable NSURL *)sd_currentImageURL;
=======
/**
 * Get the current image URL.
 */
- (NSURL *)sd_currentImageURL;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Get the image URL for a control state.
 * 
 * @param state Which state you want to know the URL for. The values are described in UIControlState.
 */
<<<<<<< HEAD
- (nullable NSURL *)sd_imageURLForState:(UIControlState)state;
=======
- (NSURL *)sd_imageURLForState:(UIControlState)state;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url   The url for the image.
 * @param state The state that uses the specified title. The values are described in UIControlState.
 */
<<<<<<< HEAD
- (void)sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param state       The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see sd_setImageWithURL:placeholderImage:options:
 */
<<<<<<< HEAD
- (void)sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param state       The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param options     The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 */
<<<<<<< HEAD
- (void)sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param state          The state that uses the specified title. The values are described in UIControlState.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
                 completed:(nullable SDExternalCompletionBlock)completedBlock;
=======
- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param state          The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the imageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param state          The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param options        The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

#pragma mark - Background Image

/**
 * Get the current background image URL.
 */
- (nullable NSURL *)sd_currentBackgroundImageURL;

/**
 * Get the background image URL for a control state.
 * 
 * @param state Which state you want to know the URL for. The values are described in UIControlState.
 */
- (nullable NSURL *)sd_backgroundImageURLForState:(UIControlState)state;
=======
- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the backgroundImageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url   The url for the image.
 * @param state The state that uses the specified title. The values are described in UIControlState.
 */
<<<<<<< HEAD
- (void)sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the backgroundImageView `image` with an `url` and a placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param state       The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see sd_setImageWithURL:placeholderImage:options:
 */
<<<<<<< HEAD
- (void)sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the backgroundImageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param state       The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param options     The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 */
<<<<<<< HEAD
- (void)sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder
                             options:(SDWebImageOptions)options NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the backgroundImageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param state          The state that uses the specified title. The values are described in UIControlState.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state
                           completed:(nullable SDExternalCompletionBlock)completedBlock;
=======
- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the backgroundImageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param state          The state that uses the specified title. The values are described in UIControlState.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder
                           completed:(nullable SDExternalCompletionBlock)completedBlock NS_REFINED_FOR_SWIFT;
=======
- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Set the backgroundImageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param options        The options to use when downloading the image. @see SDWebImageOptions for the possible values.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
<<<<<<< HEAD
- (void)sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder
                             options:(SDWebImageOptions)options
                           completed:(nullable SDExternalCompletionBlock)completedBlock;

#pragma mark - Cancel
=======
- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Cancel the current image download
 */
- (void)sd_cancelImageLoadForState:(UIControlState)state;

/**
 * Cancel the current backgroundImage download
 */
- (void)sd_cancelBackgroundImageLoadForState:(UIControlState)state;

@end

<<<<<<< HEAD
#endif
=======

@interface UIButton (WebCacheDeprecated)

- (NSURL *)currentImageURL __deprecated_msg("Use `sd_currentImageURL`");
- (NSURL *)imageURLForState:(UIControlState)state __deprecated_msg("Use `sd_imageURLForState:`");

- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:forState:`");
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:forState:placeholderImage:`");
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:forState:placeholderImage:options:`");

- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:forState:completed:`");
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:forState:placeholderImage:completed:`");
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:forState:placeholderImage:options:completed:`");

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state __deprecated_msg("Method deprecated. Use `sd_setBackgroundImageWithURL:forState:`");
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder __deprecated_msg("Method deprecated. Use `sd_setBackgroundImageWithURL:forState:placeholderImage:`");
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options __deprecated_msg("Method deprecated. Use `sd_setBackgroundImageWithURL:forState:placeholderImage:options:`");

- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setBackgroundImageWithURL:forState:completed:`");
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setBackgroundImageWithURL:forState:placeholderImage:completed:`");
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setBackgroundImageWithURL:forState:placeholderImage:options:completed:`");

- (void)cancelCurrentImageLoad __deprecated_msg("Use `sd_cancelImageLoadForState:`");
- (void)cancelBackgroundImageLoadForState:(UIControlState)state __deprecated_msg("Use `sd_cancelBackgroundImageLoadForState:`");

@end
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
