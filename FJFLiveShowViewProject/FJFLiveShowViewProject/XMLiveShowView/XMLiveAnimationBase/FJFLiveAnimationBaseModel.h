//
//  FJFLiveAnimationBaseModel.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFLiveAnimationBaseModel : NSObject
// 当前送礼数量
@property (nonatomic, assign) NSUInteger currentNumber;
// 是否 第一优先级 firstPriority
@property (nonatomic, assign) BOOL  firstPriority;
// 唯一key animationUniqueKey
@property (nonatomic, copy) NSString *animationUniqueKey;
@end

NS_ASSUME_NONNULL_END
