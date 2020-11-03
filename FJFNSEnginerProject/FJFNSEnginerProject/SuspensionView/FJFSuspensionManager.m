//
//  FJFSuspensionManager.m
//  FJFNSEnginerProject
//
//  Created by macmini on 2020/11/3.
//

#import "FJFSuspensionView.h"
#import "FJFSuspensionManager.h"

@interface FJFSuspensionManager()
// suspensionWindow
@property (nonatomic, strong) UIWindow *suspensionWindow;

// FJFSuspensionView
@property (nonatomic, strong) FJFSuspensionView *suspensionView;
@end

@implementation FJFSuspensionManager

#pragma mark - Public Methods
+ (instancetype)sharedManager {
    static FJFSuspensionManager * shared = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)showSuspensionView {
    CGFloat w = 100;
    CGFloat h = 100;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - w;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - h - 60;
    self.suspensionWindow = [self alertLevelWindow];
    self.suspensionWindow.frame = CGRectMake(x, y, w, h);
    self.suspensionWindow.rootViewController.view.backgroundColor = [UIColor whiteColor];
    
    _suspensionView = [[FJFSuspensionView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    _suspensionView.parentView = self.suspensionWindow.rootViewController.view;
    _suspensionView.containerWindow = self.suspensionWindow;
    _suspensionView.layer.cornerRadius = h / 2.0f;
}


#pragma mark - Getter Methods
- (UIWindow *)alertLevelWindow {
    UIWindow *tmpWindow = [[UIWindow alloc] init];
    tmpWindow.windowLevel = UIWindowLevelAlert;
    tmpWindow.rootViewController = [[UIViewController alloc] init];
    [tmpWindow setHidden:NO];
    return tmpWindow;
}

@end
