//
//  FJFMarqueeViewController.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/16/20.
//  Copyright © 2020 macmini. All rights reserved.
//

// tool
#import "FJFLiveDefine.h"
// model
#import "FJFGiftMarqueeModel.h"
#import "FJFLiveMarqueeBaseModel.h"
// view
#import "FJFGiftMarqueeView.h"
#import "FJFLiveMarqueeContainerView.h"
// vc
#import "FJFMarqueeViewController.h"

@interface FJFMarqueeViewController ()
// singleMarqueeContainerView
@property (nonatomic, strong) FJFLiveMarqueeContainerView *mutibleMarqueeContainerView;
// singleMarqueeContainerView
@property (nonatomic, strong) FJFLiveMarqueeContainerView *singleMarqueeContainerView;
@end

@implementation FJFMarqueeViewController

#pragma mark - Public Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self layoutViewControls];
    [self addMarqueeContainerView];
    [self addMutipleMarqueeContainerView];
}


#pragma mark - Response Methods
// 单行 跑马灯
- (void)singleLineMarqueeButtonClicked:(UIButton *)sender {
    FJFGiftMarqueeModel *tmpModel = [[FJFGiftMarqueeModel alloc] init];
    tmpModel.giftMessage = [self giftMessage];
    [self.singleMarqueeContainerView addMarqueeModel:tmpModel];
}

// 多行 跑马灯
- (void)mutipleLineMarqueeButtonClicked:(UIButton *)sender {
    FJFGiftMarqueeModel *tmpModel = [[FJFGiftMarqueeModel alloc] init];
    tmpModel.giftMessage = [self giftMessage];
    [self.mutibleMarqueeContainerView addMarqueeModel:tmpModel];
}
#pragma mark - Private Methods


- (void)layoutViewControls {
    
    CGFloat offsetY = self.view.frame.size.height - NavigationBarHeight() - TabbarHeight() - 50;
    UIButton *firstButton = [self giftSendButtonWithTitle:@"单行跑马灯" selector:@selector(singleLineMarqueeButtonClicked:)];
    firstButton.frame = CGRectMake(60, offsetY, 120, 50.0);
    [self.view addSubview:firstButton];
    
    UIButton *secondButton = [self giftSendButtonWithTitle:@"多行跑马灯" selector:@selector(mutipleLineMarqueeButtonClicked:)];
    secondButton.frame = CGRectMake(200, offsetY, 120, 50.0);
    [self.view addSubview:secondButton];
    
}


- (void)addMarqueeContainerView {
    FJFLiveMarqueeViewStyle *tmpViewStyle = [[FJFLiveMarqueeViewStyle alloc] init];
    FJFLiveMarqueeContainerView *tmpView = [[FJFLiveMarqueeContainerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01) viewStyle:tmpViewStyle];
    tmpView.marqueeViewBlock = ^FJFLiveMarqueeBaseView * _Nonnull{
        return [[FJFGiftMarqueeView alloc] init];
    };
    
    tmpView.appearAnimationBlock = ^(FJFLiveMarqueeContainerView *containerView, FJFLiveMarqueeBaseView * _Nonnull showView, FJFLiveMarqueeViewStyle *viewStyle) {
        
        [FJFMarqueeViewController showAppearAnimationWithViewStyle:viewStyle marqueeShowView:showView marqueeContainerView:containerView];
    };
    [self.view addSubview:tmpView];
    self.singleMarqueeContainerView = tmpView;
}

- (void)addMutipleMarqueeContainerView {
    FJFLiveMarqueeViewStyle *tmpViewStyle = [[FJFLiveMarqueeViewStyle alloc] init];
    tmpViewStyle.marqueePositionType = FJFLiveMarqueePositionTypeRandom;
    tmpViewStyle.showMaxHeight = 250;
    tmpViewStyle.appearAnimationTime = 4;
    tmpViewStyle.maxShowLiveViewCount = 100;
    tmpViewStyle.maxWaitLiveViewCount = 100;
    FJFLiveMarqueeContainerView *tmpView = [[FJFLiveMarqueeContainerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01) viewStyle:tmpViewStyle];
    tmpView.marqueeViewBlock = ^FJFLiveMarqueeBaseView * _Nonnull{
        return [[FJFGiftMarqueeView alloc] init];
    };
    
    tmpView.appearAnimationBlock = ^(FJFLiveMarqueeContainerView *containerView, FJFLiveMarqueeBaseView * _Nonnull showView, FJFLiveMarqueeViewStyle *viewStyle) {

        [FJFMarqueeViewController showAppearAnimationWithViewStyle:viewStyle marqueeShowView:showView marqueeContainerView:containerView];
    };
    [self.view addSubview:tmpView];
    self.mutibleMarqueeContainerView = tmpView;
}


// 生成 发送 按键
- (UIButton *)giftSendButtonWithTitle:(NSString *)title selector:(SEL)selector{
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tmpButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [tmpButton setTitle:title forState:UIControlStateNormal];
    [tmpButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    tmpButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    return tmpButton;
}


+ (void)showAppearAnimationWithViewStyle:(FJFLiveMarqueeViewStyle *)viewStyle
                         marqueeShowView:(FJFLiveMarqueeBaseView *)marqueeShowView
                    marqueeContainerView:(FJFLiveMarqueeContainerView *)marqueeContainerView {
    
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    [marqueeShowView sizeToFit];
    if (marqueeShowView.baseViewSize.width > viewWidth) {
        viewWidth = marqueeShowView.baseViewSize.width;
    }
    CGFloat viewHalfWidth = viewWidth/2.0;
    CGFloat viewFourWidth = viewHalfWidth / 2.0f;
    
    CGFloat firstOffsetX = ([UIScreen mainScreen].bounds.size.width / 2.0) - viewFourWidth;
    CGFloat secondOffsetX = ([UIScreen mainScreen].bounds.size.width / 2.0) - viewHalfWidth;
    CGFloat threeOffsetX = - viewWidth;
    
    if (viewStyle.appearModel == FJFLiveMarqueeAppearModeLeft) {
        firstOffsetX = viewFourWidth ;
        secondOffsetX = viewFourWidth + viewHalfWidth + 50;
        threeOffsetX = [UIScreen mainScreen].bounds.size.width + viewWidth;
    }
    
    [UIView animateKeyframesWithDuration:viewStyle.appearAnimationTime
         delay:0.0
       options:UIViewKeyframeAnimationOptionCalculationModeLinear | UIViewKeyframeAnimationOptionAllowUserInteraction
    animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:1/20.0
                                      animations:^{
                        CGRect f = marqueeShowView.frame;
                        f.origin.x = firstOffsetX;
                        marqueeShowView.frame = f;
                                      }];
        
        [UIView addKeyframeWithRelativeStartTime:1/20.0
                                relativeDuration:15/20.0
                                  animations:^{
                        CGRect f = marqueeShowView.frame;
                        f.origin.x = secondOffsetX;
                        marqueeShowView.frame = f;
                                  }];

        [UIView addKeyframeWithRelativeStartTime:16/20.0
                                relativeDuration:4/20.0
                                      animations:^{
                        CGRect f = marqueeShowView.frame;
                        f.origin.x = threeOffsetX;
                        marqueeShowView.frame = f;
                                    }];
        
    }
    completion:^(BOOL finished) {
        if (finished) {
            [marqueeContainerView removeCurrentShowViewWithShowView:marqueeShowView];
        }
    }];
}

- (NSString *)giftMessage {
    NSArray *nameArray = [self giftMessageArray];
    NSInteger tmpIndex = [self getRandomNumber:0 to:(nameArray.count - 1)];
    return nameArray[tmpIndex];
}

- (NSArray *)giftMessageArray {
   return   @[@"生日快乐!我要送你一份100%纯情奶糖:成份=真心+思念+快乐,有效期=一生,营养=温馨...",
              @"没有甜美的蛋糕,缤红的美酒,丰厚的礼物。",
              @"悠悠的云里有淡淡的诗,淡淡的诗里有绵绵的喜悦。",
              @"酒越久越醇,朋友相交越久越真。",
              @"支支灿烂的烛光,岁岁生日的幸福。",
            ];
}

-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}
@end
