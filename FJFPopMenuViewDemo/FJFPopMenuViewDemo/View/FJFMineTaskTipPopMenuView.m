
//
//  FJFMineTaskTipPopMenuView.m
//  FJFPopMenuViewDemo
//
//  Created by macmini on 24/10/2019.
//  Copyright © 2019 FJFPopMenuViewDemo. All rights reserved.
//

#import "Masonry.h"
#import "FJFPopMenuViewHeader.h"
#import "FJFCustomPopMenuView.h"
#import "FJFCustomPopMenuStytle.h"
#import "FJFMineTaskTipPopMenuView.h"


@interface FJFMineTaskTipPopMenuView()
// containerView
@property (nonatomic, strong) UIView *containerView;
@end

// 限制 宽度
static CGFloat kFJFMineTaskTipPopMenuViewWidth = 180.0f;

@implementation FJFMineTaskTipPopMenuView

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}

#pragma mark - Public Methods
+ (CGFloat)viewHeightWithContentString:(NSString *)contentString {
    CGFloat limitWidth = kFJFMineTaskTipPopMenuViewWidth;
    CGFloat contentHeight = heightWithParam(FJF_PingFangRegular_Font(10.0f), limitWidth, contentString);
    return 6 + contentHeight;
}

+ (CGFloat)viewWidthWithContentString:(NSString *)contentString {

    return  widthWithParam(FJF_PingFangRegular_Font(10.0f), MAXFLOAT, contentString) + 16.0f;;
}

+ (void)showTaskTipPopMenuViewWithContentString:(NSString *)contentString showPosition:(CGPoint)showPosition{
    FJFCustomPopMenuStytle *tmpMenuStyle = [self tipPopMenuViewStyleWithContentString:contentString];
    
    FJFCustomPopMenuView *popMenuView = [[FJFCustomPopMenuView alloc] initWithContentViewHeight:tmpMenuStyle.containerContentViewHeight];
    popMenuView.customDialogStyle = tmpMenuStyle;
    FJFMineTaskTipPopMenuView *tipMenuView = [[FJFMineTaskTipPopMenuView alloc] init];
    tipMenuView.contentLabel.text = contentString;
    [popMenuView addSubViewToContainerContentView:tipMenuView];
    [popMenuView showFromParentView:[UIApplication sharedApplication].keyWindow position:showPosition];
}

+ (FJFCustomPopMenuStytle *)tipPopMenuViewStyleWithContentString:(NSString *)contentString {
    CGFloat containerViewWidth = [FJFMineTaskTipPopMenuView viewWidthWithContentString:contentString];
    CGFloat containerViewHeight = [FJFMineTaskTipPopMenuView viewHeightWithContentString:contentString];
    FJFCustomPopMenuStytle *tmpStyle = [[FJFCustomPopMenuStytle alloc] init];
    tmpStyle.indicateViewHeight = 3.0f;
    tmpStyle.indicateViewWidth = 5.0f;
    tmpStyle.indicateViewOffsetX = 12.0f;
    tmpStyle.containerContentViewCornerRadius = 2.0f;
    tmpStyle.containerViewWidth = containerViewWidth;
    tmpStyle.containerContentViewHeight = containerViewHeight;
    tmpStyle.containerViewHeight = tmpStyle.indicateViewHeight + containerViewHeight;
    tmpStyle.indicateViewColor = FJF_RGBColor(126, 126, 126);
    tmpStyle.menuViewBackgroundColor = [UIColor clearColor];
    tmpStyle.containerContentViewBackgroundColor = FJF_RGBColor(126, 126, 126);
    return tmpStyle;
}
#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.contentLabel];
}

- (void)layoutViewControls {
    // containerView
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self);
    }];
    // contentLabel
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.containerView);
    }];
}


#pragma mark - Setter / Getter
// containerView
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

// titleLabel
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FJF_PingFangRegular_Font(10.0f);
        _contentLabel.textColor = FJF_RGBColor(255, 255, 255);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
@end
