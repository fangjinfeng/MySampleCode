
//
//  FJFPopMenuViewHeader.h
//  FJFPopMenuViewDemo
//
//  Created by macmini on 26/10/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#ifndef FJFPopMenuViewHeader_h
#define FJFPopMenuViewHeader_h

#import <UIKit/UIKit.h>


typedef void(^FJFButtonClickBlock)(UIButton *button, id value);


#define FJF_PingFangRegular_Font(value)  [UIFont fontWithName:@"PingFangSC-Regular" size:(value)]

//MARK: - color
#define FJF_RGBColorAlpha(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define FJF_RGBColor(r, g, b)            FJF_RGBColorAlpha(r, g, b, 1.0)

/**
 * 宽度计算
 */
static inline float widthWithParam(UIFont *font, float maxWidth, NSString *contentString) {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat width = [contentString boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}


static inline float heightWithParam(UIFont *font, float widthLimit, NSString *contentString){
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat height = [contentString boundingRectWithSize:CGSizeMake(widthLimit, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}



#endif /* FJFPopMenuViewHeader_h */
