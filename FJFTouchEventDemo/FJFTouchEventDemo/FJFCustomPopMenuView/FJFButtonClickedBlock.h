//
//  FJFButtonClickedBlock.h
//  fjf-Driver
//
//  Created by 方金峰 on 2018/9/12.
//  Copyright © 2018年 fjf. All rights reserved.
//

#ifndef FJFButtonClickedBlock_h
#define FJFButtonClickedBlock_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef void(^FJFButtonClickBlock)(UIButton *button, id value);

typedef void(^FJFGestureTapBlock)(UIView *tapView, id value);

typedef void(^FJFViewControllerBlock)(UIViewController *viewController, id value);

typedef void(^FJFTableViewCellBlock)(UITableView *tableView, NSIndexPath *indexPath, id value);


// 设置 十六 进制 RGB 颜色 和 透明度
#define kFJFColorValueAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


#endif /* FJFButtonClickedBlock_h */
