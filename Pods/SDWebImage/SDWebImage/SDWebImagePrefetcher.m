/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImagePrefetcher.h"

@interface SDWebImagePrefetcher ()

<<<<<<< HEAD
@property (strong, nonatomic, nonnull) SDWebImageManager *manager;
@property (strong, atomic, nullable) NSArray<NSURL *> *prefetchURLs; // may be accessed from different queue
=======
@property (strong, nonatomic) SDWebImageManager *manager;
@property (strong, nonatomic) NSArray *prefetchURLs;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
@property (assign, nonatomic) NSUInteger requestedCount;
@property (assign, nonatomic) NSUInteger skippedCount;
@property (assign, nonatomic) NSUInteger finishedCount;
@property (assign, nonatomic) NSTimeInterval startedTime;
<<<<<<< HEAD
@property (copy, nonatomic, nullable) SDWebImagePrefetcherCompletionBlock completionBlock;
@property (copy, nonatomic, nullable) SDWebImagePrefetcherProgressBlock progressBlock;
=======
@property (copy, nonatomic) SDWebImagePrefetcherCompletionBlock completionBlock;
@property (copy, nonatomic) SDWebImagePrefetcherProgressBlock progressBlock;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

@end

@implementation SDWebImagePrefetcher

<<<<<<< HEAD
+ (nonnull instancetype)sharedImagePrefetcher {
=======
+ (SDWebImagePrefetcher *)sharedImagePrefetcher {
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

<<<<<<< HEAD
- (nonnull instancetype)init {
    return [self initWithImageManager:[SDWebImageManager new]];
}

- (nonnull instancetype)initWithImageManager:(SDWebImageManager *)manager {
=======
- (id)init {
    return [self initWithImageManager:[SDWebImageManager new]];
}

- (id)initWithImageManager:(SDWebImageManager *)manager {
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
    if ((self = [super init])) {
        _manager = manager;
        _options = SDWebImageLowPriority;
        _prefetcherQueue = dispatch_get_main_queue();
        self.maxConcurrentDownloads = 3;
    }
    return self;
}

- (void)setMaxConcurrentDownloads:(NSUInteger)maxConcurrentDownloads {
    self.manager.imageDownloader.maxConcurrentDownloads = maxConcurrentDownloads;
}

- (NSUInteger)maxConcurrentDownloads {
    return self.manager.imageDownloader.maxConcurrentDownloads;
}

- (void)startPrefetchingAtIndex:(NSUInteger)index {
<<<<<<< HEAD
    NSURL *currentURL;
    @synchronized(self) {
        if (index >= self.prefetchURLs.count) return;
        currentURL = self.prefetchURLs[index];
        self.requestedCount++;
    }
    [self.manager loadImageWithURL:currentURL options:self.options progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!finished) return;
        self.finishedCount++;

        if (self.progressBlock) {
            self.progressBlock(self.finishedCount,(self.prefetchURLs).count);
        }
        if (!image) {
=======
    if (index >= self.prefetchURLs.count) return;
    self.requestedCount++;
    [self.manager downloadImageWithURL:self.prefetchURLs[index] options:self.options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!finished) return;
        self.finishedCount++;

        if (image) {
            if (self.progressBlock) {
                self.progressBlock(self.finishedCount,[self.prefetchURLs count]);
            }
        }
        else {
            if (self.progressBlock) {
                self.progressBlock(self.finishedCount,[self.prefetchURLs count]);
            }
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
            // Add last failed
            self.skippedCount++;
        }
        if ([self.delegate respondsToSelector:@selector(imagePrefetcher:didPrefetchURL:finishedCount:totalCount:)]) {
            [self.delegate imagePrefetcher:self
<<<<<<< HEAD
                            didPrefetchURL:currentURL
=======
                            didPrefetchURL:self.prefetchURLs[index]
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
                             finishedCount:self.finishedCount
                                totalCount:self.prefetchURLs.count
             ];
        }
        if (self.prefetchURLs.count > self.requestedCount) {
            dispatch_async(self.prefetcherQueue, ^{
<<<<<<< HEAD
                // we need dispatch to avoid function recursion call. This can prevent stack overflow even for huge urls list
=======
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
                [self startPrefetchingAtIndex:self.requestedCount];
            });
        } else if (self.finishedCount == self.requestedCount) {
            [self reportStatus];
            if (self.completionBlock) {
                self.completionBlock(self.finishedCount, self.skippedCount);
                self.completionBlock = nil;
            }
            self.progressBlock = nil;
        }
    }];
}

- (void)reportStatus {
<<<<<<< HEAD
    NSUInteger total = (self.prefetchURLs).count;
=======
    NSUInteger total = [self.prefetchURLs count];
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
    if ([self.delegate respondsToSelector:@selector(imagePrefetcher:didFinishWithTotalCount:skippedCount:)]) {
        [self.delegate imagePrefetcher:self
               didFinishWithTotalCount:(total - self.skippedCount)
                          skippedCount:self.skippedCount
         ];
    }
}

<<<<<<< HEAD
- (void)prefetchURLs:(nullable NSArray<NSURL *> *)urls {
    [self prefetchURLs:urls progress:nil completed:nil];
}

- (void)prefetchURLs:(nullable NSArray<NSURL *> *)urls
            progress:(nullable SDWebImagePrefetcherProgressBlock)progressBlock
           completed:(nullable SDWebImagePrefetcherCompletionBlock)completionBlock {
=======
- (void)prefetchURLs:(NSArray *)urls {
    [self prefetchURLs:urls progress:nil completed:nil];
}

- (void)prefetchURLs:(NSArray *)urls progress:(SDWebImagePrefetcherProgressBlock)progressBlock completed:(SDWebImagePrefetcherCompletionBlock)completionBlock {
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
    [self cancelPrefetching]; // Prevent duplicate prefetch request
    self.startedTime = CFAbsoluteTimeGetCurrent();
    self.prefetchURLs = urls;
    self.completionBlock = completionBlock;
    self.progressBlock = progressBlock;

    if (urls.count == 0) {
        if (completionBlock) {
            completionBlock(0,0);
        }
    } else {
        // Starts prefetching from the very first image on the list with the max allowed concurrency
        NSUInteger listCount = self.prefetchURLs.count;
        for (NSUInteger i = 0; i < self.maxConcurrentDownloads && self.requestedCount < listCount; i++) {
            [self startPrefetchingAtIndex:i];
        }
    }
}

- (void)cancelPrefetching {
<<<<<<< HEAD
    @synchronized(self) {
        self.prefetchURLs = nil;
        self.skippedCount = 0;
        self.requestedCount = 0;
        self.finishedCount = 0;
    }
=======
    self.prefetchURLs = nil;
    self.skippedCount = 0;
    self.requestedCount = 0;
    self.finishedCount = 0;
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
    [self.manager cancelAll];
}

@end
