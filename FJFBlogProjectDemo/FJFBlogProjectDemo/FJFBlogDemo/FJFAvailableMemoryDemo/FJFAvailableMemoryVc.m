//
//  FJFAvailableMemoryVc.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/3/28.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "Masonry.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import "FJFAvailableMemoryVc.h"

@interface FJFAvailableMemoryVc ()
// textField
@property (nonatomic, strong) UITextField *textField;
// startButton
@property (nonatomic, strong) UIButton *startButton;
// tmpMutableArray
@property (nonatomic, strong) NSMutableArray *tmpMutableArray;
@end

@implementation FJFAvailableMemoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tmpMutableArray = [NSMutableArray array];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view).mas_offset(100);
    }];
    
    [self.view addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.textField.mas_bottom).mas_offset(60);
    }];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *tmpImageView = [[UIImageView alloc] init];
    tmpImageView.image = [UIImage imageNamed:@"map_icon_second"];
    [self.view addSubview:tmpImageView];
    [tmpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(80);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];

}
#pragma mark - Response Event
- (void)startButtonClicked:(UIButton *)button {
    int availMem = self.textField.text.intValue;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while ([FJFAvailableMemoryVc availableMemory] > availMem) {
            double randowNum = arc4random();
            NSString *tmpStr = [NSString stringWithFormat:@"jdfljkfjdlfjal房间%f里的解放路的时间里封建时代啦；房间；李的撒娇弗兰克；的姐夫来看；讲道理；放假啦；市解放路；极度分裂看到；冷风机独立思考房间里的会计分录看电视剧疯狂拉的姐夫来看的姐夫来看就达萨罗的房间里束带结发猎杀对决分离式的飞机洒落的咖啡机发了时代峻峰来得及酸辣粉绝对是逻辑电路撒酒疯冷冻机房垃圾分类的市解放路jlfjldfjlasdjfljfl;jalfj;lfj;lasfj;ldf%f", randowNum, randowNum];
            NSString *tmpStr1 = [NSString stringWithFormat:@"fjljflsada%lf封疆大jfldjfld封疆大吏福建师大垃圾分类的事件发生砥砺奋进；娄底市解放路；记得是丽枫酒店；了司机弗兰克斯街坊邻居是两方基斯里夫精灵盛典解封了；是杰峰逻辑啊砥砺奋进娄底市解放路的设计费手机登录放假是砥砺奋进娄底市解放路第三方的时间里防静电射流风机冷冻机房娄底市解放路是的吏附近的洛杉矶发了多少杰峰;jalfj;lfj;lasfj;ldf%u杰峰冷冻机房；老东家射流风机娄底市解放路；的设计费；累进税率；大姐夫；拉萨的；杰峰；逻辑是砥砺奋进拉萨的杰峰了盛大开飞机撒拉飞机老东家发了多少", randowNum, randowNum];
            [self.tmpMutableArray addObject:tmpStr];
            [self.tmpMutableArray addObject:tmpStr1];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"----------真正可用内存:%lf", [FJFAvailableMemoryVc availableMemory]);
        });
    });
}

#pragma mark - Private Methods
// 获取 可用 内存
+ (double)availableMemory {
  vm_statistics_data_t vmStats;
  mach_msg_type_number_t infoCount =HOST_VM_INFO_COUNT;
  kern_return_t kernReturn = host_statistics(mach_host_self(),
                                           HOST_VM_INFO,
                                           (host_info_t)&vmStats,
                                           &infoCount);
  if (kernReturn != KERN_SUCCESS) {
    return NSNotFound;
  }
  double avaMem = ((vm_page_size *vmStats.free_count) /1024.0) / 1024.0;
  NSLog(@"-----------: %lf", avaMem);
  return avaMem;
}

#pragma mark - Lazy Methods
// 输入框
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入达到多少可用内存";
        _textField.backgroundColor = [UIColor redColor];
    }
    return _textField;
}

// startButton
- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] init];
        _startButton.backgroundColor = [UIColor redColor];
        [_startButton setTitle:@"开始" forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}
@end
