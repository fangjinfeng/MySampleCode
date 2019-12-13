//
//  FJFSegmentTitleView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 05/12/2019.
//  Copyright © 2019 FJFMarqueeGradientEffectDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FJFSegmentTitleView;
@class JXCategoryTitleView;
@class FJFSegmentTitleViewStyle;

typedef void(^FJFSegmentTitleViewClickedBlock)(FJFSegmentTitleView *view, NSIndexPath *indexPath);

@interface FJFSegmentTitleCellStyle : NSObject
// cellTitle
@property (nonatomic, strong) NSString *cellTitle;
// textColor
@property (nonatomic, strong) UIColor *textColor;
// textFont
@property (nonatomic, strong) UIFont *textFont;
// textSelectedColor
@property (nonatomic, strong) UIColor *textSelectedColor;
// textSelectedFont
@property (nonatomic, strong) UIFont *textSelectedFont;
// backgroundColor
@property (nonatomic, strong) UIColor *backgroundColor;
// selected
@property (nonatomic, assign, getter=isSelected) BOOL  selected;
// cellWidth
@property (nonatomic, assign) CGFloat  cellWidth;
@end

@interface FJFSegmentTitleViewStyle : NSObject
// viewWidth
@property (nonatomic, assign) CGFloat  viewWidth;
// viewHeight
@property (nonatomic, assign) CGFloat  viewHeight;
// cellWidth (固定宽度)
@property (nonatomic, assign) CGFloat  cellWidth;
// viewBorderColor
@property (nonatomic, strong) UIColor *viewBorderColor;
// vewBorderWidth
@property (nonatomic, assign) CGFloat  viewBorderWidth;
// selectedIndex
@property (nonatomic, assign) NSInteger  selectedIndex;
// viewCornerRadius 圆角
@property (nonatomic, assign) CGFloat viewCornerRadius;
// sectionLeftEdgeSpacing
@property (nonatomic, assign) CGFloat  sectionLeftEdgeSpacing;
// sectionRightEdgeSpacing
@property (nonatomic, assign) CGFloat  sectionRightEdgeSpacing;
// innerCellSpacing
@property (nonatomic, assign) CGFloat innerCellSpacing;
// backgroundViewColor
@property (nonatomic, strong) UIColor *backgroundViewColor;
// indicatorViewBackgroundColor
@property (nonatomic, strong) UIColor  *indicatorViewBackgroundColor;
// indicatorViewBorderColor
@property (nonatomic, strong) UIColor *indicatorViewBorderColor;
// indicatorViewBorderWidth
@property (nonatomic, assign) CGFloat  indicatorViewBorderWidth;
// indicatorViewCornerRadius 圆角
@property (nonatomic, assign) CGFloat indicatorViewCornerRadius;
// indicatorViewHeight
@property (nonatomic, assign) CGFloat  indicatorViewHeight;
// indicatorViewHorizontalEdgeSpacing
@property (nonatomic, assign) CGFloat  indicatorViewHorizontalEdgeSpacing;
// cellStyleArray
@property (nonatomic, strong) NSArray <FJFSegmentTitleCellStyle *>*cellStyleArray;
// divideEquallyViewWidth 平分 长度
@property (nonatomic, assign, getter=isDivideEquallyViewWidth) BOOL  divideEquallyViewWidth;
@end

@interface FJFSegmentTitleView : UIView
// titleButtonClickedBlock
@property (nonatomic, copy) FJFSegmentTitleViewClickedBlock titleButtonClickedBlock;
// viewStyle
@property (nonatomic, strong, readonly) FJFSegmentTitleViewStyle *viewStyle;

// 更新 控件
- (void)updateViewControls;

/// 更新 viewStyle
/// @param viewStyle 配置参数
- (void)updateViewStyle:(FJFSegmentTitleViewStyle *)viewStyle;


/// 初始化
/// @param frame 位置
/// @param viewStyle viewStyle
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFSegmentTitleViewStyle *)viewStyle;
@end

NS_ASSUME_NONNULL_END
