//
//  UIColor+GrayColor.m
//
//  
//
#import <SDWebImage/SDWebImage.h>
#import "UIImageView+FJFGreyImageview.h"
#import "UIImage+FJFGreyImage.h"
#import "NSObject+FJFSwizzle.h"

@implementation UIImageView (FJFGreyImageview)
#pragma mark - Public Methods
+ (void)fjf_startGreyStyle {
    NSError *error = NULL;
    
    [UIImageView fjf_swizzleMethod:@selector(setImage:)
                   withMethod:@selector(fjf_setImage:)
                          error:&error];

    [UIImageView fjf_swizzleMethod:@selector(initWithCoder:)
                       withMethod:@selector(fjf_initWithCoder:)
                            error:&error];
}

#pragma mark - Private Methods
- (nullable instancetype)fjf_initWithCoder:(NSCoder *)coder {
   UIImageView *tmpImgageView = [self fjf_initWithCoder:coder];
    [self fjf_convertToGrayImageWithImage:tmpImgageView.image];
    return tmpImgageView;
}

- (void)fjf_setImage:(UIImage *)image {
    //系统键盘处理（如果不过滤，这系统键盘字母背景是黑色）
    if ([self.superview isKindOfClass:NSClassFromString(@"UIKBSplitImageView")]) {
        [self fjf_setImage:image];
        return;
    }
    [self fjf_convertToGrayImageWithImage:image];
}


// 转换为灰度图标
- (void)fjf_convertToGrayImageWithImage:(UIImage *)image {
    NSArray<SDImageFrame *> *animatedImageFrameArray = [SDImageCoderHelper framesFromAnimatedImage:image];
    if (animatedImageFrameArray.count > 1) {
        NSMutableArray<SDImageFrame *> *tmpThumbImageFrameMarray = [NSMutableArray array];
        [animatedImageFrameArray enumerateObjectsUsingBlock:^(SDImageFrame * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *targetImage = [obj.image fjf_convertToGrayImage];
            SDImageFrame *thumbFrame = [SDImageFrame frameWithImage:targetImage duration:obj.duration];
            [tmpThumbImageFrameMarray addObject:thumbFrame];
        }];
        UIImage *greyAnimatedImage = [SDImageCoderHelper animatedImageWithFrames:tmpThumbImageFrameMarray];
        [self fjf_setImage:greyAnimatedImage];
    } else if([image isKindOfClass:NSClassFromString(@"_UIResizableImage")]){
        [self fjf_setImage:image];
    } else {
        UIImage *im = [image fjf_convertToGrayImage];
        [self fjf_setImage:im];
    }
}


@end
