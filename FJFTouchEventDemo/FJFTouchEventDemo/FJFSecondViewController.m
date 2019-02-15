//
//  FJFSecondViewController.m
//  FJFTouchEventDemo
//
//  Created by 方金峰 on 2019/2/13.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFSecondViewController.h"

@interface FJFSecondViewController ()<UITextFieldDelegate>
// previousTextFieldText
@property (nonatomic, copy) NSString *previousTextFieldText;

// accountTextField
@property (nonatomic, strong) UITextField *accountTextField;
@end

@implementation FJFSecondViewController

#pragma mark -------------------------- Life Circle

- (void)dealloc {
    [self.accountTextField removeObserver:self forKeyPath:@"text"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"精选";
    
    // 账号
    UITextField *tmpAccountTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 300, 50)];
    tmpAccountTextField.placeholder = @"账号";
    [tmpAccountTextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:tmpAccountTextField];
    self.accountTextField = tmpAccountTextField;
    
    // 密码
    UITextField *tmpPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 300, 50)];
    tmpPasswordTextField.placeholder = @"密码";
    tmpPasswordTextField.textContentType = UITextContentTypePassword;
    tmpPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:tmpPasswordTextField];
    
}


#pragma mark -------------------------- KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        NSString *oldValue = change[NSKeyValueChangeOldKey];
        NSString *latestValue = change[NSKeyValueChangeNewKey];
        if (latestValue.length == 0) {
            self.previousTextFieldText = oldValue;
        }
        
        if ([oldValue isEqualToString:latestValue] &&
            self.previousTextFieldText.length != 0) {
            UITextField *tmpField = object;
            if ([tmpField isKindOfClass:[UITextField class]]) {
                tmpField.text = [self.previousTextFieldText copy];
                self.previousTextFieldText = @"";
            }
        }
    }
    NSLog(@"change:%@", change);
}
@end
