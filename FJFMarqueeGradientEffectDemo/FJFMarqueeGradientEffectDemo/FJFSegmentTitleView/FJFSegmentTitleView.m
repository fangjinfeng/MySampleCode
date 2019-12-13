

//
//  FJFSegmentTitleView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 05/12/2019.
//  Copyright © 2019 FJFMarqueeGradientEffectDemo. All rights reserved.
//

#import "FJFSegmentTitleView.h"
#import "FJFSegmentTitleCell.h"

@implementation FJFSegmentTitleCellStyle
#pragma mark - Life Circle
- (instancetype)init {
    if(self = [super init]) {
        _cellTitle = @"";
        _textColor = [UIColor colorWithRed:126/255.0f green:126/255.0f blue:126/255.0f alpha:1.0f];
        _textFont = [UIFont systemFontOfSize:10];
        _textSelectedFont = [UIFont systemFontOfSize:10];
        _textSelectedColor = [UIColor colorWithRed:255/255.0f green:108/255.0f blue:126/255.0f alpha:1.0f];
        _backgroundColor = [UIColor clearColor];
        _selected = NO;
    }
    return self;
}
@end

@implementation FJFSegmentTitleViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _viewWidth = 133.0f;
        _viewHeight = 24.0f;
        _viewBorderColor = [UIColor clearColor];
        _viewBorderWidth = 0;
        _viewCornerRadius = 12.0f;
        _sectionLeftEdgeSpacing = 0.0f;
        _sectionRightEdgeSpacing = 0.0f;
        _innerCellSpacing = 0.0f;
        _divideEquallyViewWidth = YES;
        _selectedIndex = 0;
        _backgroundViewColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
        
        _indicatorViewBackgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
        _indicatorViewBorderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.06];
        _indicatorViewBorderWidth = 0.5f;
        _indicatorViewCornerRadius = 10.5f;
        _indicatorViewHeight = 22.0f;
        _indicatorViewHorizontalEdgeSpacing = 2.0f;
        
        NSMutableArray *tmpMarray = [NSMutableArray array];
        FJFSegmentTitleCellStyle *firstCellStyle = [[FJFSegmentTitleCellStyle alloc] init];
        firstCellStyle.cellTitle = @"近7天";
        [tmpMarray addObject:firstCellStyle];
        
        FJFSegmentTitleCellStyle *secondCellStyle = [[FJFSegmentTitleCellStyle alloc] init];
        secondCellStyle.cellTitle = @"近30天";
        [tmpMarray addObject:secondCellStyle];

        FJFSegmentTitleCellStyle *threeCellStyle = [[FJFSegmentTitleCellStyle alloc] init];
        threeCellStyle.cellTitle = @"近90天";
        [tmpMarray addObject:threeCellStyle];
        _cellStyleArray = tmpMarray;
    }
    return self;
}

@end

@interface FJFSegmentTitleView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
// currentSelectedIndex
@property (nonatomic, assign) NSInteger  currentSelectedIndex;
// viewStyle
@property (nonatomic, strong) FJFSegmentTitleViewStyle *viewStyle;
// indicatorView
@property (nonatomic, strong) UIView *indicatorView;
// titleCollectionView 标题栏
@property (nonatomic, strong) UICollectionView *titleCollectionView;
@end

@implementation FJFSegmentTitleView
#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFSegmentTitleViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFSegmentTitleViewStyle *)viewStyle {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateViewStyle:viewStyle];
    }
    return self;
}

#pragma mark - Override Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateViewControls];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewStyle.cellStyleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FJFSegmentTitleCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FJFSegmentTitleCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(FJFSegmentTitleCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell updateCellStyle:self.viewStyle.cellStyleArray[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self updageCellSelectedStatusWithIndexPath:indexPath];
    [self updageCellStyleCellWidth];
    [self updateViewControlsPositionWithAnimated:YES];
    if (self.titleButtonClickedBlock) {
        self.titleButtonClickedBlock(self, indexPath);
    }
    [collectionView reloadData];
}


#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.viewStyle.sectionLeftEdgeSpacing, 0, self.viewStyle.sectionRightEdgeSpacing);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.viewStyle.cellStyleArray[indexPath.item].cellWidth, self.titleCollectionView.bounds.size.height);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.viewStyle.innerCellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.viewStyle.innerCellSpacing;
}


#pragma mark - Public Methods
- (void)updateViewStyle:(FJFSegmentTitleViewStyle *)viewStyle {
    _viewStyle = viewStyle;
    if (_viewStyle) {
        [self updateViewControls];
    }
}


// 更新 控件
- (void)updateViewControls {
    [self updageCellSelectedStatusWithIndexPath:[NSIndexPath indexPathForRow:_viewStyle.selectedIndex inSection:0]];
    
    // 更新 背景 颜色
    self.titleCollectionView.backgroundColor = self.viewStyle.backgroundViewColor;
    self.titleCollectionView.layer.borderColor = self.viewStyle.viewBorderColor.CGColor;
    self.titleCollectionView.layer.borderWidth = self.viewStyle.viewBorderWidth;
    self.titleCollectionView.layer.cornerRadius = self.viewStyle.viewCornerRadius;
    
    // 更新 指示器
    self.indicatorView.backgroundColor = self.viewStyle.indicatorViewBackgroundColor;
    self.indicatorView.layer.borderColor = self.viewStyle.indicatorViewBorderColor.CGColor;
    self.indicatorView.layer.borderWidth = self.viewStyle.indicatorViewBorderWidth;
    self.indicatorView.layer.cornerRadius = self.viewStyle.indicatorViewCornerRadius;
    // 更新 cell 宽度
    [self updageCellStyleCellWidth];
    // 更新 控件  未知
    [self updateViewControlsPositionWithAnimated:NO];
    // 更新
    [self.titleCollectionView reloadData];
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self.titleCollectionView addSubview:self.indicatorView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.titleCollectionView sendSubviewToBack:self.indicatorView];
    });
    [self addSubview:self.titleCollectionView];
}

- (void)updateViewControlsPositionWithAnimated:(BOOL)animated {
    // titleCategoryView
    CGFloat collectionViewWidth =  self.viewStyle.viewWidth;
    CGFloat collectionViewHeight = self.viewStyle.viewHeight;
    CGFloat collectionViewX = (self.frame.size.width - collectionViewWidth) / 2.0f;
    CGFloat collectionViewY = (self.frame.size.height - collectionViewHeight) / 2.0f;
    self.titleCollectionView.frame = CGRectMake(collectionViewX, collectionViewY, collectionViewWidth, collectionViewHeight);
    
    // indicatorView
    CGFloat indicatorViewHeight = self.viewStyle.indicatorViewHeight;
    CGFloat indicatorViewY = (self.viewStyle.viewHeight - indicatorViewHeight) / 2.0f;
    CGFloat indicatorViewX = [self indicatorViewFrameX];
    CGFloat indicatorViewWidth = self.viewStyle.cellStyleArray[self.currentSelectedIndex].cellWidth - (2 * self.viewStyle.indicatorViewHorizontalEdgeSpacing);
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
             self.indicatorView.frame = CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight);
        }];
    } else {
         self.indicatorView.frame = CGRectMake(indicatorViewX, indicatorViewY, indicatorViewWidth, indicatorViewHeight);
    }
}


- (CGFloat)indicatorViewFrameX {
    __block CGFloat currentOffsetX = self.viewStyle.sectionLeftEdgeSpacing;
    [self.viewStyle.cellStyleArray enumerateObjectsUsingBlock:^(FJFSegmentTitleCellStyle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.currentSelectedIndex) {
            currentOffsetX += (obj.cellWidth + self.viewStyle.innerCellSpacing);
        }
    }];
    return currentOffsetX + self.viewStyle.indicatorViewHorizontalEdgeSpacing;
}

+ (CGFloat)widthForFont:(UIFont *)font
             maxWidth:(float)maxWidth
        contentString:(NSString *)contentString {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat width = [contentString boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}

- (void)updageCellSelectedStatusWithIndexPath:(NSIndexPath *)indexPath {
    [self.viewStyle.cellStyleArray enumerateObjectsUsingBlock:^(FJFSegmentTitleCellStyle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            obj.selected = YES;
        }
        else {
            obj.selected = NO;
        }
    }];
    self.currentSelectedIndex = indexPath.row;
}

// 更新 cell 宽度
- (void)updageCellStyleCellWidth {
    // 标题 平均 宽度
    __block CGFloat totalTitleWidth = 0;
    [self.viewStyle.cellStyleArray enumerateObjectsUsingBlock:^(FJFSegmentTitleCellStyle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       CGFloat titleWidth = self.viewStyle.cellWidth;
       // 如果 平分 宽度
       if (self.viewStyle.divideEquallyViewWidth) {
           if (obj.selected) {
               titleWidth = [FJFSegmentTitleView widthForFont:obj.textSelectedFont maxWidth:MAXFLOAT contentString:obj.cellTitle];
           } else {
               titleWidth = [FJFSegmentTitleView widthForFont:obj.textFont maxWidth:MAXFLOAT contentString:obj.cellTitle];
           }
       }
       
       obj.cellWidth = titleWidth;
       totalTitleWidth += titleWidth;
    }];
    totalTitleWidth = totalTitleWidth + self.viewStyle.sectionLeftEdgeSpacing + self.viewStyle.sectionRightEdgeSpacing;
    totalTitleWidth = totalTitleWidth + (self.viewStyle.cellStyleArray.count - 1) * self.viewStyle.innerCellSpacing;

    // 如果 小于 viewWidth 并且 平分 宽度
    if (totalTitleWidth < self.viewStyle.viewWidth &&
       self.viewStyle.divideEquallyViewWidth) {
        CGFloat totalItemSpacing = (self.viewStyle.cellStyleArray.count - 1) * self.viewStyle.innerCellSpacing;
        CGFloat totalCellWidth =  (self.viewStyle.viewWidth - self.viewStyle.sectionLeftEdgeSpacing - self.viewStyle.sectionRightEdgeSpacing - totalItemSpacing);
        CGFloat cellWidth = totalCellWidth / self.viewStyle.cellStyleArray.count;
       [self.viewStyle.cellStyleArray enumerateObjectsUsingBlock:^(FJFSegmentTitleCellStyle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           obj.cellWidth = cellWidth;
       }];
    }
}
#pragma mark - Setter / Gettet

// indicatorView
- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
    }
    return _indicatorView;
}


// titleCollectionView
- (UICollectionView *)titleCollectionView {
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _titleCollectionView.backgroundColor = [UIColor clearColor];
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
        _titleCollectionView.showsVerticalScrollIndicator = NO;
        _titleCollectionView.scrollsToTop = NO;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.delegate = self;
        [_titleCollectionView registerClass:[FJFSegmentTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([FJFSegmentTitleCell class])];
        if (@available(iOS 10.0, *)) {
           _titleCollectionView.prefetchingEnabled = NO;
        }
        if (@available(iOS 11.0, *)) {
           _titleCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _titleCollectionView.backgroundColor = [UIColor redColor];
    }
    return _titleCollectionView;
}

@end
