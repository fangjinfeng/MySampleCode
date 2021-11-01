//
//  UIImage+DownSample.m
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/9/18.
//  Copyright © 2021 fjf. All rights reserved.
//

#import <Photos/Photos.h>
#import "UIImage+DownSample.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UIImage (DownSample)

+ (UIImage *)downSamplingWithScale:(CGFloat)scale
                           imgData:(NSData *)imgData
                        targetSize:(CGSize)targetSize {

    //避免下次产生缩略图时大小不同，但被缓存了，取出来是缓存图片
    //所以要把kCGImageSourceShouldCache设为false
    CFStringRef key[1];
    key[0] = kCGImageSourceShouldCache;
    CFTypeRef value[1];
    value[0] = (CFTypeRef)kCFBooleanFalse;

    CFDictionaryRef imageSourceOption = CFDictionaryCreate(NULL,
                                                           (const void **) key,
                                                           (const void **) value,
                                                           1,
                                                           &kCFTypeDictionaryKeyCallBacks,
                                                           &kCFTypeDictionaryValueCallBacks);
    
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imgData, imageSourceOption);

    return [UIImage downSamplingWithScale:scale targetSize:targetSize imageSource:imageSource];
}



+ (UIImage *)downSamplingWithScale:(CGFloat)scale
                            imgUrl:(NSURL *)imgURL
                        targetSize:(CGSize)targetSize {

    //避免下次产生缩略图时大小不同，但被缓存了，取出来是缓存图片
    //所以要把kCGImageSourceShouldCache设为false
    CFStringRef key[1];
    key[0] = kCGImageSourceShouldCache;
    CFTypeRef value[1];
    value[0] = (CFTypeRef)kCFBooleanFalse;

    CFDictionaryRef imageSourceOption = CFDictionaryCreate(NULL,
                                                           (const void **) key,
                                                           (const void **) value,
                                                           1,
                                                           &kCFTypeDictionaryKeyCallBacks,
                                                           &kCFTypeDictionaryValueCallBacks);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)imgURL, imageSourceOption);

    return [UIImage downSamplingWithScale:scale targetSize:targetSize imageSource:imageSource];
}

+ (UIImage *)downSamplingWithScale:(CGFloat)scale
                        targetSize:(CGSize)targetSize
                       imageSource:(CGImageSourceRef)imageSource {
    

    CFMutableDictionaryRef mutOption = CFDictionaryCreateMutable(NULL,
                                                                 4,
                                                                 &kCFTypeDictionaryKeyCallBacks,
                                                                 &kCFTypeDictionaryValueCallBacks);


    CGFloat maxDimension = MAX(targetSize.width, targetSize.height) * scale;
    NSNumber *maxDimensionNum = [NSNumber numberWithFloat:maxDimension];

    // · kCGImageSourceCreateThumbnailFromImageAlways
    //这个选项控制是否生成缩略图（没有设为true的话 kCGImageSourceThumbnailMaxPixelSize 以及 CGImageSourceCreateThumbnailAtIndex不会起作用）默认为false，所以需要设置为true
    CFDictionaryAddValue(mutOption, kCGImageSourceCreateThumbnailFromImageAlways, kCFBooleanTrue);//

    // · kCGImageSourceShouldCacheImmediately
    // 是否在创建图片时就进行解码（当然要这么做，避免在渲染时解码占用cpu）并缓存，
    /* Specifies whether image decoding and caching should happen at image creation time.
    * The value of this key must be a CFBooleanRef. The default value is kCFBooleanFalse (image decoding will
    * happen at rendering time). //默认为不缓存，在图片渲染时进行图片解码
    */
    CFDictionaryAddValue(mutOption, kCGImageSourceShouldCacheImmediately, kCFBooleanTrue);

    // · kCGImageSourceCreateThumbnailWithTransform
    //指定是否应根据完整图像的方向和像素纵横比旋转和缩放缩略图
    /* Specifies whether the thumbnail should be rotated and scaled according
     * to the orientation and pixel aspect ratio of the full image.（默认为false
     */
    //要设为true，因为我们要缩小他！
    CFDictionaryAddValue(mutOption, kCGImageSourceCreateThumbnailWithTransform, kCFBooleanTrue);


    // · kCGImageSourceThumbnailMaxPixelSize
    /* Specifies the maximum width and height in pixels of a thumbnail.  If
     * this this key is not specified, the width and height of a thumbnail is
     * not limited and thumbnails may be as big as the image itself.  If
     * present, this value of this key must be a CFNumberRef. */
    //指定缩略图的宽（如果缩略图的高大于宽，那就是高，那个更大填哪个）

    //这里我猜测生成的是一个矩形（划重点，我猜的，我猜的，我猜的，请自行论证）
    //画丑了，总之下面是两个正方形！
    /*           高更大            宽更大
                ________          _______
               |  \\\\  |   or   |       |
               |  \\\\  |        |\\\\\\\|
               |  \\\\  |        |       |
                --------          -------
     */

    CFDictionaryAddValue(mutOption, kCGImageSourceThumbnailMaxPixelSize, (__bridge CFNumberRef)maxDimensionNum);

    CFDictionaryRef dowsamplingOption = CFDictionaryCreateCopy(NULL, mutOption);


    //生成缩略图
    CGImageRef rf = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, dowsamplingOption);
    //用UIImage把他装起来，返回
    UIImage *img = [UIImage imageWithCGImage:rf];
    return img;
}

// 获取 缩放后的尺寸
+ (CGSize)imageSizeWidthTargetWidth:(CGFloat)targetWidth
                       originalSize:(CGSize)originalSize{
 
    CGFloat width = originalSize.width;
    CGFloat height = originalSize.height;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
 
    if(CGSizeEqualToSize(originalSize, targetSize) == NO){
 
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
 
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        targetWidth = width * scaleFactor;
        targetHeight = height * scaleFactor;
    }
 
    return CGSizeMake(targetWidth, targetHeight);
}
@end
