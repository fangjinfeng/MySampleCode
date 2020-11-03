//
//  FJFSuspensionView.h
//  FJFNSEnginerProject
//
//  Created by macmini on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFSuspensionView : UIView
/// The parent View
@property(nonatomic, weak) UIView *parentView;

/// The containerWindow
@property(nonatomic, weak) UIView *containerWindow;

@end

NS_ASSUME_NONNULL_END
