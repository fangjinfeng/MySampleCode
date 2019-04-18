//
//  FJFSixViewController.m
//  FJFTestProject
//
//  Created by 方金峰 on 2019/3/7.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "UIView+FJFrame.h"
#import "FJBaseTableView.h"
#import "FJFTopContainerView.h"
#import "FJFFirstViewController.h"

@interface FJFFirstViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
   
    CGPoint _curPoint;   // 当前坐标
    CGPoint _beganPoint; // 开始坐标
    CGFloat _previousOffsetY;// 拖动前 移动 距离
    CGFloat _scrollViewStartPositionY; // 起始 Y值
    CGFloat _scrollViewLimitMaxY; // 起始 Y值
    CGFloat _topTipContainerViewCurrentY; // 导航视图 当前Y值
}


// tableView
@property (nonatomic, strong) FJBaseTableView *tableView;

// 滑动 手势
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

// topContainerView
@property (nonatomic, strong) FJFTopContainerView *topContainerView;
@end

@implementation FJFFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewControls];
}

// 设置 控件
- (void)setupViewControls {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _scrollViewLimitMaxY = self.view.frame.size.height - 150;
    _scrollViewStartPositionY = 0;
    
    self.navigationItem.title = @"模仿高德路线规划滑动";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView addGestureRecognizer:self.panGesture];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topContainerView];
    [self tableViewMoveToBottom];
}
#pragma mark --------------- System Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.0)/256.0f green:arc4random_uniform(256)/256.0f blue:arc4random_uniform(256)/256.0f alpha:1.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.0f;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.frame.origin.y > _scrollViewStartPositionY) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - 手势处理
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        _beganPoint = [sender locationInView:sender.view.superview];
        _curPoint = sender.view.center;
        _topTipContainerViewCurrentY = _topContainerView.frame.origin.y;
        _previousOffsetY = self.tableView.contentOffset.y;
        
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint point = [sender locationInView:sender.view.superview];
        
        CGFloat offsetY = _previousOffsetY - self.tableView.contentOffset.y;
        NSInteger y_offset = point.y - _beganPoint.y - offsetY;
        
        if ((sender.view.frame.origin.y >= _scrollViewStartPositionY && sender.view.frame.origin.y <= _scrollViewLimitMaxY) || (self.tableView.contentOffset.y == 0 && self.tableView.contentSize.height > self.tableView.frame.size.height)) {
            sender.view.center = CGPointMake(_curPoint.x, _curPoint.y + y_offset);
            [self updateViewControlsWhenSliding];
        }
        
        if (sender.view.frame.origin.y > _scrollViewLimitMaxY) {
            sender.view.y = _scrollViewLimitMaxY;
            [self updateViewControlsWithSlideUp:NO];
        }
        else if(sender.view.frame.origin.y < _scrollViewStartPositionY) {
            
            sender.view.y = _scrollViewStartPositionY;
             [self updateViewControlsWithSlideUp:YES];
        }
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        
        if (sender.view.frame.origin.y <= _scrollViewStartPositionY || sender.view.frame.origin.y > _scrollViewLimitMaxY) {
            if (sender.view.frame.origin.y <= _scrollViewStartPositionY) {
                [self updateViewControlsWithSlideUp:YES];
            }
            if (sender.view.frame.origin.y > _scrollViewLimitMaxY) {
                [self updateViewControlsWithSlideUp:NO];
            }
            return;
        }
        // 滑动速度处理
        CGPoint velocity = [sender velocityInView:self.view];
        CGFloat speed = 350;
        if (velocity.y < - speed) {
            // 快速向上
            [self tableViewMoveToTop];
            return;
        } else if (velocity.y > speed) {
            // 快速向下
            [self tableViewMoveToBottom];
            return;
        }
        
        // 滑动临界值
        CGFloat criticalValue = _scrollViewLimitMaxY/2.0;
        if (sender.view.frame.origin.y <= criticalValue) {
            [self tableViewMoveToTop];
        } else {
            [self tableViewMoveToBottom];
        }
    }
}



- (void)tableViewMoveToTop {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = self->_scrollViewStartPositionY + 0.01;
        self.topContainerView.alpha = 0.0f;
        self.topContainerView.y = - [FJFTopContainerView viewHeight];
    } completion:^(BOOL finished) {
          [self updateViewControlsWithSlideUp:YES];
    }];
}

- (void)tableViewMoveToBottom {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = self->_scrollViewLimitMaxY - 0.01;
        self.topContainerView.y = 0.0f;
        self.topContainerView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self updateViewControlsWithSlideUp:NO];
    }];
}

- (void)updateViewControlsWhenSliding {
    if (self.tableView.frame.origin.y > _scrollViewStartPositionY && self.tableView.frame.origin.y < _scrollViewLimitMaxY) {
        
        CGFloat offsetLimitDistance = _scrollViewLimitMaxY - _scrollViewStartPositionY;
        CGFloat offsetDistance = self.tableView.frame.origin.y - _scrollViewStartPositionY;
        if (offsetDistance > 0 && offsetDistance < offsetLimitDistance) {
            CGFloat topViewHeight = [FJFTopContainerView viewHeight];
            CGFloat topViewHeightOffset =  offsetDistance * (topViewHeight / offsetLimitDistance);
            CGFloat viewAlpha = offsetDistance / offsetLimitDistance;
            _topContainerView.y = topViewHeightOffset - topViewHeight;
            _topContainerView.alpha = viewAlpha;        }
    }
    
}

- (void)updateViewControlsWithSlideUp:(BOOL)slideUp {
    if (slideUp) {
        _topContainerView.y = -[FJFTopContainerView viewHeight];
        _topContainerView.alpha = 0.0f;
    }
    else {
        _topContainerView.y = 0.0f;
        _topContainerView.alpha = 1.0f;;
    }
}


#pragma mark --------------- Getter / Setter
// tableView
- (FJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FJBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

// topContainerView
- (FJFTopContainerView *)topContainerView {
    if (!_topContainerView) {
        CGFloat topContainerViewHeight = [FJFTopContainerView viewHeight];
        _topContainerView = [[FJFTopContainerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, topContainerViewHeight)];
        _topContainerView.backgroundColor = [UIColor redColor];
    }
    return _topContainerView;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    }
    return _panGesture;
}

@end
