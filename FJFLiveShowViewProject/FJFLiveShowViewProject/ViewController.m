//
//  ViewController.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/24/20.
//  Copyright © 2020 macmini. All rights reserved.
//

// tool
#import "FJFLiveDefine.h"
#import "NSObject+PerformTimer.h"
// model
#import "FJFLiveGiftShowModel.h"
// view
#import "FJFLiveGiftShowView.h"
#import "FJFLiveAnimationContainerView.h"
// vc
#import "ViewController.h"


@interface ViewController ()
// timer
@property (nonatomic, strong) NSTimer *timer;
// giftContainerView
@property (nonatomic, strong) FJFLiveAnimationContainerView *giftContainerView;
@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutViewControls];
    [self addGiftShowContainerView];
}

#pragma mark - Response Event
- (void)mySameGiftButtonClicked:(UIButton *)sender {
    sender.tag ++;
    FJFLiveGiftShowModel *tmpModel = [[FJFLiveGiftShowModel alloc] init];
    tmpModel.firstPriority = YES;
    tmpModel.sendName = @"我";
    tmpModel.giftName = @"棒棒哒";
    tmpModel.headImageName = @"icon5";
    tmpModel.giftImageName = @"gift_icon_01.gif";
    tmpModel.backImageName = @"xm_anchor_gift_normal_icon";
    tmpModel.animationUniqueKey = @"发到开发降低了封禁历史地方接口拉束带结发乐山大佛";
    tmpModel.currentNumber = sender.tag;
    [self.giftContainerView addLiveShowModel:tmpModel];
    [sender fjf_stopCountDown];
    [sender fjf_registerWithRemainingTime:2 timerCallBack:^(id  _Nonnull receiver, NSInteger remainingTime, BOOL * _Nonnull isStop) {
        sender.tag = 0;
    }];
}

- (void)myDifferentGiftButtonClicked:(UIButton *)sender {
    FJFLiveGiftShowModel *tmpModel = [[FJFLiveGiftShowModel alloc] init];
    tmpModel.firstPriority = YES;
    tmpModel.sendName = @"我";
    tmpModel.giftName = [self sendGiftName];
    tmpModel.headImageName = [self giftAvatarImageName];
    tmpModel.giftImageName = [self giftImageName];
    tmpModel.backImageName = @"xm_anchor_gift_normal_icon";
    [self.giftContainerView addLiveShowModel:tmpModel];
}


- (void)otherSameGiftButtonClicked:(UIButton *)sender {
    sender.tag ++;
    FJFLiveGiftShowModel *tmpModel = [[FJFLiveGiftShowModel alloc] init];
    tmpModel.backImageName = @"xm_anchor_gift_knight_icon";
    tmpModel.sendName = @"李明";
    tmpModel.giftName = @"棒棒哒";
    tmpModel.headImageName = @"icon1";
    tmpModel.giftImageName = @"gift_icon_02.gif";
    tmpModel.backImageName = @"xm_anchor_gift_normal_icon";
    tmpModel.currentNumber = sender.tag;
    tmpModel.animationUniqueKey = @"就了开发的发动机理发卡似懂非懂";
    [self.giftContainerView addLiveShowModel:tmpModel];
    [sender fjf_stopCountDown];
    [sender fjf_registerWithRemainingTime:2 timerCallBack:^(id  _Nonnull receiver, NSInteger remainingTime, BOOL * _Nonnull isStop) {
        sender.tag = 0;
    }];
}


- (void)otherDifferentGiftButtonClicked:(UIButton *)sender {
    FJFLiveGiftShowModel *tmpModel = [[FJFLiveGiftShowModel alloc] init];
    tmpModel.backImageName = @"xm_anchor_gift_knight_icon";
    tmpModel.sendName = [self giftSendName];
    tmpModel.giftName = [self sendGiftName];
    tmpModel.headImageName = [self giftAvatarImageName];
    tmpModel.giftImageName = [self giftImageName];
    [self.giftContainerView addLiveShowModel:tmpModel];
}

#pragma mark - Private Methods
- (void)layoutViewControls {
    
    CGFloat offsetY = self.view.frame.size.height - NavigationBarHeight() - TabbarHeight() - 100;
    UIButton *firstButton = [self giftSendButtonWithTitle:@"我-相同礼物" selector:@selector(mySameGiftButtonClicked:)];
    firstButton.frame = CGRectMake(60, offsetY, 120, 50.0);
    [self.view addSubview:firstButton];
    
    UIButton *secondButton = [self giftSendButtonWithTitle:@"他-相同礼物" selector:@selector(otherSameGiftButtonClicked:)];
    secondButton.frame = CGRectMake(200, offsetY, 120, 50.0);
    [self.view addSubview:secondButton];
    
    offsetY += 60;
    UIButton *threeButton = [self giftSendButtonWithTitle:@"我-不同礼物" selector:@selector(myDifferentGiftButtonClicked:)];
    threeButton.frame = CGRectMake(60, offsetY, 120, 50.0);
    [self.view addSubview:threeButton];
    
    UIButton *fourButton = [self giftSendButtonWithTitle:@"他-不同礼物" selector:@selector(otherDifferentGiftButtonClicked:)];
    fourButton.frame = CGRectMake(200, offsetY, 120, 50.0);
    [self.view addSubview:fourButton];
}


- (void)addGiftShowContainerView {
    FJFLiveAnimationViewStyle *tmpViewStyle = [[FJFLiveAnimationViewStyle alloc] init];
    FJFLiveAnimationContainerView *tmpView = [[FJFLiveAnimationContainerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01) viewStyle:tmpViewStyle];
    tmpView.liveViewBlock = ^FJFLiveAnimationBaseView * _Nonnull{
        return [[FJFLiveGiftShowView alloc] init];
    };
    [self.view addSubview:tmpView];
    self.giftContainerView = tmpView;
}

#pragma mark - Getter Methods

// 生成 发送 按键
- (UIButton *)giftSendButtonWithTitle:(NSString *)title selector:(SEL)selector{
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tmpButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [tmpButton setTitle:title forState:UIControlStateNormal];
    [tmpButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    tmpButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    return tmpButton;
}

- (NSString *)giftSendName {
    NSArray *nameArray = [self giftSendNameArray];
    NSInteger tmpIndex = [self getRandomNumber:0 to:(nameArray.count - 1)];
    return nameArray[tmpIndex];
}

- (NSString *)sendGiftName {
    NSArray *nameArray = [self giftNameArray];
    NSInteger tmpIndex = [self getRandomNumber:0 to:(nameArray.count - 1)];
    return nameArray[tmpIndex];
}

- (NSString *)giftAvatarImageName {
    NSInteger tmpIndex = [self getRandomNumber:0 to:28];
    return [NSString stringWithFormat:@"icon%ld", tmpIndex];
}

- (NSString *)giftImageName {
    NSInteger tmpIndex = [self getRandomNumber:1 to:4];
    return [NSString stringWithFormat:@"gift_icon_%02ld.gif", tmpIndex];
}

- (NSArray *)giftSendNameArray {
   return   @[@"李刚",
              @"大明",
              @"东哥",
              @"大鹏",
              @"天明",
              @"朱雀",
              @"玄武",
              @"渊明",
            ];
}

- (NSArray *)giftNameArray {
   return   @[@"开心一笑",
              @"棒棒哒",
              @"满分",
              @"牛逼大发",
            ];
}

-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}
@end
