//
//  CAShapeLayer+FJFGrey.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/2/25.
//

#import "UIColor+FJFGreyColor.h"
#import "NSObject+FJFSwizzle.h"
#import "CAShapeLayer+FJFGrey.h"

@implementation CAShapeLayer (FJFGrey)
#pragma mark - Public Methods
+ (void)fjf_startGreyStyle {
    NSError *error = NULL;
    
    [CAShapeLayer fjf_swizzleMethod:@selector(setFillColor:)
                        withMethod:@selector(fjf_setFillColor:)
                             error:&error];
    [CAShapeLayer fjf_swizzleMethod:@selector(setStrokeColor:)
                        withMethod:@selector(fjf_setStrokeColor:)
                             error:&error];
}

- (void)fjf_setStrokeColor:(CGColorRef)color {
    UIColor *greyColor = [UIColor fjf_generateGrayColorWithOriginalColor:[UIColor colorWithCGColor:color]];
    [self fjf_setStrokeColor:greyColor.CGColor];
}

- (void)fjf_setFillColor:(CGColorRef)color {
    UIColor *greyColor = [UIColor fjf_generateGrayColorWithOriginalColor:[UIColor colorWithCGColor:color]];
    [self fjf_setFillColor:greyColor.CGColor];
}

@end
