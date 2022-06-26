//
//  UILabel+FJFGrey.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/2/18.
//

#import "UILabel+FJFGrey.h"
#import "NSObject+FJFSwizzle.h"
#import "UIColor+FJFGreyColor.h"

@implementation UILabel (FJFGrey)
#pragma mark - Public Methods
+ (void)fjf_startGreyStyle {
    //交换方法
    NSError *error = NULL;

    [UILabel fjf_swizzleMethod:@selector(setTextColor:)
                   withMethod:@selector(fjf_setTextColor:)
                        error:&error];
}


#pragma mark - Private Methods
- (void)fjf_setTextColor:(UIColor *)color {
    color = [UIColor fjf_generateGrayColorWithOriginalColor:color];
    [self fjf_setTextColor:color];
}
@end


