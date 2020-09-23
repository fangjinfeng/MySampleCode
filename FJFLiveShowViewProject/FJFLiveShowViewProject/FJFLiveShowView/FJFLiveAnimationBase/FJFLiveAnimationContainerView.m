//
//  FJFLiveAnimationContainerView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/20/20.
//  Copyright © 2020 LFC. All rights reserved.
//


#import "FJFLiveAnimationContainerView.h"

#define fjf_live_animation_signal(sema) dispatch_semaphore_signal(sema);
#define fjf_live_animation_wait(sema) dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

@implementation FJFLiveAnimationViewStyle
#pragma mark - Life Circle
- (instancetype)init {
    if (self = [super init]) {
        _liveViewSpacing = 20;
        _liveViewWidth = 280;
        _liveViewHeight = 53;
        _liveViewTopSpacing = 0;
        _appearAnimationDeayTime = 0;
        _appearAnimationDamping = 0.6;
        _appearAnimationVelocity = 10;
        _exchangeAnimationTime = 0.25;
        _appearAnimationTime = 0.5;
        _maxShowLiveViewCount = 3;
        _addModel = FJFLiveAnimationAddModeReplace;
        _appearModel = FJFLiveAnimationAppearModeRight;
        _hiddenModel = FJFLiveAnimationHiddenModeLeft;
        _topSqueezeModel = FJFLiveAnimationHiddenModeTop;
        _maxWaitLiveViewCount = 100;
    }
    return self;
}
@end

@interface FJFLiveAnimationContainerView()
// 操作 锁
@property (nonatomic, strong) dispatch_semaphore_t lock;
// viewStyle
@property (nonatomic, strong) FJFLiveAnimationViewStyle *viewStyle;
// 当前 显示 视图 字典
@property (nonatomic ,strong) NSMutableDictionary <NSString *, FJFLiveAnimationBaseView *> *showViewMdict;
// 当前 显示 视图 队列
@property (nonatomic ,strong) NSMutableArray <FJFLiveAnimationBaseView *> *showViewMarry;
// 当前等待展示 动画
@property (nonatomic, strong) NSMutableArray <FJFLiveAnimationBaseModel *> *waitShowMarry;
@end

@implementation FJFLiveAnimationContainerView

#pragma mark - Life Circle

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame viewStyle:[[FJFLiveAnimationViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFLiveAnimationViewStyle *)viewStyle {
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

- (void)addLiveShowModel:(FJFLiveAnimationBaseModel *)showModel {
    if (!showModel || ![showModel isKindOfClass:[FJFLiveAnimationBaseModel class]]) {
        return;
    }
    FJFLiveAnimationBaseView *oldShowView = [self.showViewMdict objectForKey:showModel.animationUniqueKey];
    // 如果存在旧视图，更新旧视图
    if (oldShowView && [oldShowView isKindOfClass:[FJFLiveAnimationBaseView class]]) {
        [oldShowView updateControlsWithLiveModel:showModel];
    }
    else { // 新模型
        // 如果 添加模式 为直接添加
        NSInteger showCount = [self correctShowDataIndexWithCurrentIndex:self.showViewMarry.count];
        if (self.viewStyle.addModel == FJFLiveAnimationAddModeAdd) {
            // 如果 超出 限制
            if (showCount >= self.viewStyle.maxShowLiveViewCount) {
                [self addToWaitMarrayWithShowModel:showModel];
            } else { // 不超出限制
                [self addNewLiveViewWithShowModel:showModel];
            }
        } else { // 添加模式 为直接替换
            // 如果 超出 限制
            if (showCount >= self.viewStyle.maxShowLiveViewCount) {
                [self addToWaitMarrayWithShowModel:showModel];
                [self squeezeOutShowLiveView];
            } else { // 不超出限制
                [self addNewLiveViewWithShowModel:showModel];
            }
        }
    }
}

// 添加 新的视图
- (void)addNewLiveViewWithShowModel:(FJFLiveAnimationBaseModel *)showModel {
    //计算视图Y值
    NSInteger showCount = [self correctShowDataIndexWithCurrentIndex:self.showViewMarry.count];
    CGFloat viewSpacingHeight = _viewStyle.liveViewHeight + _viewStyle.liveViewSpacing;
    CGFloat  showViewY = viewSpacingHeight * showCount + self.viewStyle.liveViewTopSpacing;
    if (_viewStyle.showModel == FJFLiveAnimationShowModeFromTopToBottom) {
        showViewY = showViewY;
    } else if (_viewStyle.showModel == FJFLiveAnimationShowModeFromBottomToTop) {
       showViewY = - showViewY;
    }
    if (showModel.firstPriority) {
        showViewY = 0;
    }
    //创建新模型
    CGRect frame = CGRectMake(0, showViewY, _viewStyle.liveViewWidth, _viewStyle.liveViewHeight);
    if (_viewStyle.appearModel == FJFLiveAnimationAppearModeLeft) {
        frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, showViewY, _viewStyle.liveViewWidth, _viewStyle.liveViewHeight);
    } else if(_viewStyle.appearModel == FJFLiveAnimationAppearModeRight) {
       frame = CGRectMake([UIScreen mainScreen].bounds.size.width, showViewY, _viewStyle.liveViewWidth, _viewStyle.liveViewHeight);
    }
    FJFLiveAnimationBaseView *newShowView = nil;
    if (self.liveViewBlock) {
       newShowView = self.liveViewBlock();
    } else {
       newShowView = [[FJFLiveAnimationBaseView alloc] initWithFrame:frame];
    }
    //赋值
    newShowView.frame = frame;
    [newShowView updateControlsWithLiveModel:showModel];
    newShowView.hiddenModel = _viewStyle.hiddenModel;

    // 显示 显示图
    [self appearWith:newShowView];

    //超时移除
    __weak __typeof(self)weakSelf = self;
    newShowView.animationViewShowTimeOut = ^(FJFLiveAnimationBaseView * willReMoveShowView){
       // 从显示数据源移除
       [weakSelf removeFromShowViewDataWithLiveView:willReMoveShowView];
       // 更新数据源 当移除时
       [weakSelf updateDataSouceArrayWhenRemove];
       //比较数量大小排序
       [weakSelf sortShowArr];
       // 重置偏移位置
       [weakSelf resetY];
    };
    
    if (showModel.firstPriority) {
        [self insertSubview:newShowView atIndex:0];
    } else {
        [self addSubview:newShowView];
    }

    //添加到显示数据源
    [self judgeIsBeyondMaxShowLiveViewCountWithLiveView:newShowView];
    [self addToShowViewDataWithLiveView:newShowView];
    // 更新 排序
    [self sortShowArr];
    // 重置偏移位置
    [self resetY];
}
#pragma mark - Private Methods
- (void)appearWith:(FJFLiveAnimationBaseView *)showView {
    // 出现的动画
    if (_viewStyle.appearModel == FJFLiveAnimationAppearModeLeft ||
        _viewStyle.appearModel == FJFLiveAnimationAppearModeRight) {
        if (self.appearAnimationBlock) {
           self.appearAnimationBlock(self, showView, _viewStyle);
        } else {
            showView.isAppearAnimation = YES;
           [UIView animateWithDuration:self.viewStyle.appearAnimationTime delay:self.viewStyle.appearAnimationDeayTime usingSpringWithDamping:self.viewStyle.appearAnimationDamping initialSpringVelocity:self.viewStyle.appearAnimationVelocity options:UIViewAnimationOptionCurveEaseIn animations:^{
               CGRect f = showView.frame;
               f.origin.x = 0;
               showView.frame = f;
           } completion:^(BOOL finished) {
               if (finished) {
                showView.isAppearAnimation = NO;
               }
           }];
        }
    } else {
        CGRect f = showView.frame;
        f.origin.x = 0;
        showView.frame = f;
    }
}

- (NSInteger)correctShowDataIndexWithCurrentIndex:(NSInteger)currentIndex {
    NSInteger correctIndex = 0;
    for (NSInteger tmpIndex = 0; tmpIndex < currentIndex; tmpIndex++) {
       FJFLiveAnimationBaseView *tmpView = self.showViewMarry[tmpIndex];
        if (!tmpView.isLeavingAnimation) {
            correctIndex ++;
        }
    }
    return correctIndex;
}

- (void)resetY {
    for (int i = 0; i < self.showViewMarry.count; i++) {
        FJFLiveAnimationBaseView *show = self.showViewMarry[i];
        if ([show isKindOfClass:[FJFLiveAnimationBaseView class]]) {
            NSInteger correctIndex = [self correctShowDataIndexWithCurrentIndex:i];
            CGFloat showY = correctIndex * (_viewStyle.liveViewHeight + _viewStyle.liveViewSpacing);
            if (_viewStyle.showModel == FJFLiveAnimationShowModeFromBottomToTop) {
                showY = -showY;
            }
            if (show.frame.origin.y != showY) {
                if (!show.isLeavingAnimation) {
                    // 避免出现动画和交换动画冲突
                    if (show.isAppearAnimation) {
                        [show.layer removeAllAnimations];
                    }
                    [UIView animateWithDuration:self.viewStyle.exchangeAnimationTime animations:^{
                        CGRect showF = show.frame;
                        showF.origin.y = showY;
                        show.frame = showF;
                    } completion:^(BOOL finished) {
                    }];
                }
            }
        }
    }
}


// 添加到等待队列
- (void)addToWaitMarrayWithShowModel:(FJFLiveAnimationBaseModel *)showModel {
    if (!showModel) {
        return;
    }
    NSString * key = showModel.animationUniqueKey;
    NSMutableArray *tmpWaitMarray = [NSMutableArray arrayWithArray:self.waitShowMarry];
    for (NSUInteger i = 0; i < tmpWaitMarray.count; i++) {
        FJFLiveAnimationBaseModel *oldModel = tmpWaitMarray[i];
        NSString * oldKey = oldModel.animationUniqueKey;
        if ([oldKey isEqualToString:key]) {
            [self removeFromWaitDataWithLiveModel:oldModel];
            break;
        }
    }
    [self judgeIsBeyondMaxWaitLiveViewCount];
    [self addFromWaitDataWithLiveModel:showModel];
}


- (void)sortShowArr{
     fjf_live_animation_wait(self.lock);
    //排序 最小的时间在第一个
    NSArray * sortArr = [self.showViewMarry sortedArrayUsingComparator:^NSComparisonResult(FJFLiveAnimationBaseView * obj1, FJFLiveAnimationBaseView * obj2) {
        NSComparisonResult result = [[NSNumber numberWithBool:obj2.liveModel.firstPriority] compare:[NSNumber numberWithBool:obj1.liveModel.firstPriority]];
        if (result == NSOrderedSame) {
            return [obj1.creatDate compare:obj2.creatDate];
        }
        return result;
    }];
    self.showViewMarry = [NSMutableArray arrayWithArray:sortArr];
    NSArray *waitSortArray = [self.waitShowMarry sortedArrayUsingComparator:^NSComparisonResult(FJFLiveAnimationBaseModel  *obj1, FJFLiveAnimationBaseModel  *obj2) {
        return [[NSNumber numberWithBool:obj2.firstPriority] compare:[NSNumber numberWithBool:obj1.firstPriority]];
    }];
    self.waitShowMarry = [NSMutableArray arrayWithArray:waitSortArray];
    fjf_live_animation_signal(self.lock);
}

- (void)updateDataSouceArrayWhenRemove {
    if (self.waitShowMarry.count) {
        FJFLiveAnimationBaseModel *baseModel = self.waitShowMarry.firstObject;
        [self addLiveShowModel:baseModel];
        if ([self isShowViewArrayContainLiveModel:baseModel]) {
            [self removeFromWaitDataWithLiveModel:baseModel];
        }
    }
}


// 响应 显示 显示 点击 事件
- (void)responseContainerViewHitTestWithPoint:(CGPoint)point {
    NSArray *animatingCells = self.showViewMarry;
    NSInteger count = animatingCells.count;
    for (int i = 0; i < count; i++) {
      FJFLiveAnimationBaseView *barrageCell = [animatingCells objectAtIndex:i];
      if ([barrageCell.layer.presentationLayer hitTest:point]) {
          if (barrageCell.liveModel.viewTouchedAction) {
              barrageCell.liveModel.viewTouchedAction(barrageCell.liveModel, barrageCell);
          }
          break;
      }
    }
}

#pragma mark - 显示数据源 操作

- (BOOL)isShowViewArrayContainLiveModel:(FJFLiveAnimationBaseModel *)liveModel {
    __block BOOL isContain = NO;
    [self.showViewMarry enumerateObjectsUsingBlock:^(FJFLiveAnimationBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.liveModel.animationUniqueKey isEqualToString:liveModel.animationUniqueKey]) {
            isContain = YES;
        }
    }];
    return isContain;
}

// 获取 被挤走 视图索引
- (NSInteger)squeezeOutLiveViewIndex {
    __block  NSInteger index = 0;
    // 包含 高优先级
    if ([self isContainedFirstPriorityLiveView]) {
        if ([self isAllFirstPriorityLiveView]) {
            index = self.showViewMarry.count - 1;
        } else {
            [self.showViewMarry enumerateObjectsUsingBlock:^(FJFLiveAnimationBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!obj.liveModel.firstPriority) {
                    index = idx;
                    *stop = YES;
                }
            }];
        }
    } else {
        [self.showViewMarry enumerateObjectsUsingBlock:^(FJFLiveAnimationBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.isLeavingAnimation) {
                index = idx;
                *stop = YES;
            }
        }];
    }
    return index;
}

// 是否 含有 高优先级
- (BOOL)isContainedFirstPriorityLiveView {
    __block BOOL isContained = NO;
    [self.showViewMarry enumerateObjectsUsingBlock:^(FJFLiveAnimationBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.liveModel.firstPriority) {
            isContained = YES;
            *stop = YES;
        }
    }];
    return isContained;
}

// 是否 全部为高优先级
- (BOOL)isAllFirstPriorityLiveView {
    __block BOOL isAll = YES;
    [self.showViewMarry enumerateObjectsUsingBlock:^(FJFLiveAnimationBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.liveModel.firstPriority) {
            isAll = NO;
            *stop = YES;
        }
    }];
    return isAll;
}

// 判断 是否 需要 从顶部 移除
- (BOOL)isHiddenFromTopWithOutIndex:(NSInteger)outIndex {
    BOOL isFromTop = NO;
    if (outIndex == 0) {
        isFromTop = YES;
    }
    return isFromTop;
}

// 挤出 正在显示 view
- (void)squeezeOutShowLiveView {
    NSInteger tmpIndex = [self squeezeOutLiveViewIndex];
    if(tmpIndex < self.showViewMarry.count) {
        FJFLiveAnimationBaseView *outView = self.showViewMarry[tmpIndex];
        if ([self isHiddenFromTopWithOutIndex:tmpIndex]) {
            outView.hiddenModel = self.viewStyle.topSqueezeModel;
        }
        [outView dimssView];
    }
}

// 判断 是否 超过 最大 显示 限制
- (void)judgeIsBeyondMaxShowLiveViewCountWithLiveView:(FJFLiveAnimationBaseView *)liveView {
    if (self.showViewMarry.count + self.waitShowMarry.count > self.viewStyle.maxShowLiveViewCount) {
        [self squeezeOutShowLiveView];
    }
}

// 从显示 数据源 移除 数据
- (void)removeFromShowViewDataWithLiveView:(FJFLiveAnimationBaseView *)liveView {
    fjf_live_animation_wait(self.lock);
    //从数组移除
    [self.showViewMarry removeObject:liveView];
    //从字典移除
    [self.showViewMdict removeObjectForKey:liveView.liveModel.animationUniqueKey];
    fjf_live_animation_signal(self.lock);
}


// 从显示数据源 添加 数据
- (void)addToShowViewDataWithLiveView:(FJFLiveAnimationBaseView *)liveView {
    fjf_live_animation_wait(self.lock);
    if (liveView.liveModel.firstPriority) {
        [self.showViewMarry insertObject:liveView atIndex:0];
    } else {
        [self.showViewMarry addObject:liveView];
    }
    [self.showViewMdict setValue:liveView forKey:liveView.liveModel.animationUniqueKey];
    fjf_live_animation_signal(self.lock);
}

#pragma mark - 等待数据源 操作

// 获取 被挤走 等待 模型索引
- (NSInteger)squeezeOutWaitModelIndex {
    __block  NSInteger index = 0;
    [self.waitShowMarry enumerateObjectsUsingBlock:^(FJFLiveAnimationBaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.firstPriority) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

// 判断 是否 超过 最大 等待数量 限制
- (void)judgeIsBeyondMaxWaitLiveViewCount {
    if (self.waitShowMarry.count + 1 > self.viewStyle.maxWaitLiveViewCount) {
        NSInteger tmpIndex = [self squeezeOutWaitModelIndex];
        FJFLiveAnimationBaseModel *tmpModel = self.waitShowMarry[tmpIndex];
        [self removeFromWaitDataWithLiveModel:tmpModel];
    }
}


// 从等待 数据源 移除 数据
- (void)removeFromWaitDataWithLiveModel:(FJFLiveAnimationBaseModel *)liveModel {
    fjf_live_animation_wait(self.lock);
    //从数组移除
    [self.waitShowMarry removeObject:liveModel];
    fjf_live_animation_signal(self.lock);
}

// 从等待数据源 添加 数据
- (void)addFromWaitDataWithLiveModel:(FJFLiveAnimationBaseModel *)liveModel {
    fjf_live_animation_wait(self.lock);
    if (liveModel.firstPriority) {
        [self.waitShowMarry insertObject:liveModel atIndex:0];
    } else {
        [self.waitShowMarry addObject:liveModel];
    }
    fjf_live_animation_signal(self.lock);
}


#pragma mark - Setter / Getter
- (NSMutableArray<FJFLiveAnimationBaseModel *> *)waitShowMarry {
    if (!_waitShowMarry) {
        _waitShowMarry = [[NSMutableArray alloc]init];
    }
    return _waitShowMarry;
}

- (NSMutableDictionary <NSString *, FJFLiveAnimationBaseView *> *)showViewMdict{
    if (!_showViewMdict) {
        _showViewMdict = [[NSMutableDictionary alloc]init];
    }
    return _showViewMdict;
}

-(NSMutableArray <FJFLiveAnimationBaseView *> *)showViewMarry{
    if (!_showViewMarry) {
        _showViewMarry = [[NSMutableArray alloc] init];
    }
    return _showViewMarry;
}

@end
