//  WebView
//  Created by FJF on 11/05/2020.
//  Copyright © 2020 FJF. All rights reserved.


#import "Masonry.h"
#import <WebKit/WebKit.h>
#import "FJFWebViewHeaderView.h"
#import "SDWebImageDownloader.h"
#import "FJFHtmlHelpTool.h"
#import "YBIBToolViewHandler.h"
#import <UIImageView+WebCache.h>
#import <YBImageBrowser/YBImageBrowser.h>

@interface FJFWebViewHeaderView () <WKUIDelegate,WKNavigationDelegate>
// webView
@property (nonatomic, strong) WKWebView *webView;
// 进度条
@property (nonatomic, strong) UIProgressView *progressView;
// requestImageUrlArray
@property (nonatomic, strong) NSArray <NSString *>*requestImageUrlArray;
// originalImageUrlArray
@property (nonatomic, strong) NSArray <NSString *>*originalImageUrlArray;
@end

@implementation FJFWebViewHeaderView {
    CGFloat webContentHeight;
}

#pragma mark - Life Circle
//  释放监听网页高度
- (void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Public Methods

//  加载网页
- (void)loadURL:(NSString *)html {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html]]];
}

- (void)loadHtmlFileName:(NSString *)htmlFileName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:htmlFileName withExtension:@"html"];
    NSString *htmlLocal = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *retArray = [FJFHtmlHelpTool handleHTMLImgArrToLocal:htmlLocal];
    htmlLocal = retArray.firstObject;
    htmlLocal = [FJFHtmlHelpTool handleHTMLText:htmlLocal];
    self.originalImageUrlArray = retArray.lastObject;
    
    [FJFHtmlHelpTool writeHtmlContent:htmlLocal];
    
    self.requestImageUrlArray = [retArray objectAtIndex:1];
    NSArray *urlReqArr = [retArray objectAtIndex:1];
    for (NSString *url in urlReqArr) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (!data) return;
                NSString *urlMd5 = [FJFHtmlHelpTool saveHTMLImgToDoc:data referUrl:url];
                
                if (!urlMd5) return;
                //根据ID替换URL
                [self runAddHTMLImgReplaceMethodByID:urlMd5
                                            localURL:[FJFHtmlHelpTool calcHTMLImgURLPath:urlMd5]];
            });
        }];
    }

    [self.webView loadFileURL:[FJFHtmlHelpTool defaultHtmlFilePathUrl]
      allowingReadAccessToURL:[FJFHtmlHelpTool requestHTMLFileCacheDirectory]];
}


#pragma mark - Kvo Methods

//  监听网页加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat WebHeight = self.webView.scrollView.contentSize.height;
        //  如果高度一样则不刷新
        if (WebHeight != webContentHeight) {
            webContentHeight = WebHeight;
            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(WebHeight).priorityHigh();
            }];
            
            //  刷新 Cell高度
            !_WebViewHeightHandler ?: _WebViewHeightHandler(WebHeight);
        }
    }
    

    //  网页加载紧肤
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                self.progressView.hidden = YES;
            }];
        }
    }
}



#pragma mark - WebDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self bringSubviewToFront:self.progressView];
}


//  加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //  加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    [self addHTMLImgClick];
    [self runAddHTMLImgClick];
    [self addHTMLImgReplaceMethod];
    
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *requestString = [[navigationAction.request URL] absoluteString];
    if ([requestString hasPrefix:@"hyb-image-preview:"]) {
        NSString *imgStr = [requestString substringFromIndex:@"hyb-image-preview:".length];
        NSArray *strArr = [imgStr componentsSeparatedByString:@"$$$"];
        NSString *indexStr = [strArr firstObject];
        [self prepareImgsPreview:[indexStr integerValue]];
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else if ([requestString hasPrefix:@"http"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - Private Methods
- (void)addHTMLImgReplaceMethod {
    NSString *js2 =
    @"function addHTMLImgReplaceMethod(imgID, imgURL) { \
        var imgs = document.getElementsByTagName('img'); \
        for (var i = 0; i < imgs.length; ++i) { \
            var img = imgs[i]; \
            if (img.id == imgID) img.src = imgURL; \
        }\
    }";
    [self.webView evaluateJavaScript:js2 completionHandler:nil];
}

- (void)runAddHTMLImgClick {
    [self.webView evaluateJavaScript:@"addHTMLImgClick()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"addHTMLImgClick result ------- %@", result);
    }];
}

- (void)addHTMLImgClick {
    NSString *js1 =
    @"function addHTMLImgClick() { \
        var imgs = document.getElementsByTagName('img'); \
        var imgSrcArr = []; \
        for (var i = 0; i < imgs.length; ++i) { \
             var img = imgs[i]; \
             imgSrcArr.push(img.src); \
             img.onclick = (function(j) { \
                return function() { \
                    window.location.href = 'hyb-image-preview:' + j + '$$$' + this.src; \
                } \
             })(i); \
         } \
         return imgSrcArr; \
    }";
    [self.webView evaluateJavaScript:js1 completionHandler:nil];
}

- (void)runAddHTMLImgReplaceMethodByID:(NSString *)urlMD5 localURL:(NSString *)localURL {
    NSString *method = [NSString stringWithFormat:@"addHTMLImgReplaceMethod(\"%@\", \"%@\")", urlMD5, localURL];
    [self.webView evaluateJavaScript:method completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"addHTMLImgReplaceMethod result ------- %@", result);
    }];
}

- (void)prepareImgsPreview:(NSInteger)index {
    NSMutableArray *tmpImageDataArray = [NSMutableArray array];
    [self.originalImageUrlArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 网络图片
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:obj];
        [tmpImageDataArray addObject:data];
    }];
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = tmpImageDataArray;
    browser.currentPage = index;
    [browser show];
}


#pragma mark - Getter Methods

- (WKWebView *)webView {
    if(_webView == nil) {
        //  初始化 webview 的设置
        WKWebViewConfiguration *configer = [[WKWebViewConfiguration alloc] init];
        configer.userContentController = [[WKUserContentController alloc] init];
        configer.preferences = [[WKPreferences alloc] init];
        configer.preferences.javaScriptEnabled = YES;
        configer.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        configer.allowsInlineMediaPlayback = YES;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectNull configuration:configer];
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_webView];
        // 使用kvo为webView添加监听，监听webView的内容高度
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        // 使用kvo为webView添加监听,监听webView的加载进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _webView;
}


- (UIProgressView *)progressView {
    if(_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor lightGrayColor];
        _progressView.backgroundColor = [UIColor clearColor];
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self addSubview:_progressView];
    }
    return _progressView;
}
@end
