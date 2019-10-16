


//
//  UIView+FJFCornerBorder.m
//  FJFViewBorderDemoo
//
//  Created by macmini on 16/10/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "UIView+FJFCornerBorder.h"


@implementation UIView (FJFCornerBorder)
// 设置 带圆角的边框
- (CAShapeLayer *)fjf_setCornerRadius:(CGFloat)cornerRadius
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor
                      viewBorderType:(FJFViewBorderType)viewBorderType{

    return [UIView fjf_setCornerRadius:cornerRadius borderView:self borderWidth:borderWidth borderColor:borderColor viewBorderType:viewBorderType];
}


+ (CAShapeLayer *)fjf_setCornerRadius:(CGFloat)cornerRadius
                          borderView:(UIView *)borderView
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor
                      viewBorderType:(FJFViewBorderType)viewBorderType  {

  
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewWidth = borderView.bounds.size.width;
    CGFloat viewHeight = borderView.bounds.size.height;
    
    
    // 第一条线两点
    CGPoint firstPoint = CGPointMake(viewX + cornerRadius, viewY);
    CGPoint secondPoint = CGPointMake(viewWidth - cornerRadius, viewY);
    
    // 第一个 圆角
   UIBezierPath *firstCornorPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewWidth - cornerRadius, viewY + cornerRadius) radius:cornerRadius startAngle:M_PI * 1.5 endAngle:(M_PI * 2) clockwise:YES];
    
    // 第二条线两点
    CGPoint threePoint = CGPointMake(viewWidth, viewY + cornerRadius);
    CGPoint fourPoint = CGPointMake(viewWidth, viewHeight - cornerRadius);
    // 第二个 圆角
    UIBezierPath *secondCornorPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewWidth - cornerRadius, viewHeight - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI / 2.0f clockwise:YES];
    
    // 第三条线两点
    CGPoint fivePoint = CGPointMake(viewWidth - cornerRadius, viewHeight);
    CGPoint sixPoint = CGPointMake(viewX + cornerRadius, viewHeight);
    // 第三个 圆角
    UIBezierPath *threeCornorPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewX + cornerRadius, viewHeight - cornerRadius) radius:cornerRadius startAngle:M_PI / 2.0f endAngle:M_PI  clockwise:YES];
    
    // 第四条线两点
    CGPoint sevenPoint = CGPointMake(viewX, viewHeight - cornerRadius);
    CGPoint eightPoint = CGPointMake(viewX, viewY + cornerRadius);
    
    // 第四个 圆角
    UIBezierPath *fourCornorPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewX + cornerRadius, viewY + cornerRadius) radius:cornerRadius startAngle:M_PI  endAngle:M_PI * 1.5  clockwise:YES];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
   
    if (viewBorderType == FJFViewBorderTypeAll) {  // 边框 圆角
       // 左边线
       [path moveToPoint:sevenPoint];
       [path addLineToPoint:eightPoint];
       [path appendPath:fourCornorPath];

       // 上边线
       [path addLineToPoint:firstPoint];
       [path addLineToPoint:secondPoint];
       [path appendPath:firstCornorPath];

       // 右边线
       [path addLineToPoint:threePoint];
       [path addLineToPoint:fourPoint];
       [path appendPath:secondCornorPath];

       // 底边线
       [path addLineToPoint:fivePoint];
       [path addLineToPoint:sixPoint];
       [path appendPath:threeCornorPath];
    }
    else if (viewBorderType == FJFViewBorderTypeTop) {  // 上半部分
        
        // 左边线
      [path moveToPoint:sevenPoint];
      [path addLineToPoint:eightPoint];
      [path appendPath:fourCornorPath];
        
       // 上边线
       [path addLineToPoint:firstPoint];
       [path addLineToPoint:secondPoint];
       [path appendPath:firstCornorPath];
       
       // 右边线
       [path addLineToPoint:threePoint];
       [path addLineToPoint:fourPoint];
       
    }
    else if(viewBorderType == FJFViewBorderTypeBottom){ // 下半部分
        // 右边线
        [path moveToPoint:threePoint];
        [path addLineToPoint:fourPoint];
        [path appendPath:secondCornorPath];

        // 底边线
        [path addLineToPoint:fivePoint];
        [path addLineToPoint:sixPoint];
        [path appendPath:threeCornorPath];

          // 左边线
        [path moveToPoint:sevenPoint];
        [path addLineToPoint:eightPoint];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = borderView.bounds;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = borderColor.CGColor;
    [borderView.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}
@end
