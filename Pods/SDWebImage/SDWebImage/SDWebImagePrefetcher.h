/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageManager.h"

@class SDWebImagePrefetcher;

@protocol SDWebImagePrefetcherDelegate <NSObject>

@optional

/**
 * Called when an image was prefetched.
 *
 * @param imagePrefetcher The current image prefetcher
 * @param imageURL        The image url that was prefetched
 * @param finishedCount   The total number of images that were prefetched (successful or not)
 * @param totalCount      The total number of images that were to be prefetched
 */
<<<<<<< HEAD
- (void)imagePrefetcher:(nonnull SDWebImagePrefetcher *)imagePrefetcher didPrefetchURL:(nullable NSURL *)imageURL finishedCount:(NSUInteger)finishedCount totalCount:(NSUInteger)totalCount;
=======
- (void)imagePrefetcher:(SDWebImagePrefetcher *)imagePrefetcher didPrefetchURL:(NSURL *)imageURL finishedCount:(NSUInteger)finishedCount totalCount:(NSUInteger)totalCount;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Called when all images are prefetched.
 * @param imagePrefetcher The current image prefetcher
 * @param totalCount      The total number of images that were prefetched (whether successful or not)
 * @param skippedCount    The total number of images that were skipped
 */
<<<<<<< HEAD
- (void)imagePrefetcher:(nonnull SDWebImagePrefetcher *)imagePrefetcher didFinishWithTotalCount:(NSUInteger)totalCount skippedCount:(NSUInteger)skippedCount;
=======
- (void)imagePrefetcher:(SDWebImagePrefetcher *)imagePrefetcher didFinishWithTotalCount:(NSUInteger)totalCount skippedCount:(NSUInteger)skippedCount;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

@end

typedef void(^SDWebImagePrefetcherProgressBlock)(NSUInteger noOfFinishedUrls, NSUInteger noOfTotalUrls);
typedef void(^SDWebImagePrefetcherCompletionBlock)(NSUInteger noOfFinishedUrls, NSUInteger noOfSkippedUrls);

/**
 * Prefetch some URLs in the cache for future use. Images are downloaded in low priority.
 */
@interface SDWebImagePrefetcher : NSObject

/**
 *  The web image manager
 */
<<<<<<< HEAD
@property (strong, nonatomic, readonly, nonnull) SDWebImageManager *manager;
=======
@property (strong, nonatomic, readonly) SDWebImageManager *manager;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Maximum number of URLs to prefetch at the same time. Defaults to 3.
 */
@property (nonatomic, assign) NSUInteger maxConcurrentDownloads;

/**
 * SDWebImageOptions for prefetcher. Defaults to SDWebImageLowPriority.
 */
@property (nonatomic, assign) SDWebImageOptions options;

/**
 * Queue options for Prefetcher. Defaults to Main Queue.
 */
<<<<<<< HEAD
@property (strong, nonatomic, nonnull) dispatch_queue_t prefetcherQueue;

@property (weak, nonatomic, nullable) id <SDWebImagePrefetcherDelegate> delegate;
=======
@property (nonatomic, assign) dispatch_queue_t prefetcherQueue;

@property (weak, nonatomic) id <SDWebImagePrefetcherDelegate> delegate;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Return the global image prefetcher instance.
 */
<<<<<<< HEAD
+ (nonnull instancetype)sharedImagePrefetcher;
=======
+ (SDWebImagePrefetcher *)sharedImagePrefetcher;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Allows you to instantiate a prefetcher with any arbitrary image manager.
 */
<<<<<<< HEAD
- (nonnull instancetype)initWithImageManager:(nonnull SDWebImageManager *)manager NS_DESIGNATED_INITIALIZER;
=======
- (id)initWithImageManager:(SDWebImageManager *)manager;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Assign list of URLs to let SDWebImagePrefetcher to queue the prefetching,
 * currently one image is downloaded at a time,
<<<<<<< HEAD
 * and skips images for failed downloads and proceed to the next image in the list.
 * Any previously-running prefetch operations are canceled.
 *
 * @param urls list of URLs to prefetch
 */
- (void)prefetchURLs:(nullable NSArray<NSURL *> *)urls;
=======
 * and skips images for failed downloads and proceed to the next image in the list
 *
 * @param urls list of URLs to prefetch
 */
- (void)prefetchURLs:(NSArray *)urls;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Assign list of URLs to let SDWebImagePrefetcher to queue the prefetching,
 * currently one image is downloaded at a time,
<<<<<<< HEAD
 * and skips images for failed downloads and proceed to the next image in the list.
 * Any previously-running prefetch operations are canceled.
=======
 * and skips images for failed downloads and proceed to the next image in the list
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
 *
 * @param urls            list of URLs to prefetch
 * @param progressBlock   block to be called when progress updates; 
 *                        first parameter is the number of completed (successful or not) requests, 
 *                        second parameter is the total number of images originally requested to be prefetched
 * @param completionBlock block to be called when prefetching is completed
 *                        first param is the number of completed (successful or not) requests,
 *                        second parameter is the number of skipped requests
 */
<<<<<<< HEAD
- (void)prefetchURLs:(nullable NSArray<NSURL *> *)urls
            progress:(nullable SDWebImagePrefetcherProgressBlock)progressBlock
           completed:(nullable SDWebImagePrefetcherCompletionBlock)completionBlock;
=======
- (void)prefetchURLs:(NSArray *)urls progress:(SDWebImagePrefetcherProgressBlock)progressBlock completed:(SDWebImagePrefetcherCompletionBlock)completionBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

/**
 * Remove and cancel queued list
 */
- (void)cancelPrefetching;


@end
