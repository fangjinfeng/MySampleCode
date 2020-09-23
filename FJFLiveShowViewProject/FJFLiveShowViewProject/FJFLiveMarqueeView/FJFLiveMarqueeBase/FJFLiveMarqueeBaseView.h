//
//  FJFLiveMarqueeBaseView.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/8/20.
//  Copyright © 2020 FJFLiveShowViewProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFLiveMarqueeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFLiveMarqueeBaseView : UIView
// 视图创建时间
@property (nonatomic ,copy) NSDate * creatDate;
// 视图尺寸
@property (nonatomic, assign) CGSize  baseViewSize;
// 数据源
@property (nonatomic ,strong) FJFLiveMarqueeBaseModel *marqueeModel;
/// 算出 视图 尺寸
- (void)sizeToFit;
/// 更新 相关 属性
/// @param marqueeModel 模型
- (void)updateControlsWithMarqueeModel:(FJFLiveMarqueeBaseModel *)marqueeModel;
@end

NS_ASSUME_NONNULL_END
