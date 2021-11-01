//
//  FJFPermanentThredViewController.m
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/10/8.
//  Copyright © 2021 fjf. All rights reserved.
//

#import "FJFPermanentThread.h"
#import "FJFPermanentThreadViewController.h"

@interface FJFPermanentThreadViewController ()
// 常驻 线程
@property (nonatomic, strong) FJFPermanentThread *permanentThread;
@end

@implementation FJFPermanentThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.permanentThread = [[FJFPermanentThread alloc] init];
    
    
    for (NSInteger tmpIndex = 0; tmpIndex < 10000; tmpIndex++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.permanentThread doAction:^{
                NSLog(@"------------1111111");
            }];
        
            [self.permanentThread doAction:^{
                NSLog(@"------------22222");
            }];
        
            [self.permanentThread doAction:^{
                NSLog(@"------------33333");
            }];
        
            [self.permanentThread doAction:^{
                NSLog(@"------------444444");
            }];
        });
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.permanentThread doAction:^{
        NSLog(@"------------555555");
    }];
}
@end
