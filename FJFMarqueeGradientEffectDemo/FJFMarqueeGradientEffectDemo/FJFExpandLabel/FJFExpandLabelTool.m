//
//  FJFExpandLabelTool.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 22/01/2020.
//  Copyright © 2020 macmini. All rights reserved.
//

#import "FJFExpandLabel.h"
#import <CoreText/CoreText.h>
#import "FJFExpandLabelTool.h"


@implementation FJFExpandLabelTool

+ (NSAttributedString *)generateShowContentWithExpandLabelStyle:(FJFExpandLabelStyle *)expandLabelStyle {
    
    CGFloat contentLimitWidth = expandLabelStyle.limitWidth;
    UIFont *contentLabelFont = expandLabelStyle.contentLabelStyle.labelFont;
    NSString *replyContent = expandLabelStyle.contentLabelStyle.labelText;
    
    NSArray <NSString *> *lineTextArray = [FJFExpandLabelTool fjf_lineStringArrayWithLimitWidth:contentLimitWidth contentFont:contentLabelFont contentText:replyContent];
    NSInteger tmpLineCount = lineTextArray.count;
    NSInteger limitLine = expandLabelStyle.assignLineNum;
    
    NSMutableAttributedString *attributeString = nil;
    
    if (expandLabelStyle.labelShowType != FJFExpandLabelShowTypeNormal) {
        if (tmpLineCount > expandLabelStyle.compareLineNum &&
            expandLabelStyle.expandStatus == NO) {
            [expandLabelStyle updateIsBeyondLimit:YES];
            [expandLabelStyle updateExpandStatus:NO];
            CGFloat expandTextWidth = [FJFExpandLabelTool fjf_widthForFont:expandLabelStyle.expandLabelStyle.labelFont maxWidth:contentLimitWidth contentText:expandLabelStyle.expandLabelStyle.labelText];
            CGFloat suffixTextWidth = [FJFExpandLabelTool fjf_widthForFont:expandLabelStyle.suffixLabelStyle.labelFont maxWidth:contentLimitWidth contentText:expandLabelStyle.suffixLabelStyle.labelText];

            CGFloat tailAppendWidth = expandTextWidth + suffixTextWidth;


            replyContent = [FJFExpandLabelTool fjf_lineStringWithLimitLine:limitLine limitWidth:contentLimitWidth contentFont:contentLabelFont contentText:replyContent trailingBlankWidth:tailAppendWidth];

            NSString *lineString = [FJFExpandLabelTool fjf_assignLineStringWithLimitLine:limitLine limitWidth:contentLimitWidth contentFont:contentLabelFont contentText:replyContent];

            CGFloat assignLineWidth = [FJFExpandLabelTool fjf_widthForFont:contentLabelFont maxWidth:contentLimitWidth contentText:lineString];
            [expandLabelStyle updateAssignLineWidth:assignLineWidth];
            
            CGFloat assignLineHeight = [FJFExpandLabelTool fjf_heightForFont:contentLabelFont maxWidth:contentLimitWidth contentText:replyContent];
            [expandLabelStyle updateAssignLineHeight:assignLineHeight];

            NSString *expandAllTipString = expandLabelStyle.expandLabelStyle.labelText;
            NSMutableString *contentMstring = [[NSMutableString alloc] initWithString:replyContent];
            [contentMstring appendString:expandLabelStyle.suffixLabelStyle.labelText];
            [contentMstring appendString:expandAllTipString];
            NSRange expandAllTipRange = NSMakeRange(contentMstring.length - expandAllTipString.length, expandAllTipString.length);

            attributeString = [[NSMutableAttributedString alloc] initWithString:contentMstring];
            [attributeString addAttribute:NSFontAttributeName value:contentLabelFont range:NSMakeRange(0, contentMstring.length)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:expandLabelStyle.contentLabelStyle.labelTextColor range:NSMakeRange(0, contentMstring.length)];

            
            [attributeString addAttribute:NSFontAttributeName value:expandLabelStyle.expandLabelStyle.labelFont range:expandAllTipRange];
            [attributeString addAttribute:NSForegroundColorAttributeName value:expandLabelStyle.expandLabelStyle.labelTextColor range:expandAllTipRange];
        }
        else {
            [expandLabelStyle updateIsBeyondLimit:NO];
            [expandLabelStyle updateExpandStatus:YES];
            // 有 收起 状态
            if (expandLabelStyle.labelShowType == FJFExpandLabelShowTypeExpandAndPickup) {
                NSString *expandAllTipString = expandLabelStyle.pickupLabelStyle.labelText;
                NSMutableString *contentMstring = [[NSMutableString alloc] initWithString:replyContent];
                [contentMstring appendString:expandAllTipString];

                NSString *tmpLastLineString = [FJFExpandLabelTool fjf_pickupLastLineStringWithLimitWidth:contentLimitWidth contentFont:contentLabelFont contentMstring:contentMstring pickupLabelStyle:expandLabelStyle.pickupLabelStyle];
                
                CGFloat assignLineWidth = [FJFExpandLabelTool fjf_widthForFont:contentLabelFont maxWidth:contentLimitWidth contentText:tmpLastLineString];
                [expandLabelStyle updateAssignLineWidth:assignLineWidth];

                CGFloat assignLineHeight = [FJFExpandLabelTool fjf_heightForFont:contentLabelFont maxWidth:contentLimitWidth contentText:contentMstring];
                [expandLabelStyle updateAssignLineHeight:assignLineHeight];
                
                
                NSRange expandAllTipRange = NSMakeRange(contentMstring.length - expandAllTipString.length, expandAllTipString.length);

                attributeString = [[NSMutableAttributedString alloc] initWithString:contentMstring];
                [attributeString addAttribute:NSFontAttributeName value:contentLabelFont range:NSMakeRange(0, contentMstring.length)];
                [attributeString addAttribute:NSForegroundColorAttributeName value:expandLabelStyle.contentLabelStyle.labelTextColor range:NSMakeRange(0, contentMstring.length)];

                [attributeString addAttribute:NSFontAttributeName value:expandLabelStyle.pickupLabelStyle.labelFont range:expandAllTipRange];
                [attributeString addAttribute:NSForegroundColorAttributeName value:expandLabelStyle.pickupLabelStyle.labelTextColor range:expandAllTipRange];
            } else {
                attributeString = [[NSMutableAttributedString alloc] initWithString:replyContent];
                [attributeString addAttribute:NSFontAttributeName value:contentLabelFont range:NSMakeRange(0, replyContent.length)];
                [attributeString addAttribute:NSForegroundColorAttributeName value:expandLabelStyle.contentLabelStyle.labelTextColor range:NSMakeRange(0, replyContent.length)];
            }
        }
    }
    else {
        attributeString = [[NSMutableAttributedString alloc] initWithString:replyContent];
        [attributeString addAttribute:NSFontAttributeName value:contentLabelFont range:NSMakeRange(0, replyContent.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:expandLabelStyle.contentLabelStyle.labelTextColor range:NSMakeRange(0, replyContent.length)];
    }

    return attributeString;
}


+ (NSString *)fjf_lineStringWithLimitLine:(NSInteger)limitLine
                               limitWidth:(CGFloat)limitWidth
                              contentFont:(UIFont *)contentFont
                              contentText:(NSString *)contentText
                       trailingBlankWidth:(CGFloat)trailingBlankWidth {
    
    NSArray <NSString *>*lineStringArray = [self fjf_lineStringArrayWithLimitWidth:limitWidth contentFont:contentFont contentText:contentText];
    NSMutableString *lineMstring = [[NSMutableString alloc] init];
    NSInteger lineStringCount = lineStringArray.count;
    if (limitLine <= lineStringCount) {
        [lineStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < limitLine) {
                if (idx == (limitLine - 1)) {
                    CGFloat stringWidth = [FJFExpandLabelTool fjf_widthForFont:contentFont maxWidth:limitWidth contentText:obj];
                    if (stringWidth > (limitWidth - trailingBlankWidth)) {
                        NSString *tmpString = [obj substringWithRange:NSMakeRange(obj.length - 12, 12)];
                        CGFloat trailingBlanLength = [self fjf_trailBlankStringWithString:tmpString limitWidth:limitWidth contentFont:contentFont trailingBlankWidth:trailingBlankWidth];
                        obj = [obj substringWithRange:NSMakeRange(0, obj.length - trailingBlanLength)];
                    }
                   obj = [obj stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                }
                [lineMstring appendString:obj];
            }
        }];
    }
    return lineMstring;
}

+ (NSInteger)fjf_trailBlankStringWithString:(NSString *)string
                                 limitWidth:(CGFloat)limitWidth
                                contentFont:(UIFont *)contentFont
                         trailingBlankWidth:(CGFloat)trailingBlankWidth {
    
    NSInteger currentStringLength = 0;
    NSInteger subStrValueLength = 0;
    while (currentStringLength <= string.length) {
        NSString *tmpString = [string substringWithRange:NSMakeRange(0, currentStringLength)];
        CGFloat stringWidth = [FJFExpandLabelTool fjf_widthForFont:contentFont maxWidth:limitWidth contentText:tmpString];
        if (stringWidth > trailingBlankWidth) {
            break;
        }
        NSString *tmpBalanceString = [string substringWithRange:NSMakeRange(0, string.length - currentStringLength)];
        subStrValueLength = [self fjf_reduceStringLengthWithString:tmpBalanceString];
        currentStringLength = currentStringLength + subStrValueLength;
    }
    return currentStringLength;
}


/// 获取 收起时 最后 一行 字符串
/// @param limitWidth 限制 宽度
/// @param contentFont 文本 字体
/// @param contentMstring 内容 编辑 文本
/// @param pickupLabelStyle 收起 文本 属性
+ (NSString *)fjf_pickupLastLineStringWithLimitWidth:(CGFloat)limitWidth
                                         contentFont:(UIFont *)contentFont
                                      contentMstring:(NSMutableString *)contentMstring
                                    pickupLabelStyle:(FJFLabelAttributeStyle *)pickupLabelStyle {
    
    CGFloat pickupTextWidth = [FJFExpandLabelTool fjf_widthForFont:pickupLabelStyle.labelFont maxWidth:limitWidth contentText:pickupLabelStyle.labelText];
    CGFloat pickupNormalTextWidth = [FJFExpandLabelTool fjf_widthForFont:contentFont maxWidth:limitWidth contentText:pickupLabelStyle.labelText];
    
    CGFloat pickupTextDifWidth = pickupTextWidth - pickupNormalTextWidth;
    NSArray <NSString *>*lineStringArray = [self fjf_lineStringArrayWithLimitWidth:limitWidth contentFont:contentFont contentText:contentMstring];
    NSString *lastLineString = lineStringArray.lastObject;
    NSInteger pickupTextLength = pickupLabelStyle.labelText.length;
    if (lastLineString.length < pickupTextLength) {
        CGFloat insertIndex = contentMstring.length - pickupTextLength;
        [contentMstring insertString:@"\n" atIndex:insertIndex];
    } else {
        CGFloat lastLineTextWidth = [FJFExpandLabelTool fjf_widthForFont:contentFont maxWidth:limitWidth contentText:lastLineString] + pickupTextDifWidth;
        if (lastLineTextWidth > limitWidth) {
            CGFloat insertIndex = contentMstring.length - pickupTextLength;
            [contentMstring insertString:@"\n" atIndex:insertIndex];
        }
    }
    
    lineStringArray = [self fjf_lineStringArrayWithLimitWidth:limitWidth contentFont:contentFont contentText:contentMstring];
    return lineStringArray.lastObject;
}

// 获取 最后 一行 字符串
+ (NSString *)fjf_lastLineStringWithLimitWidth:(CGFloat)limitWidth contentFont:(UIFont *)contentFont contentText:(NSString *)contentText {
    NSArray <NSString *>*lineStringArray = [self fjf_lineStringArrayWithLimitWidth:limitWidth contentFont:contentFont contentText:contentText];
    return lineStringArray.lastObject;
}


+ (NSString *)fjf_assignLineStringWithLimitLine:(NSInteger)limitLine
                                     limitWidth:(CGFloat)limitWidth
                                    contentFont:(UIFont *)contentFont
                                    contentText:(NSString *)contentText {
    NSArray <NSString *>*lineStringArray = [self fjf_lineStringArrayWithLimitWidth:limitWidth contentFont:contentFont contentText:contentText];
    NSString *lineString = @"";
    NSInteger lineStringCount = lineStringArray.count;
    if (limitLine <= lineStringCount) {
        lineString = lineStringArray[limitLine - 1];
        lineString = [lineString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return lineString;
}

+ (NSArray *)fjf_lineStringArrayWithLimitWidth:(CGFloat)limitWidth
                                   contentFont:(UIFont *)contentFont
                                   contentText:(NSString *)contentText {
    if (contentText == nil) {
        return nil;
    }
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSFontAttributeName value:contentFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, limitWidth, CGFLOAT_MAX));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];

    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [contentText substringWithRange:range];
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return linesArray;
}

#pragma mark - Private Methods

// 减去 字符 长度
+ (NSInteger)fjf_reduceStringLengthWithString:(NSString *)string {
    NSInteger subStrValue = 0;
    if (string.length > 2) {
        NSString *subStr = [string substringWithRange:NSMakeRange(string.length - 2, 2)];
        if ([FJFExpandLabelTool fjf_isContainEmojiWithString:subStr]) {
            subStrValue = 2;
        } else {
            subStrValue = 1;
        }
    }
    return subStrValue;
}


+ (BOOL)fjf_isContainEmojiWithString:(NSString *)string {
    if ([self fjf_matchEmojiRegularWithWithString:string]) {
        return YES;
    }
    if ([self fjf_stringContainsEmoji:string]) {
        return YES;
    }
    return NO;
}


+ (BOOL)fjf_matchEmojiRegularWithWithString:(NSString *)string {
   //表情
    NSString *regularStr = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    
    if ([regextestA evaluateWithObject:string] == YES){
        return YES;
    }
    return NO;
}



// 是否 包含 表情
+ (BOOL)fjf_stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    if (string.length > 0) {
        [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
             const unichar hs = [substring characterAtIndex:0];
             // surrogate pair
             if (0xd800 <= hs && hs <= 0xdbff){
                 if (substring.length > 1){
                     const unichar ls = [substring characterAtIndex:1];
                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                     if (0x1d000 <= uc && uc <= 0x1f77f){
                         returnValue = YES;
                     }
                 }
             }
             else if (substring.length > 1){
                 const unichar ls = [substring characterAtIndex:1];
                 if (ls == 0x20e3 || ls == 0xfe0f){
                     returnValue = YES;
                 }
             }else{
                 // non surrogate
                 if (0x2100 <= hs && hs <= 0x27ff){
                     returnValue = YES;
                 }else if (0x2B05 <= hs && hs <= 0x2b07){
                     returnValue = YES;
                 }else if (0x2934 <= hs && hs <= 0x2935){
                     returnValue = YES;
                 }else if (0x3297 <= hs && hs <= 0x3299){
                     returnValue = YES;
                 }
                 else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50){
                     returnValue = YES;
                 }
             }
         }];
    }
    return returnValue;
}

/**
 * 宽度计算
 */
+ (CGFloat)fjf_widthForFont:(UIFont *)font maxWidth:(float)maxWidth contentText:(NSString *)contentText {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat width = [contentText boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}


/**
 * 高度 计算
 */
+ (CGFloat)fjf_heightForFont:(UIFont *)font maxWidth:(float)maxWidth contentText:(NSString *)contentText {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat height = [contentText boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}
@end
