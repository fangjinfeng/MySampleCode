
//
//  FJFTopContainerView.m
//  FJFBlogProjectDemo
//
//  Created by 方金峰 on 2019/3/26.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFTopContainerView.h"

@interface FJFTopContainerView()
// titleLabel
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation FJFTopContainerView

#pragma mark -------------------------- Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
    }
    return self;
}

#pragma mark -------------------------- Public Methods
+ (CGFloat)viewHeight {
    return 160.0f;
}
#pragma mark -------------------------- Private Methods

- (void)setupViewControls {
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"顶部视图";
    [self addSubview:_titleLabel];
}


@end
