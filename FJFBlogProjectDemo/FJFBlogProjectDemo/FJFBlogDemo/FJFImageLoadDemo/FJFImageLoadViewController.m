//
//  FJFImageLoadViewController.m
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/9/18.
//  Copyright © 2021 fjf. All rights reserved.
//

#import "Masonry.h"
#import "FJFImageTableViewCell.h"
#import "UIImage+DownSample.h"
#import "FJFImageLoadViewController.h"

@interface FJFImageLoadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UIImageView *imageView;
// tableView
@property (nonatomic, strong) UITableView *tableView;

// 图片 url数组
@property (nonatomic, strong) NSArray <NSString *> *imageUrlArray;
@end

@implementation FJFImageLoadViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    

    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - System Delegate
#pragma mark -- UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    FJFImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FJFImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageUrlStr = self.imageUrlArray[indexPath.row % self.imageUrlArray.count];
    return cell;
}


#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter Methods

// 图片 url数组
- (NSArray <NSString *>*)imageUrlArray {
    if (!_imageUrlArray) {
        _imageUrlArray = @[
            @"http://uf-onegreen.qqxzb-img.com/www-maps/Upload_maps/201412/2014120107280906.jpg",
            @"http://gss0.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/aec379310a55b31905caba3b43a98226cffc1748.jpg",
            @"https://upload-images.jianshu.io/upload_images/2252551-1acb5713cbdf93d3.jpeg",
            @"https://upload-images.jianshu.io/upload_images/17879190-b722e7e6cd7837e0.jpg",
            @"https://upload-images.jianshu.io/upload_images/2252551-c4deb97c7b183f19.png",
            @"https://upload-images.jianshu.io/upload_images/2252551-a7c591e150e8ec18.jpg",
            @"https://upload-images.jianshu.io/upload_images/2252551-5230518adea5dd97.gif",
            @"https://upload-images.jianshu.io/upload_images/2252551-4424adc92f6cdedc.gif",
            @"http://static.soperson.com/itver/_img/18539951882/20170830/29881508570444471.jpg?w=2080&amp;h=1560",
            @"http://static.soperson.com/itver/_img/13390558883/20171020/13771508568302542.jpg?w=828&amp;h=587",
            @"http://static.soperson.com/itver/_img/13390558883/20171020/73021508568301961.jpg?w=828&amp;h=553",
            @"http://static.soperson.com/itver/_img/13390558883/20171020/12431508568301986.jpg?w=828&amp;h=559",
            @"http://static.soperson.com/itver/_img/15822996229/20170831/59271508567631443.jpg?w=828&amp;h=621",
            @"http://static.soperson.com/itver/_img/15822996229/20170831/36831508567630481.jpg?w=828&amp;h=621",
            @"http://static.soperson.com/itver/_img/15822996229/20170831/24871508567630995.jpg?w=828&amp;h=621",
            @"http://static.soperson.com/itver/_img/15822996229/20170831/97401508567631402.jpg?w=828&amp;h=621",
            @"http://static.soperson.com/itver/_img/15822996229/20170831/84081508567630927.jpg?w=828&amp;h=621",
            @"http://static.soperson.com/itver/_img/15822996229/20170831/1211508567630452.jpg?w=828&amp;h=1104",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/81291508567419143.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/55831508567420211.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/83301508567421021.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/58501508567419141.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/74001508567420621.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/3461508567421094.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/80471508567419483.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/69661508567420110.jpg?w=640&amp;h=360",
            @"http://static.soperson.com/itver/_img/15921859561/20171021/91441508567421638.jpg?w=640&amp;h=360",
        ];
    }
    return _imageUrlArray;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
@end
