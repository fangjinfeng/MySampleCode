//
//  FJFImageTableViewCell.m
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/9/27.
//  Copyright © 2021 fjf. All rights reserved.
//

#import "Masonry.h"
#import "SDWebImage.h"
#import "UIImage+DownSample.h"
#import "UIImageView+SDImage.h"
#import "FJFImageTableViewCell.h"

@interface FJFImageTableViewCell()
// imageView
@property(nonatomic, strong) UIImageView *iconImageView;
@end

@implementation FJFImageTableViewCell

#pragma mark - Life Circle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}


#pragma mark - Private Methods

- (void)setupViewControls {
    [self.contentView addSubview:self.iconImageView];
    
}

- (void)layoutViewControls {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Setter Methods
- (void)setImageUrlStr:(NSString *)imageUrlStr {
    _imageUrlStr = imageUrlStr;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"info_banner_placehold_icon"] targetSize:self.frame.size];
}

#pragma mark - Getter Methods
// imageView
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
@end
