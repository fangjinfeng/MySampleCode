//
//  FJFMineTaskIntroducePopMenuView.m
//  FJFPopMenuViewDemo
//
//  Created by macmini on 24/10/2019.
//  Copyright © 2019 FJFPopMenuViewDemo. All rights reserved.
//

#import "Masonry.h"
#import "FJFPopMenuViewHeader.h"
#import "FJFCustomPopMenuView.h"
#import "FJFCustomPopMenuStytle.h"
#import "FJFMineTaskIntroducePopMenuView.h"

@interface FJFMineTaskIntroducePopMenuView()
// containerView
@property (nonatomic, strong) UIView *containerView;
@end

static CGFloat kFJFMineTaskIntroducePopMenuViewWidth = 260.0f;

@implementation FJFMineTaskIntroducePopMenuView

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}

#pragma mark - Public Methods
+ (CGFloat)viewWidth {
    return kFJFMineTaskIntroducePopMenuViewWidth;
}


+ (CGFloat)viewHeightWithContentString:(NSString *)contentString {
    CGFloat limitWidth = kFJFMineTaskIntroducePopMenuViewWidth;
    CGFloat contentHeight = heightWithParam(FJF_PingFangRegular_Font(11.0f), limitWidth, contentString);
    return 46 + contentHeight;
}

+ (void)showTaskTipPopMenuViewWithTitleString:(NSString *)titleString
                                contentString:(NSString *)contentString
                                 showPosition:(CGPoint)showPosition {
    FJFCustomPopMenuStytle *tmpMenuStyle = [self tipPopMenuViewStyleWithContentString:contentString];
    
    FJFCustomPopMenuView *popMenuView = [[FJFCustomPopMenuView alloc] initWithContentViewHeight:tmpMenuStyle.containerContentViewHeight];
    popMenuView.customDialogStyle = tmpMenuStyle;
    FJFMineTaskIntroducePopMenuView *tipMenuView = [[FJFMineTaskIntroducePopMenuView alloc] init];
    tipMenuView.contentLabel.text = contentString;
    tipMenuView.titleLabel.text = titleString;
    __weak typeof(popMenuView) weakPopMenuView = popMenuView;
    tipMenuView.closeButtonClickedBlock = ^(UIButton *button, id value) {
        [weakPopMenuView dimissView];
    };
    [popMenuView addSubViewToContainerContentView:tipMenuView];
    [popMenuView showFromParentView:[UIApplication sharedApplication].keyWindow position:showPosition];
}

+ (FJFCustomPopMenuStytle *)tipPopMenuViewStyleWithContentString:(NSString *)contentString {
    CGFloat containerViewWidth = kFJFMineTaskIntroducePopMenuViewWidth;
    CGFloat containerViewHeight = [FJFMineTaskIntroducePopMenuView viewHeightWithContentString:contentString];
    FJFCustomPopMenuStytle *tmpStyle = [[FJFCustomPopMenuStytle alloc] init];
    tmpStyle.indicateViewHeight = 10;
    tmpStyle.indicateViewWidth = 20;
    tmpStyle.indicateViewOffsetX = containerViewWidth - 40.0f;
    tmpStyle.containerViewWidth = containerViewWidth;
    tmpStyle.containerContentViewHeight = containerViewHeight;
    tmpStyle.containerContentViewBorderWidth = 0.5f;
    tmpStyle.enableOfBackgroundButton = YES;
    tmpStyle.containerContentViewBorderColor = FJF_RGBColor(233, 234, 235);
    tmpStyle.containerViewBackgroundShadowColor = FJF_RGBColorAlpha(0, 0, 0, 0.06);
    tmpStyle.containerViewHeight = tmpStyle.indicateViewHeight + containerViewHeight;
    tmpStyle.indicateViewColor = FJF_RGBColor(255, 255, 255);
    tmpStyle.menuViewBackgroundColor = [UIColor clearColor];
    tmpStyle.containerContentViewBackgroundColor = FJF_RGBColor(255, 255, 255);
    return tmpStyle;
}


#pragma mark - Response Event
- (void)closeButtonClicked:(UIButton *)sender {
    if (self.closeButtonClickedBlock) {
        self.closeButtonClickedBlock(sender, self);
    }
}
#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.contentLabel];
    [self.containerView addSubview:self.closeButton];
}

- (void)layoutViewControls {
    
    // containerView
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // closeButton
    CGFloat buttonSize = 20.0f;
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(buttonSize);
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.containerView).mas_offset(-8.0f);
    }];
    
    // titleLabel
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).mas_offset(10);
        make.left.equalTo(self.containerView).mas_offset(12.0f);
        make.right.equalTo(self.closeButton.mas_left).mas_offset(10.0f);
    }];
    
    // contentLabel
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(8.0f);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.containerView).mas_offset(-12.0f);
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
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FJF_PingFangRegular_Font(13.0f);
        _titleLabel.textColor = FJF_RGBColor(30, 30, 30);
    }
    return _titleLabel;
}

// titleLabel
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FJF_PingFangRegular_Font(11.0f);
        _contentLabel.textColor = FJF_RGBColor(126, 126, 126);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

// titleLabel
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        _closeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_closeButton setImage:[UIImage imageNamed:@"mine_task_pop_menu_close_icon"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
@end
