//
//  FJFExpandLabel.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 22/01/2020.
//  Copyright © 2020 macmini. All rights reserved.
//

#import "FJFExpandLabel.h"

@implementation FJFLabelAttributeStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _labelFont = [UIFont systemFontOfSize:12];
        _labelText = @"...";
        _labelTextColor = [UIColor blackColor];
    }
    return self;
}

+ (FJFLabelAttributeStyle *)configWithLabelFont:(UIFont *)labelFont
                                      labelText:(NSString *)labelText
                                 labelTextColor:(UIColor *)labelTextColor {
    FJFLabelAttributeStyle *tmpStyle = [[FJFLabelAttributeStyle alloc] init];
    tmpStyle.labelFont = labelFont;
    tmpStyle.labelText = labelText;
    tmpStyle.labelTextColor = labelTextColor;
    return tmpStyle;
}
@end


@interface FJFExpandLabelStyle()
// assignLineWidth 指定行 字符串 宽度
@property (nonatomic, assign) CGFloat assignLineWidth;
// assignLineHeight 指定行 字符串 高度
@property (nonatomic, assign) CGFloat assignLineHeight;
// beyondLimit 是否 超过 限制
@property (nonatomic, assign, getter=isBeyondLimit) BOOL beyondLimit;
// expandStatus 展开状态 展开/收起
@property (nonatomic, assign, getter=isExpandStatus) BOOL expandStatus;
@end


@implementation FJFExpandLabelStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _limitWidth = [UIScreen mainScreen].bounds.size.width - 24.0f;
        _assignLineNum = 2;
        _compareLineNum = 3;
        _expandLabelWidth = 60;
        _expandLabelHeight = 30;
        _labelShowType = FJFExpandLabelShowTypeExpandAndPickup;
        
        _expandStatus = NO;
        _contentLabelStyle = [FJFLabelAttributeStyle configWithLabelFont:[UIFont systemFontOfSize:12] labelText:@"全部" labelTextColor:[UIColor blackColor]];
        _expandLabelStyle = [FJFLabelAttributeStyle configWithLabelFont:[UIFont systemFontOfSize:20] labelText:@"全部" labelTextColor:[UIColor redColor]];
        _pickupLabelStyle = [FJFLabelAttributeStyle configWithLabelFont:[UIFont systemFontOfSize:16] labelText:@"收起" labelTextColor:[UIColor blueColor]];
        _suffixLabelStyle = [FJFLabelAttributeStyle configWithLabelFont:[UIFont systemFontOfSize:12] labelText:@"..." labelTextColor:[UIColor blackColor]];
    }
    return self;
}

- (void)updateAssignLineWidth:(CGFloat)assignLineWidth {
    self.assignLineWidth = assignLineWidth;
}

- (void)updateAssignLineHeight:(CGFloat)assignLineHeight {
    self.assignLineHeight = assignLineHeight;
}

- (void)updateIsBeyondLimit:(BOOL)beyondLimit {
    self.beyondLimit = beyondLimit;
}

- (void)updateExpandStatus:(BOOL)expandStatus {
    self.expandStatus = expandStatus;
}
@end

@interface FJFExpandLabel()
// expandButton
@property (nonatomic, strong) UIButton *expandButton;

// expandLabelStyle
@property (nonatomic, strong) FJFExpandLabelStyle *expandLabelStyle;
@end

@implementation FJFExpandLabel
#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
    }
    return self;
}


#pragma mark - Public Methods
- (void)updateLabelWithExpandLabelStyle:(FJFExpandLabelStyle *)expandLabelStyle {
    self.expandLabelStyle = expandLabelStyle;
    NSAttributedString *tmpAttributedText = [FJFExpandLabelTool generateShowContentWithExpandLabelStyle:expandLabelStyle];
    self.attributedText = tmpAttributedText;
    
    switch (expandLabelStyle.labelShowType) {
            // 正常 显示
        case FJFExpandLabelShowTypeNormal:
            self.expandButton.hidden = YES;
            break;
            // 显示 展开 收起
        case FJFExpandLabelShowTypeExpandAndPickup:
            self.expandButton.hidden = NO;
            break;
            // 只显示 展开(没有收起)
        case FJFExpandLabelShowTypeOnlyExpand:
            if (expandLabelStyle.expandStatus) {
                 self.expandButton.hidden = YES;
            } else {
                 self.expandButton.hidden = NO;
            }
            break;
            
        default:
            break;
    }
    
    CGFloat expandButtonX = expandLabelStyle.assignLineWidth;
    if (expandLabelStyle.labelShowType == FJFExpandLabelShowTypeExpandAndPickup &&
        expandLabelStyle.expandStatus) {
        expandButtonX = expandLabelStyle.assignLineWidth - expandLabelStyle.expandLabelWidth;
        if (expandButtonX < 0) {
            expandButtonX = 0;
        }
    }
    CGFloat expandButtonY = (self.frame.size.height - expandLabelStyle.assignLineHeight) / 2.0f + (expandLabelStyle.assignLineHeight - expandLabelStyle.expandLabelHeight);
    CGFloat expandButtonWidth = expandLabelStyle.expandLabelWidth;
    CGFloat expandButtonHeight = expandLabelStyle.expandLabelHeight;
    self.expandButton.frame = CGRectMake(expandButtonX, expandButtonY, expandButtonWidth, expandButtonHeight);
    [self bringSubviewToFront:self.expandButton];
}


#pragma mark - Private Methods

- (void)setupViewControls {
    self.userInteractionEnabled = YES;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:self.expandButton];
}


#pragma mark - Response Event
- (void)expandButtonClicked:(UIButton *)sender {
    [self.expandLabelStyle updateExpandStatus:!self.expandLabelStyle.expandStatus];
    [self updateLabelWithExpandLabelStyle:self.expandLabelStyle];
    if (self.expandLabelTapBlock) {
        self.expandLabelTapBlock(self.expandLabelStyle.expandStatus);
    }
}


#pragma mark - Setter / Getter
// expandButton
- (UIButton *)expandButton {
    if (!_expandButton) {
        _expandButton = [[UIButton alloc] init];
        [_expandButton addTarget:self action:@selector(expandButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _expandButton.hidden = YES;
    }
    return _expandButton;
}

@end
