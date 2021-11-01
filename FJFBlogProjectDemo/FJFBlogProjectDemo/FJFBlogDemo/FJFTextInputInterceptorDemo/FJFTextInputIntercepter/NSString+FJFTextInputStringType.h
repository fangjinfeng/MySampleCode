//
//  NSString+FJFTextInputStringType.h
//  FJTextInputIntercepterDemo
//
//  Created by fjf on 2018/7/4.
//  Copyright © 2018年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FJFTextInputStringType) {
    FJFTextInputStringTypeNumber,         //数字
    FJFTextInputStringTypeLetter,         //字母
    FJFTextInputStringTypeChinese,        //汉字
    FJFTextInputStringTypeEmoji,          //表情
};

@interface NSString (FJFTextInputStringType)

/**
 某个字符串是不是数字、字母、汉字。
 */
-(BOOL)fjf_isContainStringType:(FJFTextInputStringType)stringType;


/// 是否 包含 表情
- (BOOL)fjf_isContainEmoji;
/// 是否 包含 表情
/// @param string 字符串
+ (BOOL)fjf_stringContainsEmoji:(NSString *)string;
@end
