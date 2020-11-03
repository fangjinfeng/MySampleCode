//
//  AppDelegate.m
//  FJFNSEnginerProject
//
//  Created by macmini on 2020/11/3.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *tmpFirstVc = [[ViewController alloc] init];
    UINavigationController *tmpFirstNav = [[UINavigationController alloc] initWithRootViewController:tmpFirstVc];
    
    self.window.rootViewController = tmpFirstNav;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    return YES;
}


@end
