//
//  NSString+MethodTool.m
//  FJFBlogDemo
//
//  Created by jspeakfang on 1/2/21.
//

#import "NSString+MethodTool.h"

@implementation NSString (MethodTool)

// 对除了这些特殊字符(!$&'()*+-./:;=?@_~%#[])以外的所有字符进行编码
+ (NSString *)fjf_encodeSpecialCharacterWithUrlString:(NSString *)urlString {
    return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet   characterSetWithCharactersInString:@"!$&'()*+-./:;=?@_~%#[]"]];
}

// 只编码 中文 字符(对所有字符都不进行编码，除了中文)
+ (NSString *)fjf_encodeChineseCharacterWithUrlString:(NSString *)urlString {
    return  [urlString stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@""] invertedSet]];
}


+ (NSString *)fjf_encodeUrlStringWithString:(NSString *)urlString {

   //先截取问号
   NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
   NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
   if (allElements.count == 2) {
      //有参数或者?后面为空
       NSString *myUrlString = allElements[0];
       NSString *paramsString = allElements[1];

       //获取参数对
       NSArray *paramsArray = [paramsString componentsSeparatedByString:@"&"];
       if (paramsArray.count >= 2) {
          for (NSInteger i = 0; i < paramsArray.count; i++) {
             NSString *singleParamString = paramsArray[i];
             NSArray *singleParamSet = [singleParamString componentsSeparatedByString:@"="];
             if (singleParamSet.count == 2) {
                 NSString *key = singleParamSet[0];
                 NSString *value = singleParamSet[1];
                 if (key.length > 0 || value.length > 0) {
                    [params setObject:[self fjf_percentEscapedStringWithString:value]  forKey:[self fjf_percentEscapedStringWithString:key]];
                 }
             }
          }
       } else if (paramsArray.count == 1) {
          //无 &。url只有?后一个参数
          NSString *singleParamString = paramsArray[0];
          NSArray *singleParamSet = [singleParamString componentsSeparatedByString:@"="];
          if (singleParamSet.count == 2) {
             NSString *key = singleParamSet[0];
             NSString *value = singleParamSet[1];
             if (key.length || value.length) {
                 [params setObject:[self fjf_percentEscapedStringWithString:value] forKey:[self fjf_percentEscapedStringWithString:key]];
             }
          }
       }
      //整合url及参数
       NSMutableString *tmpMstring = [NSMutableString stringWithString:myUrlString];
       [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           [tmpMstring appendString:[self fjf_urlSymbolWithUrl:tmpMstring]];
           [tmpMstring appendString:[NSString stringWithFormat:@"%@=%@", key, obj]];
       }];
       return tmpMstring;
   }
    return urlString;
}


+ (NSString *)fjf_percentEscapedStringWithString:(NSString *)string {
    NSString * kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    NSString * kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";

    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];

    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    static NSUInteger const batchSize = 50;

    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;

    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);

        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];

        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];

        index += range.length;
    }
    return escaped;
}


// 请求地址 拼接 符号
+ (NSString *)fjf_urlSymbolWithUrl:(NSString *)url {
    NSString *symbolString = @"?";
    if ([url containsString:@"?"]) {
        symbolString = @"&";
    }
    return symbolString;
}

@end
