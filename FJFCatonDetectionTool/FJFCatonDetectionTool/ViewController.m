//
//  ViewController.m
//  FJFCatonDetectionTool
//
//  Created by 方金峰 on 2019/8/14.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import "WBMonitor.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;

// fpsShowLabel
@property (nonatomic, strong) UILabel *fpsShowLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _fpsShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 60, 30)];
    _fpsShowLabel.textColor = [UIColor redColor];
    
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.fpsShowLabel];
    
    WBMonitor *monitor = [[WBMonitor alloc] init];
    [monitor startMonitor];
    __weak typeof(self) weakSelf = self;
    monitor.fpsBlock = ^(NSInteger fps) {
       weakSelf.fpsShowLabel.text = [NSString stringWithFormat:@"%ld", fps];
    };
}



#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify =@"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    if (indexPath.row % 10 == 0) {
        usleep(1 * 500 * 1000); // 1秒
        cell.textLabel.text = @"卡咯";
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    
    return cell;
}


#pragma mark -------------------------- Setter / Getter
- (UITableView *)myTableView {
    if(!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

@end
