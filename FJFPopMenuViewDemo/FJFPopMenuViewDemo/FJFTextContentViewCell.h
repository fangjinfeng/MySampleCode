//
//  FJFImageViewCell.h
//  FJFTestDemoProject
//
//  Created by macmini on 25/10/2019.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFPopMenuViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFTextContentViewCell : UITableViewCell

// buttonClickedBlock
@property (nonatomic, copy) FJFButtonClickBlock buttonClickedBlock;

/// 更新 内容 文本
/// @param contentString 内容文本
- (void)updateContentString:(NSString *)contentString;
/// 依据 文本 内容 算出 cell 高度
/// @param contentString 文本内容
+ (CGFloat)cellHeightWithContentString:(NSString *)contentString;
@end

NS_ASSUME_NONNULL_END
