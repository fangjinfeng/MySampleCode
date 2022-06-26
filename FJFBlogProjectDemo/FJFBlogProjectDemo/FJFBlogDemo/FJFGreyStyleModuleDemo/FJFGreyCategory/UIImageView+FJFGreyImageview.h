//
//  UIWebView+Gray.h
//
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (FJFGreyImageview)
// 开启 黑白色
+ (void)fjf_startGreyStyle;

// 转换为灰度图标
- (void)fjf_convertToGrayImageWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
