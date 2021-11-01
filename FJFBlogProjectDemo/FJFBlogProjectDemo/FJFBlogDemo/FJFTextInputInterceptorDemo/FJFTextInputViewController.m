//
//  FJFTextInputViewController.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2021/10/21.
//  Copyright © 2021 方金峰. All rights reserved.
//


#import "FJFTextView.h"
#import "FJFTextInputIntercepter.h"
#import "FJFTextInputViewController.h"

static const NSInteger kMaxWordLimitCount = 100;

@interface FJFTextInputViewController ()
// 提示 数字
@property (nonatomic, strong) UILabel *digitalLabel;
// introductionTextView
@property (nonatomic, strong) FJFTextView *introductionTextView;
// textInputIntercepter
@property (nonatomic, weak) FJFTextInputIntercepter *textInputIntercepter;

@end

@implementation FJFTextInputViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改个人简介";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.introductionTextView];
    [self.view addSubview:self.digitalLabel];
    self.introductionTextView.text = @"孩子，我要求你读书用功，不是因为我要你跟别人比成绩，而是因为，我希望你将来会拥有选择的权利，选择有意义、有时间的工作，而不是被迫谋生。当你的工作在你心中有意义，你就有成就感。当你的工作给你时间，不剥夺你的生活，你就有尊严。成就感和尊严，给你快乐。";

    [self.textInputIntercepter updateTextWithInputView:self.introductionTextView];
    [self.introductionTextView clearPlaceHoder];
    [self updateDigitalLabel];
}



#pragma mark - Public Methods

- (void)updateDigitalLabel {
    self.digitalLabel.text = [self generateDigitalDesc];
}

- (NSString *)generateDigitalDesc {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self.introductionTextView.text dataUsingEncoding:encoding];
    NSInteger digitalCnt = [data length];
    if (digitalCnt > kMaxWordLimitCount) {
        digitalCnt = kMaxWordLimitCount;
    }
    return [NSString stringWithFormat:@"%ld/%ld", (long)digitalCnt, (long)kMaxWordLimitCount];
}


#pragma mark - Setter / Getter

// introductionTextView 个人简介
- (FJFTextView *)introductionTextView {
    if (!_introductionTextView) {
        _introductionTextView = [[FJFTextView alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 120)];
        _introductionTextView.placeholder = @"请输入100字以内的个人简介";
        _introductionTextView.font = [UIFont systemFontOfSize:14.0f];;
        _introductionTextView.textColor = [UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1.0f];;
        _introductionTextView.tintColor = [UIColor colorWithRed:255/255.0f green:107/255.0f blue:0/255.0f alpha:1.0f];;
        _introductionTextView.textContainer.lineFragmentPadding = 0.0;


        FJFTextInputIntercepter *textInputIntercepter = [[FJFTextInputIntercepter alloc] init];
        textInputIntercepter.maxCharacterNum = kMaxWordLimitCount;
        textInputIntercepter.emojiAdmitted = NO;
        textInputIntercepter.doubleBytePerChineseCharacter = YES;
        __weak typeof(self) weakSelf = self;

        textInputIntercepter.inputBlock = ^(FJFTextInputIntercepter *textInputIntercepter, NSString *string) {
            [weakSelf updateDigitalLabel];
        };


        textInputIntercepter.beyondLimitBlock = ^(FJFTextInputIntercepter *textInputIntercepter, NSString *string) {
            
        };
        [textInputIntercepter textInputView:_introductionTextView];
        _textInputIntercepter = textInputIntercepter;
    }

    return _introductionTextView;
}


- (UILabel *)digitalLabel {
    if (!_digitalLabel) {
        CGFloat labelWidth = 60;
        CGFloat labelHeight = 30;
        CGFloat labelX = CGRectGetMaxX(self.introductionTextView.frame) - labelWidth - 12;
        CGFloat labelY = CGRectGetMaxY(self.introductionTextView.frame) - labelHeight - 12;
        _digitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
        _digitalLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
        _digitalLabel.font = [UIFont systemFontOfSize:16];
        _digitalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _digitalLabel;
}

@end
