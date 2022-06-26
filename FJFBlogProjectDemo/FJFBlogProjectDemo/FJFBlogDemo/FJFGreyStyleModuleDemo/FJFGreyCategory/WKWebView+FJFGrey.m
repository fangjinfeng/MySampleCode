//
//  WKWebView+Gray.m


#import "WKWebView+FJFGrey.h"
#import "NSObject+FJFSwizzle.h"

@implementation WKWebView (FJFGrey)
#pragma mark - Public Methods
+ (void)fjf_startGreyStyle {
    NSError *error = NULL;
    
    [WKWebView fjf_swizzleMethod:@selector(initWithFrame:configuration:)
                     withMethod:@selector(fjf_initWithFrame:configuration:)
                          error:&error];
}

#pragma mark - Private Methods
- (instancetype)fjf_initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    // js脚本
    NSString *jScript = @"var filter = '-webkit-filter:grayscale(100%);-moz-filter:grayscale(100%); -ms-filter:grayscale(100%); -o-filter:grayscale(100%) filter:grayscale(100%);';document.getElementsByTagName('html')[0].style.filter = 'grayscale(100%)';";
    // 注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
                 
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
       [wkUController addUserScript:wkUScript];
    // 配置对象
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    configuration = wkWebConfig;
    WKWebView *webView = [self fjf_initWithFrame:frame configuration:configuration];
    return webView;
}
@end
