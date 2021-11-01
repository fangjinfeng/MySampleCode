//
//  UIImageView+SDImage.h
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/10/9.
//  Copyright © 2021 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SDImage)

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize;

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                   options:(SDWebImageOptions)options;

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                   options:(SDWebImageOptions)options
                 completed:(nullable SDExternalCompletionBlock)completedBlock;

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                targetSize:(CGSize)targetSize
                   options:(SDWebImageOptions)options
                  progress:(nullable SDImageLoaderProgressBlock)progressBlock
                 completed:(nullable SDExternalCompletionBlock)completedBlock;
@end

NS_ASSUME_NONNULL_END
