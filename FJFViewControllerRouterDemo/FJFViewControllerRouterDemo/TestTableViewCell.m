//
//  TestTableViewCell.m
//  FJFViewControllerRouterDemo
//
//  Created by 方金峰 on 2019/8/20.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import "UIResponder+Router.h"
#import "TestTableViewCell.h"

@interface TestTableViewCell ()

/**
 随机数
 */
@property (nonatomic,strong)NSNumber *randomNumber;
@end

@implementation TestTableViewCell

- (NSString *)userName {
    return [NSString stringWithFormat:@"按钮%@",self.randomNumber];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]];
        
        NSNumber *randomNumber = @(arc4random_uniform(100));
        self.randomNumber = randomNumber;
        NSString *buttonTitle = [NSString stringWithFormat:@"按钮%@",randomNumber];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.frame = CGRectMake(self.contentView.bounds.size.width / 2, 10, 100, 30);
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
    return self;
}

- (void)buttonClickAction:(UIButton *)sender {
    sender.fjf_viewControllerResponseBlock(self, sender, [self userName]);
}

@end
