//
//  FJFGiftMarqueeView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/8/20.
//  Copyright © 2020 macmini. All rights reserved.
//

#import "FJFGiftMarqueeModel.h"
#import "FJFGiftMarqueeView.h"

@interface FJFGiftMarqueeView()
// contentLabel
@property (nonatomic, strong) UILabel *contentLabel;
// backImageView
@property (nonatomic, strong) UIImageView *backImageView;
@end

@implementation FJFGiftMarqueeView

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}

#pragma mark - Public Methods

- (void)updateControlsWithMarqueeModel:(FJFLiveMarqueeBaseModel *)marqueeModel {
    [super updateControlsWithMarqueeModel:marqueeModel];
    if ([marqueeModel isKindOfClass:[FJFGiftMarqueeModel class]]) {
        FJFGiftMarqueeModel *showModel = (FJFGiftMarqueeModel *)marqueeModel;
        self.contentLabel.text = showModel.giftMessage;
        [self layoutViewControls];
    }
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.backImageView];
    [self addSubview:self.contentLabel];
}

- (void)layoutViewControls {
    CGFloat backImageViewHeight = 53;
    
    CGFloat contentLabelWidth = [FJFGiftMarqueeView getWidthWithFont:[UIFont systemFontOfSize:12] text:self.contentLabel.text maxWidth:CGFLOAT_MAX];
    CGFloat contentLabelX = 20;
    CGFloat contentLabelHeight = 20;
    CGFloat contentLabelY =  ((backImageViewHeight - contentLabelHeight) / 2.0);
    self.contentLabel.frame = CGRectMake(contentLabelX, contentLabelY, contentLabelWidth, contentLabelHeight);
    
    CGFloat backImageViewWidth = contentLabelWidth + 40;
    self.backImageView.frame = CGRectMake(0, 0, backImageViewWidth, 40);
}

#pragma mark - Getter Methods

/**
 * 宽度计算
 */
+ (CGFloat)getWidthWithFont:(UIFont *)font
                       text:(NSString *)text
                   maxWidth:(float)maxWidth  {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat width = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}


// contentLabel
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}


// backImageView
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"fjf_anchor_gift_knight_icon"];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
    }
    return _backImageView;
}

@end
