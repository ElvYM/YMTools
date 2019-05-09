<<<<<<< HEAD
<p align="center">
  <img src="SDWebImage_logo.png" title="SDWebImage logo" float=left>
</p>


[![Build Status](http://img.shields.io/travis/SDWebImage/SDWebImage/master.svg?style=flat)](https://travis-ci.org/SDWebImage/SDWebImage)
[![Pod Version](http://img.shields.io/cocoapods/v/SDWebImage.svg?style=flat)](http://cocoadocs.org/docsets/SDWebImage/)
[![Pod Platform](http://img.shields.io/cocoapods/p/SDWebImage.svg?style=flat)](http://cocoadocs.org/docsets/SDWebImage/)
[![Pod License](http://img.shields.io/cocoapods/l/SDWebImage.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/SDWebImage/SDWebImage)
[![codecov](https://codecov.io/gh/SDWebImage/SDWebImage/branch/master/graph/badge.svg)](https://codecov.io/gh/SDWebImage/SDWebImage)

This library provides an async image downloader with cache support. For convenience, we added categories for UI elements like `UIImageView`, `UIButton`, `MKAnnotationView`.

## Features

- [x] Categories for `UIImageView`, `UIButton`, `MKAnnotationView` adding web image and cache management
- [x] An asynchronous image downloader
- [x] An asynchronous memory + disk image caching with automatic cache expiration handling
- [x] A background image decompression
- [x] A guarantee that the same URL won't be downloaded several times
- [x] A guarantee that bogus URLs won't be retried again and again
- [x] A guarantee that main thread will never be blocked
- [x] Performances!
- [x] Use GCD and ARC

## Supported Image Formats

- Image formats supported by UIImage (JPEG, PNG, ...), including GIF
- WebP format, including animated WebP (use the `WebP` subspec)
- Support extendable coder plugins for new image formats. Like APNG, BPG, HFIF, SVG, etc. See all the list in [Image coder plugin List](https://github.com/SDWebImage/SDWebImage/wiki/Coder-Plugin-List)

## Beta version

SDWebImage's 5.0 version is nearing completion. Which introduce many new features like Animated ImageView and Transformer. We also provide a more modularized design used for advanced user customization.

You can check the latest [5.x branch](https://github.com/SDWebImage/SDWebImage/tree/5.x) to know about the current status. We'd love you to have a try with the beta version and provide any feedback. If you'd love, check [SDWebImage 5.0 Migration Guide](https://github.com/SDWebImage/SDWebImage/wiki/5.0-Migration-guide) and prepare for the migration.

## Requirements

- iOS 7.0 or later
- tvOS 9.0 or later
- watchOS 2.0 or later
- macOS 10.9 or later
- Xcode 7.3 or later

#### Backwards compatibility

- For iOS 5 and 6, use [any 3.x version up to 3.7.6](https://github.com/SDWebImage/SDWebImage/tree/3.7.6)
- For iOS < 5.0, please use the last [2.0 version](https://github.com/SDWebImage/SDWebImage/tree/2.0-compat).

## Getting Started

- Read this Readme doc
- Read the [How to use section](https://github.com/SDWebImage/SDWebImage#how-to-use)
- Read the [Documentation @ CocoaDocs](http://cocoadocs.org/docsets/SDWebImage/)
- Try the example by downloading the project from Github or even easier using CocoaPods try `pod try SDWebImage`
- Read the [Installation Guide](https://github.com/SDWebImage/SDWebImage/wiki/Installation-Guide)
- Read the [SDWebImage 4.0 Migration Guide](Docs/SDWebImage-4.0-Migration-guide.md) to get an idea of the changes from 3.x to 4.x
- Read the [Common Problems](https://github.com/SDWebImage/SDWebImage/wiki/Common-Problems) to find the solution for common problems 
- Go to the [Wiki Page](https://github.com/SDWebImage/SDWebImage/wiki) for more information such as [Advanced Usage](https://github.com/SDWebImage/SDWebImage/wiki/Advanced-Usage)

## Who Uses It
- Find out [who uses SDWebImage](https://github.com/SDWebImage/SDWebImage/wiki/Who-Uses-SDWebImage) and add your app to the list.

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/sdwebimage). (Tag 'sdwebimage')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/sdwebimage).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## How To Use

* Objective-C

```objective-c
#import <SDWebImage/UIImageView+WebCache.h>
...
[imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
```

* Swift

```swift
import SDWebImage

imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
```

- For details about how to use the library and clear examples, see [The detailed How to use](Docs/HowToUse.md)

## Animated Images (GIF) support

- Starting with the 4.0 version, we rely on [FLAnimatedImage](https://github.com/Flipboard/FLAnimatedImage) to take care of our animated images. 
- If you use cocoapods, add `pod 'SDWebImage/GIF'` to your podfile.
- To use it, simply make sure you use `FLAnimatedImageView` instead of `UIImageView`.
- **Note**: there is a backwards compatible feature, so if you are still trying to load a GIF into a `UIImageView`, it will only show the 1st frame as a static image by default. However, you can enable the full GIF support by using the built-in GIF coder. See [GIF coder](https://github.com/SDWebImage/SDWebImage/wiki/Advanced-Usage#gif-coder)
- **Important**: FLAnimatedImage only works on the iOS platform. For macOS, use `NSImageView` with `animates` set to `YES` to show the entire animated images and `NO` to only show the 1st frame. For all the other platforms (tvOS, watchOS) we will fallback to the backwards compatibility feature described above 

## Installation

There are three ways to use SDWebImage in your project:
- using CocoaPods
- using Carthage
- by cloning the project into your repository

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
platform :ios, '7.0'
pod 'SDWebImage', '~> 4.0'
```

##### Swift and static framework

Swift project previously have to use `use_frameworks!` to make all Pods into dynamic framework to let CocoaPods works.

However, start with `CocoaPods 1.5.0+` (with `Xcode 9+`), which supports to build both Objective-C && Swift code into static framework. You can use modular headers to use SDWebImage as static framework, without the need of `use_frameworks!`:

```
platform :ios, '8.0'
# Uncomment the next line when you want all Pods as static framework
# use_modular_headers!
pod 'SDWebImage', :modular_headers => true
```

See more on [CocoaPods 1.5.0 — Swift Static Libraries](http://blog.cocoapods.org/CocoaPods-1.5.0/)

If not, you still need to add `use_frameworks!` to use SDWebImage as dynamic framework:

```
platform :ios, '8.0'
use_frameworks!
pod 'SDWebImage'
=======
Web Image
=========
[![Build Status](http://img.shields.io/travis/rs/SDWebImage/master.svg?style=flat)](https://travis-ci.org/rs/SDWebImage)
[![Pod Version](http://img.shields.io/cocoapods/v/SDWebImage.svg?style=flat)](http://cocoadocs.org/docsets/SDWebImage/)
[![Pod Platform](http://img.shields.io/cocoapods/p/SDWebImage.svg?style=flat)](http://cocoadocs.org/docsets/SDWebImage/)
[![Pod License](http://img.shields.io/cocoapods/l/SDWebImage.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Dependency Status](https://www.versioneye.com/objective-c/sdwebimage/3.3/badge.svg?style=flat)](https://www.versioneye.com/objective-c/sdwebimage/3.3)
[![Reference Status](https://www.versioneye.com/objective-c/sdwebimage/reference_badge.svg?style=flat)](https://www.versioneye.com/objective-c/sdwebimage/references)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/rs/SDWebImage)

This library provides a category for UIImageView with support for remote images coming from the web.

It provides:

- An `UIImageView` category adding web image and cache management to the Cocoa Touch framework
- An asynchronous image downloader
- An asynchronous memory + disk image caching with automatic cache expiration handling
- Animated GIF support
- WebP format support
- A background image decompression
- A guarantee that the same URL won't be downloaded several times
- A guarantee that bogus URLs won't be retried again and again
- A guarantee that main thread will never be blocked
- Performances!
- Use GCD and ARC
- Arm64 support

NOTE: The version 3.0 of SDWebImage isn't fully backward compatible with 2.0 and requires iOS 5.1.1
minimum deployment version. If you need iOS < 5.0 support, please use the last [2.0 version](https://github.com/rs/SDWebImage/tree/2.0-compat).

[How is SDWebImage better than X?](https://github.com/rs/SDWebImage/wiki/How-is-SDWebImage-better-than-X%3F)

Who Uses It
----------

Find out [who uses SDWebImage](https://github.com/rs/SDWebImage/wiki/Who-Uses-SDWebImage) and add your app to the list.

How To Use
----------

API documentation is available at [CocoaDocs - SDWebImage](http://cocoadocs.org/docsets/SDWebImage/)

### Using UIImageView+WebCache category with UITableView

Just #import the UIImageView+WebCache.h header, and call the sd_setImageWithURL:placeholderImage:
method from the tableView:cellForRowAtIndexPath: UITableViewDataSource method. Everything will be
handled for you, from async downloads to caching management.

```objective-c
#import <SDWebImage/UIImageView+WebCache.h>

...

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] autorelease];
    }

    // Here we use the new provided sd_setImageWithURL: method to load the web image
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    cell.textLabel.text = @"My Text";
    return cell;
}
```

### Using blocks

With blocks, you can be notified about the image download progress and whenever the image retrieval
has completed with success or not:

```objective-c
// Here we use the new provided sd_setImageWithURL: method to load the web image
[cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                ... completion code here ...
                             }];
```

Note: neither your success nor failure block will be call if your image request is canceled before completion.

### Using SDWebImageManager

The SDWebImageManager is the class behind the UIImageView+WebCache category. It ties the
asynchronous downloader with the image cache store. You can use this class directly to benefit
from web image downloading with caching in another context than a UIView (ie: with Cocoa).

Here is a simple example of how to use SDWebImageManager:

```objective-c
SDWebImageManager *manager = [SDWebImageManager sharedManager];
[manager downloadImageWithURL:imageURL
                      options:0
                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                         // progression tracking code
                     }
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                         if (image) {
                             // do something with image
                         }
                     }];
```

### Using Asynchronous Image Downloader Independently

It's also possible to use the async image downloader independently:

```objective-c
SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
[downloader downloadImageWithURL:imageURL
                         options:0
                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            // progression tracking code
                        }
                       completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                            if (image && finished) {
                                // do something with image
                            }
                        }];
```

### Using Asynchronous Image Caching Independently

It is also possible to use the async based image cache store independently. SDImageCache
maintains a memory cache and an optional disk cache. Disk cache write operations are performed
asynchronous so it doesn't add unnecessary latency to the UI.

The SDImageCache class provides a singleton instance for convenience but you can create your own
instance if you want to create separated cache namespace.

To lookup the cache, you use the `queryDiskCacheForKey:done:` method. If the method returns nil, it means the cache
doesn't currently own the image. You are thus responsible for generating and caching it. The cache
key is an application unique identifier for the image to cache. It is generally the absolute URL of
the image.

```objective-c
SDImageCache *imageCache = [[SDImageCache alloc] initWithNamespace:@"myNamespace"];
[imageCache queryDiskCacheForKey:myCacheKey done:^(UIImage *image) {
    // image is not nil if image was found
}];
```

By default SDImageCache will lookup the disk cache if an image can't be found in the memory cache.
You can prevent this from happening by calling the alternative method `imageFromMemoryCacheForKey:`.

To store an image into the cache, you use the storeImage:forKey: method:

```objective-c
[[SDImageCache sharedImageCache] storeImage:myImage forKey:myCacheKey];
```

By default, the image will be stored in memory cache as well as on disk cache (asynchronously). If
you want only the memory cache, use the alternative method storeImage:forKey:toDisk: with a negative
third argument.

### Using cache key filter

Sometime, you may not want to use the image URL as cache key because part of the URL is dynamic
(i.e.: for access control purpose). SDWebImageManager provides a way to set a cache key filter that
takes the NSURL as input, and output a cache key NSString.

The following example sets a filter in the application delegate that will remove any query-string from
the URL before to use it as a cache key:

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SDWebImageManager.sharedManager.cacheKeyFilter = ^(NSURL *url) {
        url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
        return [url absoluteString];
    };

    // Your app init code...
    return YES;
}
```


Common Problems
---------------

### Using dynamic image size with UITableViewCell

UITableView determines the size of the image by the first image set for a cell. If your remote images
don't have the same size as your placeholder image, you may experience strange anamorphic scaling issue.
The following article gives a way to workaround this issue:

[http://www.wrichards.com/blog/2011/11/sdwebimage-fixed-width-cell-images/](http://www.wrichards.com/blog/2011/11/sdwebimage-fixed-width-cell-images/)


### Handle image refresh

SDWebImage does very aggressive caching by default. It ignores all kind of caching control header returned by the HTTP server and cache the returned images with no time restriction. It implies your images URLs are static URLs pointing to images that never change. If the pointed image happen to change, some parts of the URL should change accordingly.

If you don't control the image server you're using, you may not be able to change the URL when its content is updated. This is the case for Facebook avatar URLs for instance. In such case, you may use the `SDWebImageRefreshCached` flag. This will slightly degrade the performance but will respect the HTTP caching control headers:

``` objective-c
[imageView sd_setImageWithURL:[NSURL URLWithString:@"https://graph.facebook.com/olivier.poitrey/picture"]
                 placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
                          options:SDWebImageRefreshCached];
```

### Add a progress indicator

See this category: https://github.com/JJSaccolo/UIActivityIndicator-for-SDWebImage

Installation
------------

There are three ways to use SDWebImage in your project:
- using CocoaPods
- copying all the files into your project
- importing the project as a static library

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
platform :ios, '6.1'
pod 'SDWebImage', '~>3.7'
```

If you are using Swift, be sure to add `use_frameworks!` and set your target to iOS 8+:
```
platform :ios, '8.0'
use_frameworks!
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
```

#### Subspecs

<<<<<<< HEAD
There are 4 subspecs available now: `Core`, `MapKit`, `GIF` and `WebP` (this means you can install only some of the SDWebImage modules. By default, you get just `Core`, so if you need `WebP`, you need to specify it). 
=======
There are 3 subspecs available now: `Core`, `MapKit` and `WebP` (this means you can install only some of the SDWebImage modules. By default, you get just `Core`, so if you need `WebP`, you need to specify it). 
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

Podfile example:
```
pod 'SDWebImage/WebP'
```

### Installation with Carthage (iOS 8+)

[Carthage](https://github.com/Carthage/Carthage) is a lightweight dependency manager for Swift and Objective-C. It leverages CocoaTouch modules and is less invasive than CocoaPods.

To install with carthage, follow the instruction on [Carthage](https://github.com/Carthage/Carthage)

#### Cartfile
```
<<<<<<< HEAD
github "SDWebImage/SDWebImage"
```

### Installation by cloning the repository
- see [Manual install](Docs/ManualInstallation.md)
=======
github "rs/SDWebImage"
```

#### Usage
Swift

If you installed using CocoaPods:
```
import SDWebImage
```

If you installed manually:
```
import WebImage
```

Objective-C

```
@import WebImage;
```

### Installation by cloning the repository

In order to gain access to all the files from the repository, you should clone it.
```
git clone --recursive https://github.com/rs/SDWebImage.git
```

### Add the SDWebImage project to your project

- Download and unzip the last version of the framework from the [download page](https://github.com/rs/SDWebImage/releases)
- Right-click on the project navigator and select "Add Files to "Your Project":
- In the dialog, select SDWebImage.framework:
- Check the "Copy items into destination group's folder (if needed)" checkbox

### Add dependencies

- In you application project app’s target settings, find the "Build Phases" section and open the "Link Binary With Libraries" block:
- Click the "+" button again and select the "ImageIO.framework", this is needed by the progressive download feature:

### Add Linker Flag

Open the "Build Settings" tab, in the "Linking" section, locate the "Other Linker Flags" setting and add the "-ObjC" flag:

![Other Linker Flags](http://dl.dropbox.com/u/123346/SDWebImage/10_other_linker_flags.jpg)

Alternatively, if this causes compilation problems with frameworks that extend optional libraries, such as Parse,  RestKit or opencv2, instead of the -ObjC flag use:
```
-force_load SDWebImage.framework/Versions/Current/SDWebImage
```

If you're using Cocoa Pods and have any frameworks that extend optional libraries, such as Parsen RestKit or opencv2, instead of the -ObjC flag use:
```
-force_load $(TARGET_BUILD_DIR)/libPods.a
```
and this:
```
$(inherited)
```
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334

### Import headers in your source files

In the source files where you need to use the library, import the header file:

```objective-c
#import <SDWebImage/UIImageView+WebCache.h>
```

### Build Project

At this point your workspace should build without error. If you are having problem, post to the Issue and the
community can help you solve it.

<<<<<<< HEAD
## Author
- [Olivier Poitrey](https://github.com/rs)

## Collaborators
- [Konstantinos K.](https://github.com/mythodeia)
- [Bogdan Poplauschi](https://github.com/bpoplauschi)
- [Chester Liu](https://github.com/skyline75489)
- [DreamPiggy](https://github.com/dreampiggy)
- [Wu Zhong](https://github.com/zhongwuzw)

## Licenses

All source code is licensed under the [MIT License](https://raw.github.com/SDWebImage/SDWebImage/master/LICENSE).

## Architecture

<p align="center">
    <img src="Docs/SDWebImageClassDiagram.png" title="SDWebImage class diagram">
</p>

<p align="center">
    <img src="Docs/SDWebImageSequenceDiagram.png" title="SDWebImage sequence diagram">
</p>


=======
Future Enhancements
-------------------

- LRU memory cache cleanup instead of reset on memory warning

## Licenses

All source code is licensed under the [MIT License](https://raw.github.com/rs/SDWebImage/master/LICENSE).
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
