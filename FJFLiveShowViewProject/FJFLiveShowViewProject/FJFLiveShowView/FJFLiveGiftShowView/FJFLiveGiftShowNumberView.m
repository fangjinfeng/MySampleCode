//
//  FJFLiveGiftShowNumberView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/24/20.
//  Copyright © 2020 macmini. All rights reserved.
//

#import "FJFLiveGiftShowNumberView.h"
#import "FJFLiveDefine.h"

@interface FJFLiveGiftShowNumberView ()

@property (nonatomic ,strong) UIImageView * digitIV;
@property (nonatomic ,strong) UIImageView * ten_digitIV;
@property (nonatomic ,strong) UIImageView * hundredIV;
@property (nonatomic ,strong) UIImageView * thousandIV;

@property (nonatomic ,strong) UIImageView * xIV;

@end

@implementation FJFLiveGiftShowNumberView

@synthesize number = _number;


/**
 改变数字显示
 
 @param numberStr 显示的数字
 */
- (void)changeNumber:(NSInteger)numberStr{
    if (numberStr <= 0) {
        return;
    }
    
    NSInteger num = numberStr;
    NSInteger qian = num / 1000;
    NSInteger qianYu = num % 1000;
    NSInteger bai = qianYu / 100;
    NSInteger baiYu = qianYu % 100;
    NSInteger shi = baiYu / 10;
    NSInteger shiYu = baiYu % 10;
    NSInteger ge = shiYu;
    
    if (numberStr > 9999) {
        qian = 9;
        bai = 9;
        shi = 9;
        ge = 9;
    }
    [self addSubview:self.xIV];
    [self.xIV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.centerY.equalTo(self).offset(2);
        make.width.equalTo(@16);
    }];
    
    [self addSubview:self.digitIV];
    [self.digitIV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xIV.mas_right).offset(3);
        make.centerY.equalTo(self);
    }];
    
    NSInteger length = 1;
    
    if (qian > 0) {
        length = 4;
        [self addSubview:self.thousandIV];
        [self addSubview:self.hundredIV];
        [self addSubview:self.ten_digitIV];
        
        self.thousandIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",ge]];
        self.hundredIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",shi]];
        self.ten_digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",bai]];
        self.digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",qian]];
        
        [self.thousandIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hundredIV.mas_right).offset(3);
            make.centerY.equalTo(self);
        }];
        [self.hundredIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ten_digitIV.mas_right).offset(3);
            make.centerY.equalTo(self);
        }];
        [self.ten_digitIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.digitIV.mas_right).offset(3);
            make.centerY.equalTo(self.digitIV);
        }];
    }else if (bai > 0){
        length = 3;
        [self.thousandIV removeFromSuperview];
        [self addSubview:self.hundredIV];
        [self addSubview:self.ten_digitIV];
        
        self.hundredIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",ge]];
        self.digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",bai]];
        self.ten_digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",shi]];

        [self.hundredIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ten_digitIV.mas_right).offset(3);
            make.centerY.equalTo(self);
        }];
        
        [self.ten_digitIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.digitIV.mas_right).offset(3);
            make.centerY.equalTo(self.digitIV);
        }];
    }else if (shi > 0){
        length = 2;
        [self.thousandIV removeFromSuperview];
        [self.hundredIV removeFromSuperview];
        [self addSubview:self.ten_digitIV];
        self.digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",shi]];
        self.ten_digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",ge]];
        [self.ten_digitIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.digitIV.mas_right).offset(3);
            make.centerY.equalTo(self.digitIV);
        }];
    }else {
        self.digitIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ChatRoom_giftNumber_%zi",ge]];
        length = 1;
        [self.thousandIV removeFromSuperview];
        [self.hundredIV removeFromSuperview];
        [self.ten_digitIV removeFromSuperview];
    }
    
    [self layoutIfNeeded];
}

- (UIImageView *)xIV{
    if (!_xIV) {
        _xIV = [self creatIV];
        _xIV.image = [UIImage imageNamed:@"ChatRoom_giftNumber_x"];
    }
    return _xIV;
}

- (UIImageView *)digitIV{
    if (!_digitIV) {
        _digitIV = [self creatIV];
    }
    return _digitIV;
}

- (UIImageView *)ten_digitIV{
    if (!_ten_digitIV) {
        _ten_digitIV = [self creatIV];
    }
    return _ten_digitIV;
}

- (UIImageView *)hundredIV{
    if (!_hundredIV) {
        _hundredIV = [self creatIV];
    }
    return _hundredIV;
}

- (UIImageView *)thousandIV{
    if (!_thousandIV) {
        _thousandIV = [self creatIV];
    }
    return _thousandIV;
}

- (UIImageView *)creatIV{
    UIImageView * iv = [[UIImageView alloc]init];
    return iv;
}


@end
