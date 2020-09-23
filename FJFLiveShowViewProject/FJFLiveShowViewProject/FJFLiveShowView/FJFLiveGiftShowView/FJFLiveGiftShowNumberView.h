//
//  FJFLiveGiftShowNumberView.h
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/24/20.
//  Copyright © 2020 macmini. All rights reserved.
//  弹幕效果数字变化的视图

#import <UIKit/UIKit.h>

@interface FJFLiveGiftShowNumberView : UIView

@property (nonatomic ,assign) NSInteger number;/**< 初始化数字 */


/**
 改变数字显示

 @param numberStr 显示的数字
 */
- (void)changeNumber:(NSInteger )numberStr;



@end
