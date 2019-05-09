/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Jamie Pinkham
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <TargetConditionals.h>

#ifdef __OBJC_GC__
<<<<<<< HEAD
    #error SDWebImage does not support Objective-C Garbage Collection
#endif

// Apple's defines from TargetConditionals.h are a bit weird.
// Seems like TARGET_OS_MAC is always defined (on all platforms).
// To determine if we are running on OSX, we can only rely on TARGET_OS_IPHONE=0 and all the other platforms
#if !TARGET_OS_IPHONE && !TARGET_OS_IOS && !TARGET_OS_TV && !TARGET_OS_WATCH
    #define SD_MAC 1
#else
    #define SD_MAC 0
#endif

// iOS and tvOS are very similar, UIKit exists on both platforms
// Note: watchOS also has UIKit, but it's very limited
#if TARGET_OS_IOS || TARGET_OS_TV
    #define SD_UIKIT 1
#else
    #define SD_UIKIT 0
#endif

#if TARGET_OS_IOS
    #define SD_IOS 1
#else
    #define SD_IOS 0
#endif

#if TARGET_OS_TV
    #define SD_TV 1
#else
    #define SD_TV 0
#endif

#if TARGET_OS_WATCH
    #define SD_WATCH 1
#else
    #define SD_WATCH 0
#endif


#if SD_MAC
    #import <AppKit/AppKit.h>
    #ifndef UIImage
        #define UIImage NSImage
    #endif
    #ifndef UIImageView
        #define UIImageView NSImageView
    #endif
    #ifndef UIView
        #define UIView NSView
    #endif
#else
    #if __IPHONE_OS_VERSION_MIN_REQUIRED != 20000 && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_5_0
        #error SDWebImage doesn't support Deployment Target version < 5.0
    #endif

    #if SD_UIKIT
        #import <UIKit/UIKit.h>
    #endif
    #if SD_WATCH
        #import <WatchKit/WatchKit.h>
        #ifndef UIView
            #define UIView WKInterfaceObject
        #endif
        #ifndef UIImageView
            #define UIImageView WKInterfaceImage
        #endif
    #endif
=======
#error SDWebImage does not support Objective-C Garbage Collection
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED != 20000 && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_5_0
#error SDWebImage doesn't support Deployment Target version < 5.0
#endif

#if !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>
#ifndef UIImage
#define UIImage NSImage
#endif
#ifndef UIImageView
#define UIImageView NSImageView
#endif
#else

#import <UIKit/UIKit.h>

>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
#endif

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#ifndef NS_OPTIONS
#define NS_OPTIONS(_type, _name) enum _name : _type _name; enum _name : _type
#endif

<<<<<<< HEAD
FOUNDATION_EXPORT UIImage *SDScaledImageForKey(NSString *key, UIImage *image);

typedef void(^SDWebImageNoParamsBlock)(void);

FOUNDATION_EXPORT NSString *const SDWebImageErrorDomain;

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
        block();\
    } else {\
        dispatch_async(queue, block);\
    }
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif
=======
#if OS_OBJECT_USE_OBJC
    #undef SDDispatchQueueRelease
    #undef SDDispatchQueueSetterSementics
    #define SDDispatchQueueRelease(q)
    #define SDDispatchQueueSetterSementics strong
#else
#undef SDDispatchQueueRelease
#undef SDDispatchQueueSetterSementics
#define SDDispatchQueueRelease(q) (dispatch_release(q))
#define SDDispatchQueueSetterSementics assign
#endif

extern UIImage *SDScaledImageForKey(NSString *key, UIImage *image);

typedef void(^SDWebImageNoParamsBlock)();

extern NSString *const SDWebImageErrorDomain;

#define dispatch_main_sync_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }

#define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
