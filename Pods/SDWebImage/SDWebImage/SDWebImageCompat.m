<<<<<<< HEAD
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompat.h"
#import "UIImage+MultiFormat.h"

#if !__has_feature(objc_arc)
    #error SDWebImage is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

#if !OS_OBJECT_USE_OBJC
    #error SDWebImage need ARC for dispatch object
#endif

inline UIImage *SDScaledImageForKey(NSString * _Nullable key, UIImage * _Nullable image) {
=======
//
//  SDWebImageCompat.m
//  SDWebImage
//
//  Created by Olivier Poitrey on 11/12/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SDWebImageCompat.h"

#if !__has_feature(objc_arc)
#error SDWebImage is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

inline UIImage *SDScaledImageForKey(NSString *key, UIImage *image) {
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
    if (!image) {
        return nil;
    }
    
<<<<<<< HEAD
#if SD_MAC
    return image;
#elif SD_UIKIT || SD_WATCH
    if ((image.images).count > 0) {
        NSMutableArray<UIImage *> *scaledImages = [NSMutableArray array];
=======
    if ([image.images count] > 0) {
        NSMutableArray *scaledImages = [NSMutableArray array];
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

        for (UIImage *tempImage in image.images) {
            [scaledImages addObject:SDScaledImageForKey(key, tempImage)];
        }
<<<<<<< HEAD
        
        UIImage *animatedImage = [UIImage animatedImageWithImages:scaledImages duration:image.duration];
        if (animatedImage) {
            animatedImage.sd_imageLoopCount = image.sd_imageLoopCount;
            animatedImage.sd_imageFormat = image.sd_imageFormat;
        }
        return animatedImage;
    } else {
#if SD_WATCH
        if ([[WKInterfaceDevice currentDevice] respondsToSelector:@selector(screenScale)]) {
#elif SD_UIKIT
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
#endif
=======

        return [UIImage animatedImageWithImages:scaledImages duration:image.duration];
    }
    else {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
            CGFloat scale = 1;
            if (key.length >= 8) {
                NSRange range = [key rangeOfString:@"@2x."];
                if (range.location != NSNotFound) {
                    scale = 2.0;
                }
                
                range = [key rangeOfString:@"@3x."];
                if (range.location != NSNotFound) {
                    scale = 3.0;
                }
            }
<<<<<<< HEAD
            
            if (scale != image.scale) {
                UIImage *scaledImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
                scaledImage.sd_imageFormat = image.sd_imageFormat;
                image = scaledImage;
            }
        }
        return image;
    }
#endif
=======

            UIImage *scaledImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
            image = scaledImage;
        }
        return image;
    }
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
}

NSString *const SDWebImageErrorDomain = @"SDWebImageErrorDomain";
