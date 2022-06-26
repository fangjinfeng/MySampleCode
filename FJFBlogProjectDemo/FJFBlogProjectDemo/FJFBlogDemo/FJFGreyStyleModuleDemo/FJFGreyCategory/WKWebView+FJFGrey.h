//
//  WKWebView+Gray.h
//
//

#import <WebKit/WebKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (FJFGrey)
// 开启 黑白色
+ (void)fjf_startGreyStyle;
@end

NS_ASSUME_NONNULL_END
