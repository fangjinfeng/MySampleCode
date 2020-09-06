//
//  FJFLiveGiftModel.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/21/20.
//  Copyright © 2020 FJFLiveShowViewProject. All rights reserved.
//

#import "FJFLiveAnimationBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFLiveGiftShowModel : FJFLiveAnimationBaseModel

// sendName
@property (nonatomic, copy) NSString *sendName;

// giftName
@property (nonatomic, copy) NSString *giftName;

// headImageName
@property (nonatomic, copy) NSString *headImageName;

// giftImageName
@property (nonatomic, copy) NSString *giftImageName;

// backImageName
@property (nonatomic, copy) NSString *backImageName;

// needOverlayNumber 是否 需要叠加数字
@property (nonatomic, assign, getter=isNeedOverlayNumber) BOOL  needOverlayNumber;
@end

NS_ASSUME_NONNULL_END
