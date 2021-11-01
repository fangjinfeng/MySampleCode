//
//  UIImageView+SDImage.m
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/10/9.
//  Copyright © 2021 fjf. All rights reserved.
//

#import "SDWebImage.h"
#import "UIImage+DownSample.h"
#import "UIImageView+SDImage.h"

@implementation UIImageView (SDImage)

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize {
    [self sd_setImageWithURL:url placeholderImage:placeholder targetSize:targetSize options:0];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                   options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder targetSize:targetSize options:options completed:nil];
}


- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                 completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder targetSize:targetSize options:0 completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                   options:(SDWebImageOptions)options
                 completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder targetSize:targetSize options:options progress:nil completed:completedBlock];
}


- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                   options:(SDWebImageOptions)options
                  progress:(nullable SDImageLoaderProgressBlock)progressBlock
                 completed:(nullable SDExternalCompletionBlock)completedBlock {
    
    NSString *imageUrl = url.absoluteString;
    if (!imageUrl.length) {
        return;
    }
    
    NSString *targetImageUrl = [UIImageView sd_targetImageUrlWithImageUrl:imageUrl targetSize:targetSize];
    BOOL isCachedTargetImage = [UIImageView sd_isCachedImageWithImageUrl:imageUrl targetSize:targetSize];
    if (isCachedTargetImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:targetImageUrl] placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
    } else {
        [self sd_setImageWithURL:url placeholderImage:placeholder options:options | SDWebImageAvoidAutoSetImage | SDWebImageAvoidDecodeImage progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if ([UIImageView sd_isNormalImageWithImageUrl:imageUrl]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSString *imagePath = [[SDImageCache sharedImageCache].diskCache cachePathForKey:url.absoluteString];
                    CGSize imageSize = [UIImage imageSizeWidthTargetWidth:targetSize.width originalSize:image.size];
                    UIImage *targetImage = [UIImage downSamplingWithScale:[UIScreen mainScreen].scale imgUrl:[NSURL fileURLWithPath:imagePath] targetSize:imageSize];
                    [[SDImageCache sharedImageCache] storeImage:targetImage forKey:targetImageUrl completion:^{
                        [self sd_setImageWithURL:[NSURL URLWithString:targetImageUrl] placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
                    }];
                });
                
            } else if([UIImageView sd_isGifImageWithImageUrl:imageUrl]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSArray<SDImageFrame *> *animatedImageFrameArray = [SDImageCoderHelper framesFromAnimatedImage:image];
                    NSMutableArray<SDImageFrame *> *tmpThumbImageFrameMarray = [NSMutableArray array];
                    [animatedImageFrameArray enumerateObjectsUsingBlock:^(SDImageFrame * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        CGSize imageSize = [UIImage imageSizeWidthTargetWidth:targetSize.width originalSize:obj.image.size];
                        NSData *imgData = UIImageJPEGRepresentation(obj.image , 0.75);
                        UIImage *targetImage = [UIImage downSamplingWithScale:[UIScreen mainScreen].scale imgData:imgData targetSize:imageSize];
                        SDImageFrame *thumbFrame = [SDImageFrame frameWithImage:targetImage duration:obj.duration];
                        [tmpThumbImageFrameMarray addObject:thumbFrame];
                    }];
                    
                   UIImage *thumbAnimatedImage = [SDImageCoderHelper animatedImageWithFrames:tmpThumbImageFrameMarray];
                    [[SDImageCache sharedImageCache] storeImage:thumbAnimatedImage forKey:targetImageUrl completion:^{
                        [self sd_setImageWithURL:[NSURL URLWithString:targetImageUrl] placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
                    }];
                });
            } else {
                [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
            }
        }];
    }
}

#pragma mark - Private Methods
// 获取 缓存 图片
+ (UIImage *)sd_cacheImageWithImageUrl:(NSString *)imageUrl
                            targetSize:(CGSize)targetSize {
    NSString *targetUrl = [UIImageView sd_targetImageUrlWithImageUrl:imageUrl targetSize:targetSize];
    return [[SDImageCache sharedImageCache] imageFromCacheForKey:targetUrl];
}


+ (BOOL)sd_isCachedImageWithImageUrl:(NSString *)imageUrl
                          targetSize:(CGSize)targetSize {
    NSString *targetUrl = [UIImageView sd_targetImageUrlWithImageUrl:imageUrl targetSize:targetSize];
    return [self sd_isCachedImageWithImageUrl:targetUrl];
}

+ (BOOL)sd_isCachedImageWithImageUrl:(NSString *)imageUrl {
    return [[SDImageCache sharedImageCache].memoryCache objectForKey:imageUrl] || [[SDImageCache sharedImageCache] diskImageDataExistsWithKey:imageUrl];
}

+ (NSString *)sd_targetImageUrlWithImageUrl:(NSString *)imageUrl
                                 targetSize:(CGSize)targetSize {
    NSString *symbol = @"?";
    if ([imageUrl containsString:@"?"]) {
        symbol = @"&";
    }
    return [NSString stringWithFormat:@"%@%@w=%f&h=%f", imageUrl, symbol, targetSize.width, targetSize.height];
}


+ (BOOL)sd_isNormalImageWithImageUrl:(NSString *)imageUrl {
    NSString *imagePath = [[SDImageCache sharedImageCache].diskCache cachePathForKey:imageUrl];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];
    if (imageFormat == SDImageFormatJPEG ||
        imageFormat == SDImageFormatPNG) {
        return YES;
    }
    return NO;
}

+ (BOOL)sd_isGifImageWithImageUrl:(NSString *)imageUrl {
    NSString *imagePath = [[SDImageCache sharedImageCache].diskCache cachePathForKey:imageUrl];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];
    if (imageFormat == SDImageFormatGIF) {
        return YES;
    }
    return NO;
}
@end
