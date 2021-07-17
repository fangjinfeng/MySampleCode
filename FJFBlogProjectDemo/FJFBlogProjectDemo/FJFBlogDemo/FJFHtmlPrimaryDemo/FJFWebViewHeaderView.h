//  WebView
//  Created by FJF on 11/05/2020.
//  Copyright © 2020 FJF. All rights reserved.

#import <UIKit/UIKit.h>

@interface FJFWebViewHeaderView : UIView

/** 获取网页高度回调 */
@property (nonatomic, copy) void (^WebViewHeightHandler) (CGFloat);

/** 获取网页图片数组回调 */
@property (nonatomic, copy) void (^WebViewimageArrayHandler) (NSArray *);

/** 获取网页点击图片回调 */
@property (nonatomic, copy) void (^WebViewimageURLHandler) (NSString *);


/** 网页加载 */
- (void)loadURL:(NSString *)html;

/// 加载 html 文件
/// @param htmlFileName html 文件
- (void)loadHtmlFileName:(NSString *)htmlFileName;
@end
