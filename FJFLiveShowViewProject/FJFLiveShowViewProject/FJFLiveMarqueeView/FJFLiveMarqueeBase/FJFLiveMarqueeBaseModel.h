//
//  FJFLiveMarqueeBaseModel.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/16/20.
//  Copyright © 2020 macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FJFLiveMarqueeBaseView;
@class FJFLiveMarqueeBaseModel;

typedef void(^animationViewTouchedAction)(__weak FJFLiveMarqueeBaseModel * _Nullable baseModel, __weak FJFLiveMarqueeBaseView * _Nullable marqueeView);

NS_ASSUME_NONNULL_BEGIN

@interface FJFLiveMarqueeBaseModel : NSObject
// 是否 第一优先级 firstPriority
@property (nonatomic, assign) BOOL  firstPriority;
// 唯一key animationUniqueKey
@property (nonatomic, copy) NSString *animationUniqueKey;
/// 视图 点击 回调 viewTouchedAction
@property (nonatomic, copy, nullable) animationViewTouchedAction viewTouchedAction;
@end

NS_ASSUME_NONNULL_END
