//
//  UIColor+GrayColor.h
//
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FJFGreyColor)
// 开启 黑白色
+ (void)fjf_startGreyStyle;
// 生成 灰色 
+ (UIColor *)fjf_generateGrayColorWithOriginalColor:(UIColor *)originalColor;
/// 生成 灰色 富文本 字体
+ (NSAttributedString *)fjf_getGreyAttributedTextWithTextColor:(UIColor *)textColor
                                                 attributeText:(NSAttributedString *)attributedText;
@end

NS_ASSUME_NONNULL_END
