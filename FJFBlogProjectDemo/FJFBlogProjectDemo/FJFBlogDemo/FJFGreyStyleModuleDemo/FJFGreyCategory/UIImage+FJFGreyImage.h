//
//  UIWebView+Gray.h


#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FJFGreyImage)
// 开启 黑白色
+ (void)fjf_startGreyStyle;
// 转化灰度图片
- (UIImage *)fjf_convertToGrayImage;
@end

NS_ASSUME_NONNULL_END
