
//
//  FJFImageViewCell.m
//  FJFTestDemoProject
//
//  Created by macmini on 25/10/2019.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import "Masonry.h"
#import "FJFTextContentViewCell.h"

@interface FJFTextContentViewCell()

// operateButton
@property (nonatomic, strong) UIButton *operateButton;
// contentLabel
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation FJFTextContentViewCell

#pragma mark - Life Circle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}

#pragma mark - Public Methods
+ (CGFloat)cellHeightWithContentString:(NSString *)contentString {
    CGFloat limitWidth = [UIScreen mainScreen].bounds.size.width - 100.0f;
    CGFloat contentWidth = [self heightForFont:[UIFont systemFontOfSize:16.0f] widthLimit:limitWidth contentString:contentString] + 20.0f;
    return contentWidth;
}

- (void)updateContentString:(NSString *)contentString {
    self.contentLabel.text = contentString;
}

#pragma mark - Response Event

- (void)operateButtonClicked:(UIButton *)sender {
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(sender, self);
    }
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self.contentView addSubview:self.operateButton];
    [self.contentView addSubview:self.contentLabel];
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutViewControls {
    [self.operateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-10.0f);
        make.width.mas_equalTo(80.0f);
        make.height.mas_equalTo(36.0f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.contentView);
       make.left.equalTo(self.contentView).mas_offset(10.0f);
       make.right.equalTo(self.operateButton.mas_left).mas_offset(-10.0f);
    }];
}


+ (float)heightForFont:(UIFont *)font
            widthLimit:(float)widthLimit
        contentString:(NSString *)contentString {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat height = [contentString boundingRectWithSize:CGSizeMake(widthLimit, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}

#pragma mark - Setter / Getter

// contentLabel
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithRed:30/255 green:30/255 blue:30/255 alpha:1.0f];
        _contentLabel.font = [UIFont systemFontOfSize:16.0f];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}


// operateButton
- (UIButton *)operateButton {
    if (!_operateButton) {
        _operateButton = [[UIButton alloc] init];
        [_operateButton addTarget:self action:@selector(operateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_operateButton setTitle:@"已完成" forState:UIControlStateNormal];
        _operateButton.layer.cornerRadius = 18.0f;
        _operateButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _operateButton.backgroundColor = [UIColor redColor];
    }
    return _operateButton;
}

@end
