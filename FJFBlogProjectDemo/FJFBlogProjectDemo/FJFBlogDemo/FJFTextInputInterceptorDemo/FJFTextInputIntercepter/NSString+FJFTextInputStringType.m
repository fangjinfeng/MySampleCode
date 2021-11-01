//
//  NSString+FJFTextInputStringType.m
//  FJTextInputIntercepterDemo
//
//  Created by fjf on 2018/7/4.
//  Copyright © 2018年 fjf. All rights reserved.
//


#import "NSString+FJFTextInputStringType.h"

@implementation NSString (FJFTextInputStringType)

- (BOOL)fjf_isContainStringType:(FJFTextInputStringType)stringType {
    return [self fjf_matchRegularWith:stringType];
}


- (BOOL)fjf_isContainEmoji {
    if ([self fjf_isContainStringType:FJFTextInputStringTypeEmoji]) {
        return YES;
    }
    if ([NSString fjf_stringContainsEmoji:self]) {
        return YES;
    }
    return NO;
}


#pragma mark - Private Methods

- (BOOL)fjf_matchRegularWith:(FJFTextInputStringType)type {
    NSString *regularStr = @"";
    switch (type) {
        case FJFTextInputStringTypeNumber:      //数字
            regularStr = @"^[0-9]*$";
            break;
        case FJFTextInputStringTypeLetter:      //字母
            regularStr = @"^[A-Za-z]+$";
            break;
        case FJFTextInputStringTypeChinese:     //汉字
            regularStr = @"^[\u4e00-\u9fa5]{0,}$";
            break;
        case FJFTextInputStringTypeEmoji:       //表情
            regularStr = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
            break;
        default:
            break;
    }
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    
    if ([regextestA evaluateWithObject:self] == YES){
        return YES;
    }
    return NO;
}

+ (BOOL)fjf_stringContainsEmoji:(NSString *)string {
    //argument can be character or entire string
    UILabel *characterRender = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    characterRender.text = string;
    characterRender.backgroundColor = [UIColor blackColor];//needed to remove subpixel rendering colors
    [characterRender sizeToFit];

    CGRect rect = [characterRender bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef contextSnap = UIGraphicsGetCurrentContext();
    [characterRender.layer renderInContext:contextSnap];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGImageRef imageRef = [capturedImage CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    BOOL colorPixelFound = NO;

    int x = 0;
    int y = 0;
    while (y < height && !colorPixelFound) {
        while (x < width && !colorPixelFound) {

            NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;

            CGFloat red = (CGFloat)rawData[byteIndex];
            CGFloat green = (CGFloat)rawData[byteIndex+1];
            CGFloat blue = (CGFloat)rawData[byteIndex+2];

            CGFloat h, s, b, a;
            UIColor *c = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
            [c getHue:&h saturation:&s brightness:&b alpha:&a];

            b /= 255.0f;

            if (b > 0) {
                colorPixelFound = YES;
            }
            x++;
        }
        x = 0;
        y ++;
    }
    return colorPixelFound;
}
@end
