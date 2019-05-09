<<<<<<< HEAD
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImage+MultiFormat.h"
#import "NSImage+WebCache.h"
#import "SDWebImageCodersManager.h"
#import "objc/runtime.h"

@implementation UIImage (MultiFormat)

#if SD_MAC
- (NSUInteger)sd_imageLoopCount {
    NSUInteger imageLoopCount = 0;
    for (NSImageRep *rep in self.representations) {
        if ([rep isKindOfClass:[NSBitmapImageRep class]]) {
            NSBitmapImageRep *bitmapRep = (NSBitmapImageRep *)rep;
            imageLoopCount = [[bitmapRep valueForProperty:NSImageLoopCount] unsignedIntegerValue];
            break;
        }
    }
    return imageLoopCount;
}

- (void)setSd_imageLoopCount:(NSUInteger)sd_imageLoopCount {
    for (NSImageRep *rep in self.representations) {
        if ([rep isKindOfClass:[NSBitmapImageRep class]]) {
            NSBitmapImageRep *bitmapRep = (NSBitmapImageRep *)rep;
            [bitmapRep setProperty:NSImageLoopCount withValue:@(sd_imageLoopCount)];
            break;
        }
    }
}

#else

- (NSUInteger)sd_imageLoopCount {
    NSUInteger imageLoopCount = 0;
    NSNumber *value = objc_getAssociatedObject(self, @selector(sd_imageLoopCount));
    if ([value isKindOfClass:[NSNumber class]]) {
        imageLoopCount = value.unsignedIntegerValue;
    }
    return imageLoopCount;
}

- (void)setSd_imageLoopCount:(NSUInteger)sd_imageLoopCount {
    NSNumber *value = @(sd_imageLoopCount);
    objc_setAssociatedObject(self, @selector(sd_imageLoopCount), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#endif

- (SDImageFormat)sd_imageFormat {
    SDImageFormat imageFormat = SDImageFormatUndefined;
    NSNumber *value = objc_getAssociatedObject(self, @selector(sd_imageFormat));
    if ([value isKindOfClass:[NSNumber class]]) {
        imageFormat = value.integerValue;
        return imageFormat;
    }
    // Check CGImage's UTType, may return nil for non-Image/IO based image
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
    if (&CGImageGetUTType != NULL) {
        CFStringRef uttype = CGImageGetUTType(self.CGImage);
        imageFormat = [NSData sd_imageFormatFromUTType:uttype];
    }
#pragma clang diagnostic pop
    return imageFormat;
}

- (void)setSd_imageFormat:(SDImageFormat)sd_imageFormat {
    objc_setAssociatedObject(self, @selector(sd_imageFormat), @(sd_imageFormat), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (nullable UIImage *)sd_imageWithData:(nullable NSData *)data {
    return [[SDWebImageCodersManager sharedInstance] decodedImageWithData:data];
}

- (nullable NSData *)sd_imageData {
    return [self sd_imageDataAsFormat:SDImageFormatUndefined];
}

- (nullable NSData *)sd_imageDataAsFormat:(SDImageFormat)imageFormat {
    NSData *imageData = nil;
    if (self) {
        imageData = [[SDWebImageCodersManager sharedInstance] encodedDataWithImage:self format:imageFormat];
    }
    return imageData;
}


=======
//
//  UIImage+MultiFormat.m
//  SDWebImage
//
//  Created by Olivier Poitrey on 07/06/13.
//  Copyright (c) 2013 Dailymotion. All rights reserved.
//

#import "UIImage+MultiFormat.h"
#import "UIImage+GIF.h"
#import "NSData+ImageContentType.h"
#import <ImageIO/ImageIO.h>

#ifdef SD_WEBP
#import "UIImage+WebP.h"
#endif

@implementation UIImage (MultiFormat)

+ (UIImage *)sd_imageWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    UIImage *image;
    NSString *imageContentType = [NSData sd_contentTypeForImageData:data];
    if ([imageContentType isEqualToString:@"image/gif"]) {
        image = [UIImage sd_animatedGIFWithData:data];
    }
#ifdef SD_WEBP
    else if ([imageContentType isEqualToString:@"image/webp"])
    {
        image = [UIImage sd_imageWithWebPData:data];
    }
#endif
    else {
        image = [[UIImage alloc] initWithData:data];
        UIImageOrientation orientation = [self sd_imageOrientationFromImageData:data];
        if (orientation != UIImageOrientationUp) {
            image = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:orientation];
        }
    }


    return image;
}


+(UIImageOrientation)sd_imageOrientationFromImageData:(NSData *)imageData {
    UIImageOrientation result = UIImageOrientationUp;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    if (imageSource) {
        CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
        if (properties) {
            CFTypeRef val;
            int exifOrientation;
            val = CFDictionaryGetValue(properties, kCGImagePropertyOrientation);
            if (val) {
                CFNumberGetValue(val, kCFNumberIntType, &exifOrientation);
                result = [self sd_exifOrientationToiOSOrientation:exifOrientation];
            } // else - if it's not set it remains at up
            CFRelease((CFTypeRef) properties);
        } else {
            //NSLog(@"NO PROPERTIES, FAIL");
        }
        CFRelease(imageSource);
    }
    return result;
}

#pragma mark EXIF orientation tag converter
// Convert an EXIF image orientation to an iOS one.
// reference see here: http://sylvana.net/jpegcrop/exif_orientation.html
+ (UIImageOrientation) sd_exifOrientationToiOSOrientation:(int)exifOrientation {
    UIImageOrientation orientation = UIImageOrientationUp;
    switch (exifOrientation) {
        case 1:
            orientation = UIImageOrientationUp;
            break;

        case 3:
            orientation = UIImageOrientationDown;
            break;

        case 8:
            orientation = UIImageOrientationLeft;
            break;

        case 6:
            orientation = UIImageOrientationRight;
            break;

        case 2:
            orientation = UIImageOrientationUpMirrored;
            break;

        case 4:
            orientation = UIImageOrientationDownMirrored;
            break;

        case 5:
            orientation = UIImageOrientationLeftMirrored;
            break;

        case 7:
            orientation = UIImageOrientationRightMirrored;
            break;
        default:
            break;
    }
    return orientation;
}



>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
@end
