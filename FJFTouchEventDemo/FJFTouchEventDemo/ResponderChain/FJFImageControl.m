//
//  FJFImageControl.m
//  FJFButtonTestProject
//
//  Created by 方金峰 on 2019/2/11.
//  Copyright © 2019年 方金峰. All rights reserved.
//

#import "FJFImageControl.h"

@interface FJFImageControl()
// title
@property (nonatomic, copy) NSString *title;
// iconImageName
@property (nonatomic, copy) NSString *iconImageName;
@end
@implementation FJFImageControl
#pragma mark -------------------------- Life Circle

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                    iconImageName:(NSString *)iconImageName {
    if (self = [super initWithFrame:frame]) {
        _title = [title copy];
        _iconImageName = [iconImageName copy];
        [self setupViewControls];
        
    }
    return self;
}

#pragma mark -------------------------- Private Methods

- (void)setupViewControls {
    // 图片
    self.iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.image = [UIImage imageNamed:_iconImageName];
    [self addSubview:self.iconImageView];
    
    // 标题
    CGFloat tipLabelHeight = 30.0f;
    CGFloat tipLabelY = self.frame.size.height - tipLabelHeight;
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLabelY, self.frame.size.width, tipLabelHeight)];
    self.tipLabel.text = _title;
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tipLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesCancelled:touches withEvent:event];
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
    return YES;
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
    return YES;
}


- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
}


- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    NSLog(@"%s",__func__);
}
@end
