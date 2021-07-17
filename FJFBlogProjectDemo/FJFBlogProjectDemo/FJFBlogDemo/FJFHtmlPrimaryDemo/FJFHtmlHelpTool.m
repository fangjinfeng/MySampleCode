//  WebView
//  Created by FJF on 11/05/2020.
//  Copyright © 2020 FJF. All rights reserved.


#import "FJFHtmlHelpTool.h"
#import <CommonCrypto/CommonDigest.h>

#define kHTMLImgLocalDirectory      @"HTMLImgLocal"
#define kHTMLImgDefaultName         @"info_banner_placehold_icon.jpeg"
#define kHTMLIDefaultFileName         @"htmlDefaultFile.html"

@implementation FJFHtmlHelpTool

+ (NSString *)handleHTMLText:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"<p style=\"text-align: center;\">" withString:@"<p style=\"display: flex; align-items: center; justify-content: center;\">"];
    
    NSString *htmlAttStr = @"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"> <style> * { padding: 0; margin: 0; box-sizing: border-box; } body { padding: 0 0.24rem; font-size: 0.36rem; line-height: 0.6rem; color: #333; } body p { padding-bottom: 0.3rem; } body a { text-decoration: none; color: #1d94df; } body img { height: auto; width: 100%%; border-radius: 0.08rem; } body .time { padding-bottom: 0.4rem; font-size: 0.28rem; line-height: 0.4rem; color: #999; } body .title { font-size: 0.52rem; line-height: 0.7rem; color: #1e1e1e; padding-bottom: 0.3rem; } @media (max-width: 1920px) { html { font-size: 256px; } } @media (max-width: 1842px) { html { font-size: 245.6px; } } @media (max-width: 1762px) { html { font-size: 234.93px; } } @media (max-width: 1682px) { html { font-size: 224.26px; } } @media (max-width: 1602px) { html { font-size: 213.6px; } } @media (max-width: 1522px) { html { font-size: 202.93px; } } @media (max-width: 1442px) { html { font-size: 192.26px; } } @media (max-width: 1362px) { html { font-size: 181.6px; } } @media (max-width: 1282px) { html { font-size: 170.93px; } } @media (max-width: 1202px) { html { font-size: 160.26px; } } @media (max-width: 1122px) { html { font-size: 149.6px; } } @media (max-width: 1042px) { html { font-size: 138.93px; } } @media (max-width: 1024px) { html { font-size: 136.53px; } } @media (max-width: 962px) { html { font-size: 128.26px; } } @media (max-width: 952px) { html { font-size: 126.93px; } } @media (max-width: 902px) { html { font-size: 120.26px; } } @media (max-width: 882px) { html { font-size: 117.6px; } } @media (max-width: 828px) { html { font-size: 110.4px; } } @media (max-width: 802px) { html { font-size: 106.93px; } } @media (max-width: 775px) { html { font-size: 103.33px; } } @media (max-width: 768px) { html { font-size: 102.4px; } } @media (max-width: 750px) { html { font-size: 100px; } } @media (max-width: 738px) { html { font-size: 98.4px; } } @media (max-width: 734px) { html { font-size: 97.86px; } } @media (max-width: 733px) { html { font-size: 97.73px; } } @media (max-width: 669px) { html { font-size: 89.2px; } } @media (max-width: 642px) { html { font-size: 85.6px; } } @media (max-width: 602px) { html { font-size: 80.26px; } } @media (max-width: 570px) { html { font-size: 76px; } } @media (max-width: 535px) { html { font-size: 71.33px; } } @media (max-width: 455px) { html { font-size: 60.66px; } } @media (max-width: 437px) { html { font-size: 58.26px; } } @media (max-width: 414px) { html { font-size: 55.2px; } } @media (max-width: 412px) { html { font-size: 54.93px; } } @media (max-width: 386px) { html { font-size: 51.46px; } } @media (max-width: 375px) { html { font-size: 50px; } } @media (max-width: 370.8px) { html { font-size: 49.44px; } } @media (max-width: 360px) { html { font-size: 48px; } } @media (max-width: 320px) { html { font-size: 42.66px; } } </style>";
    
    NSMutableString *tmpHtmlMstring = [[NSMutableString alloc] init];
    if ([html containsString:@"<body>"]) {
        NSArray *htmlArray = [html componentsSeparatedByString:@"<body>"];
        if (htmlArray.count) {
            [tmpHtmlMstring appendString:htmlArray.firstObject];
            [tmpHtmlMstring appendString:@"<body>\n"];
            [tmpHtmlMstring appendString:htmlAttStr];
            [tmpHtmlMstring appendString:htmlArray.lastObject];
        }
    } else {
        [tmpHtmlMstring appendString:htmlAttStr];
        [tmpHtmlMstring appendString:html];
    }
    return  tmpHtmlMstring;
}


+ (NSArray *)handleHTMLImgArrToLocal:(NSString *)html {
    NSMutableDictionary *urlDic = [NSMutableDictionary dictionary];
    NSMutableArray *urlAllArr = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<img[^>]+"
                                                                           options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];

    // 获取所有的URL
    for (NSTextCheckingResult *item in result) {
        NSString *imgMarkerSrc = [html substringWithRange:[item rangeAtIndex:0]];

        NSString *imgSrc = imgMarkerSrc;
        NSRange range = [imgSrc rangeOfString:@"src=\""]; //双引号
        NSUInteger location2 = NSNotFound;
        
        if (range.location != NSNotFound) {
            imgSrc = [imgSrc substringFromIndex:range.location + range.length];
            
            location2 = [imgSrc rangeOfString:@"\""].location;
            if (location2 != NSNotFound) {
                imgSrc = [imgSrc substringToIndex:location2];
                
                [urlDic setObject:@(1) forKey:imgSrc];
                [urlAllArr addObject:imgSrc];
                
            } else {
                imgSrc = nil;
            }
        }

        if (!imgSrc) {
            imgSrc = imgMarkerSrc;
            range = [imgSrc rangeOfString:@"src=\'"]; //单引号
            location2 = NSNotFound;
            
            if (range.location != NSNotFound) {
                imgSrc = [imgSrc substringFromIndex:range.location + range.length];
                
                location2 = [imgSrc rangeOfString:@"\'"].location;
                if (location2 != NSNotFound) {
                    imgSrc = [imgSrc substringToIndex:location2];
                    
                    [urlDic setObject:@(2) forKey:imgSrc];
                    [urlAllArr addObject:imgSrc];
                    
                } else {
                    imgSrc = nil;
                }
            }
        }
    }

    NSString *defaultUrlPath = [self calcHTMLDefaultImgURLPath];
    NSMutableArray *urlReqArr = [NSMutableArray array];
    
    for (NSString *url in urlDic.allKeys) {
        NSNumber *urlType = [urlDic objectForKey:url];
        
        NSString *urlMd5 = [self fjf_md5:url];

        if ([self existHTMLImgInDoc:urlMd5]) {
            html = [html stringByReplacingOccurrencesOfString:url withString:[self calcHTMLImgURLPath:urlMd5]];
        } else {
            NSString *replaceUrl = nil;
            NSString *resultPath = [NSString stringWithFormat:@"\"%@\" id=%@ ", defaultUrlPath, urlMd5];
            if (urlType.integerValue == 1) { //双引号
                replaceUrl = [NSString stringWithFormat:@"\"%@\"", url];
            } else {
                replaceUrl = [NSString stringWithFormat:@"\'%@\'", url];
            }
            html = [html stringByReplacingOccurrencesOfString:replaceUrl withString:resultPath];
            
            [urlReqArr addObject:url];
        }
    }
    
    return @[html, urlReqArr, urlAllArr];
}

+ (NSString *)calcHTMLDefaultImgURLPath {
    NSString *imagePath = [self calcHTMLImgURLPath:kHTMLImgDefaultName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:imagePath]) {
        [self saveHTMLDefaultImgToDoc];
    }
    return imagePath;
}

+ (NSString *)calcHTMLImgURLPath:(NSString *)urlMd5 {
    return [NSString stringWithFormat:@"%@/%@", [self getCacheDirectory], urlMd5];
}

+ (NSURL *)defaultHtmlFilePathUrl {
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [self getCacheDirectory], kHTMLIDefaultFileName];
    return [NSURL fileURLWithPath:filePath];
}

+ (NSURL *)requestHTMLFileCacheDirectory {
    return [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
}

+ (void)writeHtmlContent:(NSString *)htmlContent {
    htmlContent = [self appendHTMLFileHeaderBody:htmlContent];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [self getCacheDirectory], kHTMLIDefaultFileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSData *contentData = [htmlContent dataUsingEncoding:NSUTF8StringEncoding];
    if (![fileManager fileExistsAtPath:filePath]) {
       [fileManager createFileAtPath:filePath contents:contentData attributes:nil];
    } else {
       [contentData writeToFile:filePath atomically:YES];
    }
}

#pragma mark - HTMLImg method

+ (NSString *)appendHTMLFileHeaderBody:(NSString *)htmlContent {
    if ([htmlContent containsString:@"<!DOCTYPE html>"]) {
        return htmlContent;
    }
    NSMutableString *htmlMstring = [NSMutableString string];
    [htmlMstring appendString:@"<!DOCTYPE html>\n"];
    [htmlMstring appendString:@"<html><head><meta charset=\"utf-8\"></head><body>\n"];
    [htmlMstring appendString:htmlContent];
    [htmlMstring appendString:@"</body></html>\n"];
    return [htmlMstring copy];
}


+ (BOOL)saveHTMLDefaultImgToDoc {
    UIImage *image = [UIImage imageNamed:kHTMLImgDefaultName];

    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    NSString *urlLocalPath = [self calcHTMLImgDocPath:kHTMLImgDefaultName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:urlLocalPath]) {
        return [imageData writeToFile:urlLocalPath atomically:YES];
    }
    return YES;
}

+ (NSString *)saveHTMLImgToDoc:(NSData *)imageData referUrl:(NSString *)url {
    NSString *urlMd5 = [self fjf_md5:url];
    
    NSString *urlLocalPath = [self calcHTMLImgDocPath:urlMd5];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:urlLocalPath]) {
        BOOL success = [imageData writeToFile:urlLocalPath atomically:YES];
        if (!success) {
            urlMd5 = nil;
        }
    }
    return urlMd5;
}

+ (NSString *)calcHTMLImgDocPath:(NSString *)urlMd5 {
    return [NSString stringWithFormat:@"%@/%@", [self getCacheDirectory], urlMd5];
}

+ (BOOL)existHTMLImgInDoc:(NSString *)urlMd5 {
    NSString *urlLocalPath = [self calcHTMLImgDocPath:urlMd5];
    return [[NSFileManager defaultManager] fileExistsAtPath:urlLocalPath];
}

#pragma mark - util method
+ (NSString *)getCacheDirectory {
    NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    docPath = [docPath stringByAppendingPathComponent:kHTMLImgLocalDirectory];
    if (![[NSFileManager defaultManager] fileExistsAtPath:docPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return docPath;
}

+ (NSString *)fjf_md5:(NSString *)sourceContent {
  if (!sourceContent.length) {
    return nil;
  }
  
  unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
  CC_MD5([sourceContent UTF8String], (int)[sourceContent lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
  NSMutableString *ms = [NSMutableString string];
  
  for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [ms appendFormat:@"%02x", (int)(digest[i])];
  }
  
  return [ms copy];
}
@end
