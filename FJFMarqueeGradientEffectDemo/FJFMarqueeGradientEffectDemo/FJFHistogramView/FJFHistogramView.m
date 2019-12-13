

//
//  FJFHistogramView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 09/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFHistogramView.h"


@implementation FJFHistogramViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _topHistogramColor = [UIColor colorWithRed:126/255.0 green:208/255.0 blue:255/255.0 alpha:1];
        _bottomHistogramColor = [UIColor colorWithRed:255/255.0f green:138/255.0f blue:138/255.0 alpha:1];
        _defalutHistogramWidth = 3.0f;
        _singleItemViewValue = 5;
        _singleItemViewHeight = 20.0f;
        NSMutableArray *tmpFirstMarray = [NSMutableArray array];
        for (NSInteger tmpIndex = 0; tmpIndex < 5; tmpIndex++) {
            NSMutableArray *tmpSecondMarray = [NSMutableArray array];
            for (NSInteger tmpSecondIndex = 0; tmpSecondIndex < 30; tmpSecondIndex++) {
                if (tmpIndex % 2 == 0) {
                    [tmpSecondMarray addObject:[NSString stringWithFormat:@"%u", arc4random() % 15]];
                } else {
                     [tmpSecondMarray addObject:[NSString stringWithFormat:@"-%u", arc4random() % 15]];
                }
               
            }
            [tmpFirstMarray addObject:tmpSecondMarray];
        }
        _valueTextArray = tmpFirstMarray;
        _horizontalTextCount = _valueTextArray.count;
    }
    return self;
}

@end



@interface FJFHistogramView()

// viewStyle
@property (nonatomic, strong) FJFHistogramViewStyle *viewStyle;
// histogramLineViewArray 柱状图数组(二维数组)
@property (nonatomic, strong) NSArray <NSArray<UIView *> *>*histogramLineViewArray;
@end

@implementation FJFHistogramView
#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFHistogramViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
       viewStyle:(FJFHistogramViewStyle *)viewStyle{
    if (self = [super initWithFrame:frame]) {
        [self updateBackgroundViewStyle:viewStyle];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateBackgroundViewStyle:(FJFHistogramViewStyle *)viewStyle {
    _viewStyle = viewStyle;
    if (_viewStyle) {
        [self updateViewControls];
    }
}

- (void)updateViewControls {
    NSMutableArray *tmpLineViewMarray = [NSMutableArray array];
    NSInteger valueTextArrayCount = self.viewStyle.valueTextArray.count;
    NSInteger lineViewArrayCount = self.histogramLineViewArray.count;
    // 当前 文本数量 大于 之前 视图数量
    if (valueTextArrayCount >= lineViewArrayCount) {
        [self.viewStyle.valueTextArray enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger pitchIndex, BOOL * _Nonnull stop) {
          NSArray *tmpLineViewArray = [self updatePitchLineViewArrayWithPitchIndex:pitchIndex pitchLineViewArray:[self hostogramLineViewArrayWithPitchIndex:pitchIndex] pitchTextValueArray:obj];
          [tmpLineViewMarray addObject:tmpLineViewArray];
        }];
    }
    else {
        
        [self.histogramLineViewArray enumerateObjectsUsingBlock:^(NSArray<UIView *> * _Nonnull obj, NSUInteger pitchIndex, BOOL * _Nonnull stop) {
            
            if (pitchIndex < valueTextArrayCount) {
                [self updatePitchLineViewArrayWithPitchIndex:pitchIndex pitchLineViewArray:[self hostogramLineViewArrayWithPitchIndex:pitchIndex] pitchTextValueArray:self.viewStyle.valueTextArray[pitchIndex]];
            }
            else {
                [obj enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                }];
            }
            [tmpLineViewMarray addObject:obj];
        }];
    }
    self.histogramLineViewArray = tmpLineViewMarray;
}


- (NSArray <UIView *>*)hostogramLineViewArrayWithPitchIndex:(NSInteger)pitchIndex {
    NSInteger pitchLineViewArrayCount = self.histogramLineViewArray.count;
    if (pitchIndex < pitchLineViewArrayCount) {
        return self.histogramLineViewArray[pitchIndex];
    }
    return [NSArray array];
}

#pragma mark - Private Methods

- (NSArray *)updatePitchLineViewArrayWithPitchIndex:(NSInteger)pitchIndex
                            pitchLineViewArray:(NSArray <UIView *> *)pitchLineViewArray
                            pitchTextValueArray:(NSArray <NSString *>*)pitchTextValueArray {
    
    NSMutableArray *tmpLineViewMarray = [NSMutableArray array];
    NSInteger currentTextValueCount = pitchTextValueArray.count;
    NSInteger lineViewCount = pitchLineViewArray.count;

    // 如果 当前 shaperCount 大于 之前 shaperCount
    if (currentTextValueCount > lineViewCount) {

       [pitchTextValueArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           UIView *tmpView = nil;
           if (idx < lineViewCount) {
               tmpView = pitchLineViewArray[idx];
           }
           else {
               tmpView = [self lineView];
               [self addSubview:tmpView];
           }
           if (obj.floatValue < 0) {
              tmpView.backgroundColor = self.viewStyle.bottomHistogramColor;
           } else {
               tmpView.backgroundColor = self.viewStyle.topHistogramColor;
           }
           
           tmpView.hidden = NO;
           tmpView.frame = [self lineViewFramwWithPitchIndex:pitchIndex currentViewIndex:idx currentTextValue:pitchTextValueArray[idx] pitchTextValueCount:currentTextValueCount];
           [tmpLineViewMarray addObject:tmpView];
       }];
    }
    // 如果 当前 shaperCount 小于等于 之前 shaperCount
    else {
       
       [pitchLineViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           if (idx < currentTextValueCount) {
                obj.hidden = NO;

                NSString *pitchTextValue = pitchTextValueArray[idx];
                obj.frame = [self lineViewFramwWithPitchIndex:pitchIndex currentViewIndex:idx currentTextValue:pitchTextValue pitchTextValueCount:currentTextValueCount];
                   
                if (pitchTextValue.floatValue < 0) {
                   obj.backgroundColor = self.viewStyle.bottomHistogramColor;
                } else {
                    obj.backgroundColor = self.viewStyle.topHistogramColor;
                }
               
           } else {
               obj.hidden = YES;
           }
           [tmpLineViewMarray addObject:obj];
       }];
    }
    return tmpLineViewMarray;
}


- (CGRect)lineViewFramwWithPitchIndex:(NSInteger)pitchIndex
                     currentViewIndex:(NSInteger)currentViewIndex
                     currentTextValue:(NSString *)currentTextValue
                  pitchTextValueCount:(NSInteger)pitchTextValueCount {
    // 柱状图 最大 高度
    CGFloat histogramLimitMaxHeight = self.frame.size.height / 2.0f;
    // 每一节 宽度
    CGFloat pitchViewWidth = self.frame.size.width / self.viewStyle.horizontalTextCount;
    // 柱条宽度
    CGFloat histogramLineViewWidth = pitchViewWidth / (pitchTextValueCount * 1.0f);
    if (histogramLineViewWidth > self.viewStyle.defalutHistogramWidth) {
        histogramLineViewWidth = self.viewStyle.defalutHistogramWidth;
    }
    
    CGFloat viewX = (pitchIndex * pitchViewWidth) + histogramLineViewWidth * currentViewIndex;
    CGFloat currentValue = currentTextValue.floatValue;
    CGFloat viewY = histogramLimitMaxHeight - ((currentValue / _viewStyle.singleItemViewValue) * _viewStyle.singleItemViewHeight);
    if (!self.viewStyle.isAllowBeyondLimitHeight) {
        if (viewY < 0) {
            viewY = 0;
        }
    }
    CGFloat viewHeight = histogramLimitMaxHeight - viewY;
    if (currentValue < 0) {
        viewY = histogramLimitMaxHeight;
        viewHeight = (fabs(currentValue) / _viewStyle.singleItemViewValue) * _viewStyle.singleItemViewHeight;
        if (!self.viewStyle.isAllowBeyondLimitHeight) {
            if (viewHeight > histogramLimitMaxHeight) {
                viewHeight = histogramLimitMaxHeight;
            }
        }
    }
    
    return CGRectMake(viewX, viewY, histogramLineViewWidth, viewHeight);
}
                       


#pragma mark - Setter / Getter

- (UIView *)lineView {
    return [[UIView alloc] init];
}
@end
