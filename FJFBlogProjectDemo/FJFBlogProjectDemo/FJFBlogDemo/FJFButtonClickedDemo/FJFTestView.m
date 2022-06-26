//
//  FJFTestView.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/5/12.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "Masonry.h"
#import "FJFTestButton.h"
#import "FJFTestView.h"

@interface FJFTestView()
@property (nonatomic, strong) FJFTestButton *testButton;
@end
@implementation FJFTestView

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.testButton];
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(80);
    }];
}

- (void)layoutViewControls {

}

- (void)testButtonClicked:(UIButton *)sender {
    NSLog(@"--------------------");
}

#pragma mark - Getter Methods

- (FJFTestButton *)testButton {
    if (!_testButton) {
        _testButton = [[FJFTestButton alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
        [_testButton addTarget:nil action:@selector(testButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        [_testButton addTarget:nil action:@selector(testButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
        _testButton.backgroundColor = [UIColor redColor];
    }
    return _testButton;
}
@end
