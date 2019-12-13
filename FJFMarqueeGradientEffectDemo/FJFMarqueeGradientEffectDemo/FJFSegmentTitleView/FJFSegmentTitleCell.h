//
//  FJFSegmentTitleCell.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 05/12/2019.
//  Copyright © 2019 FJFMarqueeGradientEffectDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FJFSegmentTitleCellStyle;
@interface FJFSegmentTitleCell : UICollectionViewCell
// titleLabel
@property (nonatomic, strong) UILabel *titleLabel;
// cellStyle
@property (nonatomic, strong, readonly) FJFSegmentTitleCellStyle *cellStyle;

/// 更新 cellStyle
/// @param cellStyle 配置 参数
- (void)updateCellStyle:(FJFSegmentTitleCellStyle *)cellStyle;
@end

NS_ASSUME_NONNULL_END
