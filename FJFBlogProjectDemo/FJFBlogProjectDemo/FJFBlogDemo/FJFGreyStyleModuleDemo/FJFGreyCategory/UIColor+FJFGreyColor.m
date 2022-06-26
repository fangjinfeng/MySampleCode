//
//  UIColor+GrayColor.m
//
#import "UIColor+FJFGreyColor.h"
#import "NSObject+FJFSwizzle.h"

@implementation UIColor (FJFGreyColor)
#pragma mark - Public Methods
// 开启 黑白色
+ (void)fjf_startGreyStyle {
    NSError *error = NULL;

    [UIColor fjf_swizzleClassMethod:@selector(redColor)
                   withClassMethod:@selector(fjf_redColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(greenColor)
                   withClassMethod:@selector(fjf_greenColor)
                             error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(blueColor)
                   withClassMethod:@selector(fjf_blueColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(cyanColor)
                   withClassMethod:@selector(fjf_cyanColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(yellowColor)
                   withClassMethod:@selector(fjf_yellowColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(magentaColor)
                   withClassMethod:@selector(fjf_magentaColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(orangeColor)
                   withClassMethod:@selector(fjf_orangeColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(purpleColor)
                   withClassMethod:@selector(fjf_purpleColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(brownColor)
                   withClassMethod:@selector(fjf_brownColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(systemBlueColor)
                   withClassMethod:@selector(fjf_systemBlueColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(systemGreenColor)
                   withClassMethod:@selector(fjf_systemGreenColor)
                          error:&error];
    
    [UIColor fjf_swizzleClassMethod:@selector(colorWithRed:green:blue:alpha:)
                   withClassMethod:@selector(fjf_colorWithRed:green:blue:alpha:)
                          error:&error];

    [UIColor fjf_swizzleMethod:@selector(initWithRed:green:blue:alpha:)
                   withMethod:@selector(fjf_initWithRed:green:blue:alpha:)
                          error:&error];
}

+ (UIColor *)fjf_generateGrayColorWithOriginalColor:(UIColor *)originalColor {
    NSArray <NSNumber *> *colorValueArray = [UIColor fjf_getRGBWithColor:originalColor];
    return [UIColor fjf_generateGrayColorWithColor:originalColor red:colorValueArray[0].floatValue green:colorValueArray[1].floatValue blue:colorValueArray[2].floatValue alpha:colorValueArray[3].floatValue];
}

/// 生成 灰色 富文本 字体
+ (NSAttributedString *)fjf_getGreyAttributedTextWithTextColor:(UIColor *)textColor
                                                attributeText:(NSAttributedString *)attributedText {
  NSMutableAttributedString *tmpMutableAttrText = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
  [tmpMutableAttrText addAttribute:NSForegroundColorAttributeName
                value:[UIColor fjf_generateGrayColorWithOriginalColor:textColor]
           range:NSMakeRange(0, attributedText.string.length)];
  return tmpMutableAttrText;
}

#pragma mark - Private Methods
+ (UIColor *)fjf_redColor {
    // 1.0, 0.0, 0.0 RGB
    UIColor *color = [self fjf_redColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:1.0 green:0.0 blue:0.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_greenColor {
     // 0.0, 1.0, 0.0 RGB
    UIColor *color = [self fjf_greenColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.0 green:1.0 blue:0.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_blueColor {
    //0.0, 0.0, 1.0
    UIColor *color = [self fjf_blueColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.0 green:0.0 blue:1.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_cyanColor {
    // 0.0, 1.0, 1.0
    UIColor *color = [self fjf_cyanColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.0 green:1.0 blue:1.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_yellowColor {
    //1.0, 1.0, 0.0
    UIColor *color = [self fjf_yellowColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:1.0 green:1.0 blue:0.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_magentaColor {
    // 1.0, 0.0, 1.0
    UIColor *color = [self fjf_magentaColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:1.0 green:0.0 blue:1.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_orangeColor {
    // 1.0, 0.5, 0.0
    UIColor *color = [self fjf_orangeColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:1.0 green:0.5 blue:0.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_systemBlueColor {
    UIColor *color = [self fjf_systemBlueColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.0 green:0.0 blue:1.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_systemGreenColor {
    UIColor *color = [self fjf_systemGreenColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.0 green:1.0 blue:0.0 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_purpleColor {
    // 0.5, 0.0, 0.5
    UIColor *color = [self fjf_purpleColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.5 green:0.0 blue:0.5 alpha:1.0];
    return color;
}

+ (UIColor *)fjf_brownColor {
    // 0.6, 0.4, 0.2
    UIColor *color = [self fjf_brownColor];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:0.6 green:0.4 blue:0.2 alpha:1.0];
    return color;
}

- (UIColor *)fjf_initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    if (red == 0 && green == 0 && blue == 0) {
        return [self fjf_initWithRed:red green:green blue:blue alpha:alpha];
    }
    UIColor *greyColor = [UIColor fjf_generateGrayColorWithOriginalColor:[UIColor darkGrayColor] red:red green:green blue:blue alpha:alpha];
    NSArray <NSNumber *> *colorValueArray = [UIColor fjf_getRGBWithColor:greyColor];
    return [self fjf_initWithRed:colorValueArray[0].floatValue green:colorValueArray[1].floatValue blue:colorValueArray[2].floatValue alpha:colorValueArray[3].floatValue];
}

+ (instancetype)fjf_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    UIColor *color = [self fjf_colorWithRed:r green:g blue:b alpha:a];
    color = [self fjf_generateGrayColorWithOriginalColor:color red:r green:g blue:b alpha:a];
    return  color;
}

+ (UIColor *)fjf_generateGrayColorWithOriginalColor:(UIColor *)originalColor
                                               red:(CGFloat)r
                                             green:(CGFloat)g
                                              blue:(CGFloat)b
                                             alpha:(CGFloat)a {
    return [UIColor fjf_generateGrayColorWithColor:originalColor red:r green:g blue:b alpha:a];
}

+ (UIColor *)fjf_generateGrayColorWithColor:(UIColor *)color
                                       red:(CGFloat)r
                                     green:(CGFloat)g
                                      blue:(CGFloat)b
                                     alpha:(CGFloat)a {
    if (r == 0 && g == 0 && b == 0) {
        return color;
    }
    CGFloat gray = r * 0.299 +g * 0.587 + b * 0.114;
    UIColor *grayColor = [UIColor colorWithWhite:gray alpha:a];
    return  grayColor;
}

+ (NSArray <NSNumber *> *)fjf_getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}
@end
