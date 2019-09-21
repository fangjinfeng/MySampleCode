//
//  FJFMarqueeView.h
//  ButtonPopMenu
//
//  Created by fjf on 06/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kRGBColorAlpha(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 十六进制RGB颜色 格式为（0xffffff）
#define kColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@class JhtHorizontalMarquee;
@interface FJFMarqueeView : UIView
// marqueeLabel
@property (nonatomic, strong) JhtHorizontalMarquee *marqueeLabel;
// shadowViewLayer
@property (nonatomic, strong) CAGradientLayer *shadowViewLayer;
@end

NS_ASSUME_NONNULL_END
