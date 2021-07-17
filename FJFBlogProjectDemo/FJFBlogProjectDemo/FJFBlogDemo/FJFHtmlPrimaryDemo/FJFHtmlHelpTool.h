//
//  FJFHtmlHelpTool.h
//  FJF
//
//  Created by mac on 04/01/2020.
//  Copyright © 2020 FJF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFHtmlHelpTool : NSObject

+ (NSArray *)handleHTMLImgArrToLocal:(NSString *)html;
+ (NSString *)handleHTMLText:(NSString *)html;
+ (NSString *)calcHTMLDefaultImgURLPath;
+ (NSString *)calcHTMLImgURLPath:(NSString *)localPathName;


+ (BOOL)saveHTMLDefaultImgToDoc;
+ (NSURL *)defaultHtmlFilePathUrl;
+ (NSURL *)requestHTMLFileCacheDirectory;
+ (void)writeHtmlContent:(NSString *)htmlContent;
+ (NSString *)saveHTMLImgToDoc:(NSData *)imageData referUrl:(NSString *)url;
+ (NSString *)calcHTMLImgDocPath:(NSString *)localPathName;

@end

NS_ASSUME_NONNULL_END
