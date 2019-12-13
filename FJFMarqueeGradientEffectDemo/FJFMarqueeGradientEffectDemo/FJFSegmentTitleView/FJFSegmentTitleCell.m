
//
//  FJFSegmentTitleCell.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 05/12/2019.
//  Copyright © 2019 FJFMarqueeGradientEffectDemo. All rights reserved.
//

#import "FJFSegmentTitleCell.h"
#import "FJFSegmentTitleView.h"

@interface FJFSegmentTitleCell()
// cellStyle
@property (nonatomic, strong) FJFSegmentTitleCellStyle *cellStyle;
@end

@implementation FJFSegmentTitleCell

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
    }
    return self;
}

#pragma mark - Override Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
#pragma mark - Public Methods
- (void)updateCellStyle:(FJFSegmentTitleCellStyle *)cellStyle {
    _cellStyle = cellStyle;
    if (cellStyle) {
        [self updateViewControls];
    }
}


- (void)updateViewControls {
    if (_cellStyle.selected) {
        self.titleLabel.font = _cellStyle.textSelectedFont;
        self.titleLabel.textColor = _cellStyle.textSelectedColor;
    }
    else {
        self.titleLabel.font = _cellStyle.textFont;
        self.titleLabel.textColor = _cellStyle.textColor;
    }
     self.titleLabel.text = _cellStyle.cellTitle;
}
#pragma mark - Private Methods

- (void)setupViewControls {
    self.titleLabel.frame = self.bounds;
    [self.contentView addSubview:self.titleLabel];
}


#pragma mark - Setter / Getter
// titleLabel
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
