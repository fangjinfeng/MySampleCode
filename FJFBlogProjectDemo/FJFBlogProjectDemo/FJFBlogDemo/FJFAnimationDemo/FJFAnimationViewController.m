//
//  FJFAnimationViewController.m
//  FJFBlogDemo
//
//  Created by jspeakfang on 1/1/21.
//

#import "FJFAnimationViewController.h"

#define kFjfAngelToRandian(x) ((x)/180.0*M_PI)

@interface FJFAnimationViewController ()
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) CAKeyframeAnimation *animation;
@end

@implementation FJFAnimationViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.testButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
}


#pragma mark - Delegate Methods

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"------------:动画开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"------------:动画结束");
}

#pragma mark - Response Event

- (void)testButtonClicked:(UIButton *)sender {
    [self.testButton.layer removeAllAnimations];
    [self.testButton.layer addAnimation:self.animation forKey:@"ShakingAnimation"];
}

#pragma mark - Getter Methods

- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
        [_testButton addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _testButton.backgroundColor = [UIColor redColor];
    }
    return _testButton;
}

- (CAKeyframeAnimation *)animation {
    if (!_animation) {
        _animation = [CAKeyframeAnimation animation];
        _animation.keyPath = @"transform.rotation";
        _animation.values = @[@(kFjfAngelToRandian(-3)),@(kFjfAngelToRandian(3)),@(kFjfAngelToRandian(-3))];
        _animation.repeatCount =  MAXFLOAT;
        _animation.duration = 0.2;
        _animation.delegate = self;
    }
    return _animation;
}

@end
