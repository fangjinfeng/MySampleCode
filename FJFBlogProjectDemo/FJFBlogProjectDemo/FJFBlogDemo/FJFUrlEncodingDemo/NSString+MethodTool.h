//
//  NSString+MethodTool.h
//  FJFBlogDemo
//
//  Created by jspeakfang on 1/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MethodTool)

/// 编码 请求 字符串
/// @param urlString 字符串
+ (NSString *)fjf_encodeUrlStringWithString:(NSString *)urlString;
// 编码 中文 字符
+ (NSString *)fjf_encodeChineseCharacterWithUrlString:(NSString *)urlString;
// 对除了这些特殊字符(!$&'()*+-./:;=?@_~%#[])以外的所有字符进行编码
+ (NSString *)fjf_encodeSpecialCharacterWithUrlString:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
