//
//  FJFLiveGiftShowView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 8/21/20.
//  Copyright © 2020 FJFLiveShowViewProject. All rights reserved.
//

// tool
#import "FJFLiveDefine.h"
// model
#import "FJFLiveGiftShowModel.h"
// view
#import "FJFLiveGiftShowView.h"
#import "FJFLiveGiftShowNumberView.h"

static CGFloat const kNameLabelFont = 14.0;//送礼者

static CGFloat const kGiftLabelFont = 11;//送出礼物寄语  字体大小


@interface FJFLiveGiftShowView ()
@property (nonatomic ,weak) UIImageView * levelIV;/**< 等级 */
@property (nonatomic ,weak) UIImageView * avatarIV;/**< 头像 */
@property (nonatomic ,weak) UIImageView * backIV;/**< 背景图 */
@property (nonatomic ,weak) UILabel * nameLabel;/**< 名称 */
@property (nonatomic ,weak) UILabel * sendLabel;/**< 送出 */
@property (nonatomic ,strong) UIImageView * giftIV;/**< 礼物图片 */
@property (nonatomic ,weak) FJFLiveGiftShowNumberView * numberView;
@property (nonatomic ,assign) BOOL isSetNumber;
// 是否展示完 所有数字 isCompletedNumShow
@property (nonatomic, assign) BOOL  isCompletedNumShow;
// 需要 显示数字 showNumberArray
@property (nonatomic, strong) NSMutableArray <NSNumber *>*showNumberMarray;
@end

@implementation FJFLiveGiftShowView

#pragma mark - 初始化
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentContraints];
        self.creatDate = [NSDate date];
        self.kTimeOut = 2;
        self.isCompletedNumShow = YES;
        self.kRemoveAnimationTime = 0.5;
        self.kNumberAnimationTime = 0.25;
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateControlsWithLiveModel:(FJFLiveAnimationBaseModel *)liveModel {
    if (!liveModel) {
        return;
    }
    [super updateControlsWithLiveModel:liveModel];
    if ([liveModel isKindOfClass:[FJFLiveGiftShowModel class]]) {
        FJFLiveGiftShowModel *showModel = (FJFLiveGiftShowModel *)liveModel;
        self.nameLabel.text = showModel.sendName;
        self.sendLabel.text = [NSString stringWithFormat:@"送出%@",  showModel.giftName];
        self.avatarIV.image = [UIImage imageNamed:showModel.headImageName];
        self.giftIV.image = [UIImage imageNamed:showModel.giftImageName];
        [self updateNumberWithNewNumber:showModel.currentNumber needOverlayNumber:showModel.needOverlayNumber];
        self.backIV.image = [UIImage imageNamed:showModel.backImageName];
    }
}

- (void)updateNumberWithNewNumber:(NSInteger)newNumer needOverlayNumber:(BOOL)needOverlayNumber{
    if (needOverlayNumber) {
        if (!self.isCompletedNumShow) {
           [self.showNumberMarray addObject:(@(newNumer))];
           return;
        }
        self.isCompletedNumShow = NO;
        NSInteger preNumber = self.numberView.number;
        for (NSInteger tmpIndex =  1; tmpIndex <= newNumer; tmpIndex++) {
           CGFloat delayTime = tmpIndex * 0.3;
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self resetTimeAndNumberFrom:(preNumber + tmpIndex)];
               if (tmpIndex == newNumer) {
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.kNumberAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       self.isCompletedNumShow = YES;
                       [self updateNumberWhenShowCompleted];
                   });
               }
           });
        }
    } else {
        [self resetTimeAndNumberFrom:newNumer];
    }
}

- (void)updateNumberWhenShowCompleted {
    if (self.showNumberMarray.count > 0) {
        NSNumber *tmpNewNumber = self.showNumberMarray.firstObject;
        [self updateNumberWithNewNumber:tmpNewNumber.integerValue needOverlayNumber:NO];
        [self.showNumberMarray removeObject:tmpNewNumber];
    }
}

/**
 重置定时器和计数
 
 @param number 计数
 */
- (void)resetTimeAndNumberFrom:(NSInteger)number{
    self.numberView.number = number;
    [self addGiftNumberFrom:number];
}

/**
 获取用户名

 @return 获取用户名
 */
- (NSString *)getUserName{
    return self.nameLabel.text;
}

/**
 礼物数量自增1使用该方法

 @param number 从多少开始计数
 */
- (void)addGiftNumberFrom:(NSInteger)number{
    if (!self.isSetNumber) {
        self.numberView.number = number;
        self.isSetNumber = YES;
    }
    //每调用一次self.numberView.number get方法 自增1
    NSInteger num = self.numberView.number;
    [self.numberView changeNumber:num];
    [self handleNumber:num];
    self.liveModel.currentNumber = num;
    self.creatDate = [NSDate date];
}


/**
 设置任意数字时使用该方法

 @param number 任意数字 >9999 则显示9999
 */
- (void)changeGiftNumber:(NSInteger)number{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.numberView changeNumber:number];
        [self handleNumber:number];
    });
}

#pragma mark - Private
/**
 处理显示数字 开启定时器

 @param number 显示数字的值
 */
- (void)handleNumber:(NSInteger )number{
    [self resetTimer];
    //根据数字修改self.giftIV的约束 比如 1 占 10 的宽度，10 占 20的宽度
    if (!CGAffineTransformIsIdentity(self.numberView.transform)) {
        [self.numberView.layer removeAllAnimations];
    }
    self.numberView.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:self.kNumberAnimationTime animations:^{
        self.numberView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        if (finished) {
            self.numberView.transform = CGAffineTransformIdentity;
        }
    }];
}


- (void)setupContentContraints{
    [self.backIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).mas_offset(12);
        make.right.equalTo(self).mas_offset(-40);
    }];

    CGFloat avatarSize = 34;
    [self.avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(avatarSize);
        make.centerY.equalTo(self.backIV);
        make.left.equalTo(self.backIV).mas_offset(2);
    }];
    self.avatarIV.layer.cornerRadius = avatarSize/2.0f;
    
    CGFloat levelSize = 23;
    [self.levelIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(levelSize);
        make.centerY.equalTo(self.avatarIV).mas_offset(8);
        make.left.equalTo(self.avatarIV.mas_right).mas_offset(-15);
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarIV);
        make.left.equalTo(self.avatarIV.mas_right).mas_offset(8);
        make.width.lessThanOrEqualTo(@84);
    }];
    
    [self.sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarIV);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.nameLabel);
    }];
    
    [self.giftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backIV).offset(-52);
        make.height.width.equalTo(@46);
        make.centerY.equalTo(self);
    }];
    
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backIV.mas_right);
        make.height.equalTo(self);
        make.centerY.equalTo(self).mas_offset(10);
    }];
}

#pragma mark - Public Methods

- (UIImageView *)avatarIV{
    if (!_avatarIV) {
        _avatarIV = [self creatIV];
        _avatarIV.clipsToBounds = YES;
        _avatarIV.layer.borderColor = FJF_RGBColor(255, 255, 255).CGColor;
        _avatarIV.layer.borderWidth = 0.5;
    }
    return _avatarIV;
}

- (UIImageView *)levelIV{
    if (!_levelIV) {
        _levelIV = [self creatIV];
        _levelIV.clipsToBounds = YES;
    }
    return _levelIV;
}


- (UIImageView *)backIV{
    if (!_backIV) {
        _backIV = [self creatIV];
        _backIV.contentMode = UIViewContentModeScaleAspectFill;
        _backIV.image = [UIImage imageNamed:@"fjf_anchor_gift_special_normal_icon"];
    }
    return _backIV;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self creatLabel];
        _nameLabel.textColor = FJF_RGBColor(255, 237, 0);
        _nameLabel.font = FJF_PingFangRegular_Font(kNameLabelFont);
    }
    return _nameLabel;
}

- (UILabel *)sendLabel{
    if (!_sendLabel) {
        _sendLabel = [self creatLabel];
        _sendLabel.font = FJF_PingFangRegular_Font(kGiftLabelFont);
        _sendLabel.textColor = UIColor.whiteColor;
        _sendLabel.text = @"送出";
    }
    return _sendLabel;
}

- (UIImageView *)giftIV {
    if (!_giftIV) {
         _giftIV = [self creatIV];
        _giftIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _giftIV;
}

- (FJFLiveGiftShowNumberView *)numberView{
    if (!_numberView) {
        FJFLiveGiftShowNumberView * nv = [[FJFLiveGiftShowNumberView alloc]init];
        [self addSubview:nv];
        _numberView = nv;
    }
    return _numberView;
}

- (UIImageView *)creatIV{
    UIImageView * iv = [[UIImageView alloc]init];
    [self addSubview:iv];
    return iv;
}

- (UILabel * )creatLabel{
    UILabel * label = [[UILabel alloc]init];
    [self addSubview:label];
    return label;
}

// 需要显示 号码数量
- (NSMutableArray <NSNumber *> *)showNumberMarray {
    if (!_showNumberMarray) {
        _showNumberMarray = [[NSMutableArray alloc] init];
    }
    return _showNumberMarray;
}
@end
