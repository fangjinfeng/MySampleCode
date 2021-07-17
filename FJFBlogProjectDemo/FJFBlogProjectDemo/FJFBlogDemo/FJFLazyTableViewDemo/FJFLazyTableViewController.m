//
//  FJFLazyTableViewController.m
//  FJFBlogDemo
//
//  Created by jspeakfang on 1/1/21.
//

#import "Masonry.h"
#import "JXCategoryDotView.h"
#import "JXCategoryIndicatorBackgroundView.h"
#import "JXCategoryIndicatorLineView.h"
#import "JXCategoryListContainerView.h"

#import "FJFChatViewController.h"
#import "FJFTableSubViewController.h"
#import "FJFLazyTableViewController.h"

@interface FJFLazyTableViewController ()<JXCategoryViewDelegate ,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;
// viewControllers
@property (nonatomic, strong) NSArray *viewControllers;
// chatVc
@property (nonatomic, strong) FJFChatViewController *chatVc;
@property (nonatomic, strong) JXCategoryTitleView *titleView;
@property (nonatomic ,strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@end

@implementation FJFLazyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewControls];
    [self layoutViewControls];
}

#pragma mark - JXCategoryViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    return self.viewControllers[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.viewControllers.count;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index{
    
}


#pragma mark - Private Methods

- (void)setupViewControls {
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.listContainerView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)layoutViewControls {
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(42);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    
    self.titleView.defaultSelectedIndex = 1;
    self.listContainerView.defaultSelectedIndex = 1;
    [self.titleView reloadData];
    [self.listContainerView reloadData];
    
    [self.chatVc updateTableView];
}

#pragma mark - Public Methods

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        NSMutableArray *tmpVcMarray = [NSMutableArray array];
        NSInteger viewCount = self.titleArray.count;
        
        self.chatVc = [[FJFChatViewController alloc] init];
        [tmpVcMarray addObject:self.chatVc];
        for (NSInteger tmpIndex = 1; tmpIndex < viewCount; tmpIndex++) {
            FJFTableSubViewController *vc = [[FJFTableSubViewController alloc] init];
            [tmpVcMarray addObject:vc];
        }
        _viewControllers = tmpVcMarray;
    }
    return _viewControllers;
}


// titleArray
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"聊天",@"主播",@"测试",@"观众"];
    }
    return _titleArray;
}


- (JXCategoryTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JXCategoryTitleView alloc] init];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.delegate = self;
        _titleView.contentScrollView = self.listContainerView.scrollView;
        _titleView.indicators = @[self.lineView];
        _titleView.cellWidth = [UIScreen mainScreen].bounds.size.width / self.titleArray.count;
        _titleView.cellSpacing = 0.01;
        _titleView.titles = self.titleArray;
        _titleView.titleFont = [UIFont systemFontOfSize:12];
        _titleView.titleSelectedFont = [UIFont systemFontOfSize:12];
        _titleView.titleColor = [UIColor blackColor];
        _titleView.titleSelectedColor = [UIColor redColor];
    }
    return _titleView;
}

- (JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = [[JXCategoryIndicatorLineView alloc] init];
        _lineView.backgroundColor = [UIColor yellowColor];
        _lineView.indicatorHeight = 2;
        _lineView.indicatorWidth = 30;
        _lineView.indicatorCornerRadius = 1;
        _lineView.clipsToBounds = YES;
        _lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
    }
    return _lineView;
}

// 列表容器视图
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}
@end
