//
//  ViewController.m
//  FJFImageSawtoothDemo
//
//  Created by macmini on 25/10/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFMineTaskIntroducePopMenuView.h"
#import "FJFMineTaskTipPopMenuView.h"
#import "FJFTextContentViewCell.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
// tableView
@property (nonatomic, strong) UITableView *tableView;
// contentTextArray
@property (nonatomic, strong) NSArray <NSString *>*contentTextArray;
@end

@implementation ViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - System Delegate

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    FJFTextContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FJFTextContentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateContentString:self.contentTextArray[indexPath.row]];
    __weak typeof(cell) weakCell = cell;
    cell.buttonClickedBlock = ^(UIButton *button, id value) {
        CGRect focusFrame = [weakCell convertRect:button.frame toView:self.view];
        [FJFMineTaskTipPopMenuView showTaskTipPopMenuViewWithContentString:@"已完成! 请明天再来哦~" showPosition:CGPointMake(CGRectGetMaxX(focusFrame) - 20.0f, focusFrame.origin.y)];
        };
    return cell;
}

#pragma mark --- UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [FJFTextContentViewCell cellHeightWithContentString:self.contentTextArray[indexPath.row]];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *tmpCell = [tableView cellForRowAtIndexPath:indexPath];
       CGRect focusFrame = [tmpCell convertRect:tmpCell.contentView.frame toView:self.view];
       CGFloat positionX = [FJFMineTaskIntroducePopMenuView viewWidth] + 58.0f;
       [FJFMineTaskIntroducePopMenuView showTaskTipPopMenuViewWithTitleString:@"提醒" contentString:@"dfhsdhfkdhfkahkjfhdaskjfhlkjsafhakjdsfhjkds" showPosition:CGPointMake(positionX, focusFrame.origin.y)];
}


#pragma mark -------------------------- Setter / Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = FJF_RGBColor(233, 234, 235);
        _tableView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _tableView;
}

- (NSArray <NSString *>*)contentTextArray {
    if (!_contentTextArray) {
        _contentTextArray = @[
            @"本来打算将星星摘给你 但想想还是算了,我够得着星星 够不着你",
            
            @"我怕别人说我丑 于是我先自己说自己丑\我怕别人说我穷 于是我先自己说自己穷\我怕别人欺骗伤害我\
            于是我先试探别人保护自己",
            
            @"我想不出一句话可以概括我们之间的关系 似远似近又暧昧不清 忽冷忽热又像习以为常 给点甜头又怕自作多情\ 什么都不是却也不想放弃 明明毫无牵挂却似无人成全般勉强心仪的鞋子断码了，就去旁边店买一件漂亮的大衣。常去的面馆停业了，就去别家吃一碗好吃的粉。喜欢的人离开了，就好好上课好好工作挣更多的钱。有无数种方式可以让自己开心，也有无数条大路可以通向未来。人会成长，曾经沉迷的东西都会沦为可有可无的消遣。没有什么是不可替代的，包括你。。",
            
            @"会在一起的人终会在一起就像地球是圆的 无论怎么背道而驰还是会重新相遇 时光在跌跌撞撞里蹉跎很多年 无数个 分开的契机里藏着无数个重逢的理由 故事的结局里 仁慈的上帝正指着最爱的那个：最后的最后 他还是你的。",
            
            @"上初中后跟小学朋友断了联系，上高中后跟初中朋友断了联系，上大学后，高中的朋友也不大联系了 ，估计大学毕业后就没朋友了， 从一个环境到另一个环境 ，过去的关系全都无力维系，是青春太过单薄，风轻轻一吹就散了，离开时请记得彼此的微笑，给彼此祝福。蓦然回首，生命是一场无法回放的绝版电影。",
        @"心仪的鞋子断码了，就去旁边店买一件漂亮的大衣。常去的面馆停业了，就去别家吃一碗好吃的粉。喜欢的人离开了，就好好上课好好工作挣更多的钱。有无数种方式可以让自己开心，也有无数条大路可以通向未来。人会成长，曾经沉迷的东西都会沦为可有可无的消遣。没有什么是不可替代的，包括你。。",
        @"出门时冷战，他先上了车，我最后一个上车，发现他旁边的座位空着，于是坐下，转过头对他说：“你有女朋友吗？”“没有”他没看我。我倾过身去，在他脸上啾了一口“那你做我男朋友吧”“好”他脸上浮现一抹红晕，握住了我的手。坐直后我眼角瞥见周围的乘客都在看着我们，目瞪口呆……",
            
        @"你总有一天要跟所有的记忆相安无事握手言和，那里面有她也有你，有她的青春也有你的年华。那个人永远活在时间里了，你把她拉不出来，自己也回不去，就这样吧，让她安静的留在那里吧。她不会发福不会老去不会带着家长里短柴油米醋的气息，她永远年轻永远漂亮穿着鲜艳长裙站在回忆里，对着你笑靥如花。",
            
            @"本来打算将星星摘给你 但想想还是算了,我够得着星星 够不着你",
                                ];
    }
    return _contentTextArray;
}
@end
