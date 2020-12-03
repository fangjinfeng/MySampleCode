//
//  FJFLiveMarqueeContainerView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/8/20.
//  Copyright © 2020 FJFLiveShowViewProject. All rights reserved.
//

#import "FJFLiveMarqueeContainerView.h"
#define fjf_live_marquee_signal(sema) dispatch_semaphore_signal(sema);
#define fjf_live_marquee_wait(sema) dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

@implementation FJFLiveMarqueeViewStyle

#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _appearAnimationTime = 3;
        _maxShowLiveViewCount = 1;
        _liveViewWidth = 200;
        _liveViewHeight = 53;
        _showMaxHeight = 53;
        _appearModel = FJFLiveMarqueeAppearModeRight;
        _maxWaitLiveViewCount = 100;
    }
    return self;
}
@end

@interface FJFLiveMarqueeContainerView()
// 操作 锁
@property (nonatomic, strong) dispatch_semaphore_t lock;
// viewStyle
@property (nonatomic, strong) FJFLiveMarqueeViewStyle *viewStyle;
// 最新 展示 跑马灯 marqueeLastestView
@property (nonatomic, strong) FJFLiveMarqueeBaseView *marqueeLastestView;
// 当前 显示 视图 字典
@property (nonatomic ,strong) NSMutableDictionary <NSString *, FJFLiveMarqueeBaseView *> *showViewMdict;
// 当前 显示 视图 队列
@property (nonatomic ,strong) NSMutableArray <FJFLiveMarqueeBaseView *> *showViewMarry;
// 当前等待展示 动画
@property (nonatomic, strong) NSMutableArray <FJFLiveMarqueeBaseModel *> *waitShowMarry;
@end

@implementation FJFLiveMarqueeContainerView

#pragma mark - Life Circle

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFLiveMarqueeViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFLiveMarqueeViewStyle *)viewStyle {
    if (self = [super initWithFrame:frame]) {
       _viewStyle = viewStyle;
       self.lock = dispatch_semaphore_create(1);
    }
    return self;
}

#pragma mark - Override Methods
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    [self responseContainerViewHitTestWithPoint:point];
     return [super hitTest:point withEvent:event];
}

#pragma mark - Public Methods

- (void)addMarqueeModel:(FJFLiveMarqueeBaseModel *)marqueeModel {
    if (!marqueeModel || ![marqueeModel isKindOfClass:[FJFLiveMarqueeBaseModel class]]) {
        return;
    }
    FJFLiveMarqueeBaseView *oldShowView = [self.showViewMdict objectForKey:marqueeModel.animationUniqueKey];
    // 如果存在旧视图，更新旧视图
    if (oldShowView && [oldShowView isKindOfClass:[FJFLiveMarqueeBaseView class]]) {
        [oldShowView updateControlsWithMarqueeModel:marqueeModel];
    }
    else { // 新模型
        // 如果 超出 限制
        if (self.showViewMarry.count >= self.viewStyle.maxShowLiveViewCount) {
            [self addToWaitMarrayWithShowModel:marqueeModel];
        } else { // 不超出限制
            [self addNewLiveViewWithShowModel:marqueeModel];
        }
    }
}

// 添加 新的视图
- (void)addNewLiveViewWithShowModel:(FJFLiveMarqueeBaseModel *)showModel {
    //计算视图x值
    CGFloat  showViewX = 0;
    CGFloat  showViewY = [self marqueeViewOffsetY];
    //创建新模型
    if (_viewStyle.appearModel == FJFLiveMarqueeAppearModeLeft) {
        showViewX =  -_viewStyle.liveViewWidth;
    } else if(_viewStyle.appearModel == FJFLiveMarqueeAppearModeRight) {
        showViewX = [UIScreen mainScreen].bounds.size.width + _viewStyle.liveViewWidth;
    }
    CGRect frame = CGRectMake(showViewX, showViewY, self.viewStyle.liveViewWidth, self.viewStyle.liveViewHeight);
    FJFLiveMarqueeBaseView *newShowView = nil;
    if (self.marqueeViewBlock) {
       newShowView = self.marqueeViewBlock();
    } else {
       newShowView = [[FJFLiveMarqueeBaseView alloc] initWithFrame:frame];
    }
    //赋值
    newShowView.frame = frame;
    [newShowView updateControlsWithMarqueeModel:showModel];
    // 显示 显示图
    [self appearWith:newShowView];

    [self addSubview:newShowView];
    [self addToShowViewDataWithLiveView:newShowView];
    // 更新 排序
    [self sortShowArr];
    // 更新 最近 显示 的跑马灯
    [self updateMarqueeLastestView];
}

- (void)removeCurrentShowViewWithShowView:(FJFLiveMarqueeBaseView *)showView {
    [showView removeFromSuperview];
    // 从显示数据源移除
    [self removeFromShowViewDataWithLiveView:showView];
    // 更新数据源 当移除时
    [self updateDataSouceArrayWhenRemove];
    //比较数量大小排序
    [self sortShowArr];
    // 更新 最近 显示 的跑马灯
    [self updateMarqueeLastestView];
}

// 跑马灯 偏移值
- (CGFloat)marqueeViewOffsetY {
    CGFloat offsetY = 0.0f;
    CGFloat renderViewHeight = self.viewStyle.showMaxHeight;
    CGFloat cellHeight = self.viewStyle.liveViewHeight;
    switch (self.viewStyle.marqueePositionType) {
        case FJFLiveMarqueePositionTypeRandomTracks: {
            int trackCount = floorf(renderViewHeight/cellHeight);
            int trackIndex = arc4random_uniform(trackCount);
            offsetY = trackIndex * cellHeight;
        }
            break;
        case FJFLiveMarqueePositionTypeRandom: {
            CGFloat maxY = renderViewHeight - cellHeight;
            int originY = floorl(maxY);
            offsetY = arc4random_uniform(originY);
        }
            break;
        case FJFLiveMarqueePositionTypeIncrease:
            if (_marqueeLastestView) {
                CGRect lastestFrame = _marqueeLastestView.frame;
                offsetY = CGRectGetMaxY(lastestFrame);
                if (offsetY > renderViewHeight) {
                    offsetY = 0;
                }
            }
            break;
            
        default:
            break;
    }
    return offsetY;
}
#pragma mark - Private Methods

// 更新 最近 显示 跑马灯
- (void)updateMarqueeLastestView {
    fjf_live_marquee_wait(self.lock);
    self.marqueeLastestView = [self.showViewMarry lastObject];
    fjf_live_marquee_signal(self.lock);
}

- (void)appearWith:(FJFLiveMarqueeBaseView *)showView {
    // 出现的动画
    if (_viewStyle.appearModel == FJFLiveMarqueeAppearModeLeft ||
        _viewStyle.appearModel == FJFLiveMarqueeAppearModeRight) {

        if (self.appearAnimationBlock) {
            self.appearAnimationBlock(self, showView, _viewStyle);
        } else {
           CGFloat offsetX = - self.viewStyle.liveViewWidth;
           if (_viewStyle.appearModel == FJFLiveMarqueeAppearModeLeft) {
               offsetX = [UIScreen mainScreen].bounds.size.width + self.viewStyle.liveViewWidth;
           }
           [UIView animateWithDuration:self.viewStyle.appearAnimationTime animations:^{
               CGRect f = showView.frame;
               f.origin.x = offsetX;
               showView.frame = f;
           } completion:^(BOOL finished) {
               [self removeCurrentShowViewWithShowView:showView];
           }];
        }
    } else {
        CGRect f = showView.frame;
        f.origin.x = 0;
        showView.frame = f;
    }
}

// 添加到等待队列
- (void)addToWaitMarrayWithShowModel:(FJFLiveMarqueeBaseModel *)showModel {
    if (!showModel) {
        return;
    }
    NSString * key = showModel.animationUniqueKey;
    NSMutableArray *tmpWaitMarray = [NSMutableArray arrayWithArray:self.waitShowMarry];
    for (NSUInteger i = 0; i < tmpWaitMarray.count; i++) {
        FJFLiveMarqueeBaseModel *oldModel = tmpWaitMarray[i];
        NSString * oldKey = oldModel.animationUniqueKey;
        if ([oldKey isEqualToString:key]) {
            [self removeFromWaitDataWithLiveModel:oldModel];
            break;
        }
    }
    [self addFromWaitDataWithLiveModel:showModel];
}


- (void)sortShowArr{
     fjf_live_marquee_wait(self.lock);
    //排序 最小的时间在第一个
    NSArray * sortArr = [self.showViewMarry sortedArrayUsingComparator:^NSComparisonResult(FJFLiveMarqueeBaseView * obj1, FJFLiveMarqueeBaseView * obj2) {
        NSComparisonResult result = [[NSNumber numberWithBool:obj2.marqueeModel.firstPriority] compare:[NSNumber numberWithBool:obj1.marqueeModel.firstPriority]];
        if (result == NSOrderedSame) {
            return [obj1.creatDate compare:obj2.creatDate];
        }
        return result;
    }];
    self.showViewMarry = [NSMutableArray arrayWithArray:sortArr];

    NSArray *waitSortArray = [self.waitShowMarry sortedArrayUsingComparator:^NSComparisonResult(FJFLiveMarqueeBaseModel  *obj1, FJFLiveMarqueeBaseModel  *obj2) {
        return [[NSNumber numberWithBool:obj2.firstPriority] compare:[NSNumber numberWithBool:obj1.firstPriority]];
    }];
    self.waitShowMarry = [NSMutableArray arrayWithArray:waitSortArray];
    fjf_live_marquee_signal(self.lock);
}

- (void)updateDataSouceArrayWhenRemove {
    if (self.waitShowMarry.count) {
        FJFLiveMarqueeBaseModel *baseModel = self.waitShowMarry.firstObject;
        [self addMarqueeModel:baseModel];
        if ([self isShowViewArrayContainLiveModel:baseModel]) {
            [self removeFromWaitDataWithLiveModel:baseModel];
        }
    }
}

// 响应 显示 跑马灯 点击 事件
- (void)responseContainerViewHitTestWithPoint:(CGPoint)point {
    NSArray *animatingCells = self.showViewMarry;
    NSInteger count = animatingCells.count;
    for (int i = 0; i < count; i++) {
      FJFLiveMarqueeBaseView *barrageCell = [animatingCells objectAtIndex:i];
      if ([barrageCell.layer.presentationLayer hitTest:point]) {
          if (barrageCell.marqueeModel.viewTouchedAction) {
              barrageCell.marqueeModel.viewTouchedAction(barrageCell.marqueeModel, barrageCell);
          }
          break;
      }
    }
}
#pragma mark - 显示数据源 操作

- (BOOL)isShowViewArrayContainLiveModel:(FJFLiveMarqueeBaseModel *)liveModel {
    __block BOOL isContain = NO;
    [self.showViewMarry enumerateObjectsUsingBlock:^(FJFLiveMarqueeBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.marqueeModel.animationUniqueKey isEqualToString:liveModel.animationUniqueKey]) {
            isContain = YES;
        }
    }];
    return isContain;
}

// 从显示 数据源 移除 数据
- (void)removeFromShowViewDataWithLiveView:(FJFLiveMarqueeBaseView *)liveView {
    fjf_live_marquee_wait(self.lock);
    //从数组移除
    [self.showViewMarry removeObject:liveView];
    //从字典移除
    [self.showViewMdict removeObjectForKey:liveView.marqueeModel.animationUniqueKey];
    fjf_live_marquee_signal(self.lock);
}


// 从显示数据源 添加 数据
- (void)addToShowViewDataWithLiveView:(FJFLiveMarqueeBaseView *)liveView {
    fjf_live_marquee_wait(self.lock);
    [self.showViewMarry addObject:liveView];
    [self.showViewMdict setValue:liveView forKey:liveView.marqueeModel.animationUniqueKey];
    fjf_live_marquee_signal(self.lock);
}

#pragma mark - 等待数据源 操作


// 从等待 数据源 移除 数据
- (void)removeFromWaitDataWithLiveModel:(FJFLiveMarqueeBaseModel *)liveModel {
    fjf_live_marquee_wait(self.lock);
    //从数组移除
    [self.waitShowMarry removeObject:liveModel];
    fjf_live_marquee_signal(self.lock);
}

// 从等待数据源 添加 数据
- (void)addFromWaitDataWithLiveModel:(FJFLiveMarqueeBaseModel *)liveModel {
    fjf_live_marquee_wait(self.lock);
    [self.waitShowMarry addObject:liveModel];
    fjf_live_marquee_signal(self.lock);
}


#pragma mark - Setter / Getter
- (NSMutableArray<FJFLiveMarqueeBaseModel *> *)waitShowMarry {
    if (!_waitShowMarry) {
        _waitShowMarry = [[NSMutableArray alloc]init];
    }
    return _waitShowMarry;
}

- (NSMutableDictionary <NSString *, FJFLiveMarqueeBaseView *> *)showViewMdict{
    if (!_showViewMdict) {
        _showViewMdict = [[NSMutableDictionary alloc]init];
    }
    return _showViewMdict;
}

-(NSMutableArray <FJFLiveMarqueeBaseView *> *)showViewMarry{
    if (!_showViewMarry) {
        _showViewMarry = [[NSMutableArray alloc] init];
    }
    return _showViewMarry;
}

@end
