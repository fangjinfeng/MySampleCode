//
//  FJFLiveMarqueeBaseView.m
//  FJFLiveShowViewProject
//
//  Created by macmini on 9/8/20.
//  Copyright © 2020 FJFLiveShowViewProject. All rights reserved.
//

#import "FJFLiveMarqueeBaseView.h"

@implementation FJFLiveMarqueeBaseView

#pragma mark - Life Circle
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.creatDate = [NSDate date];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateControlsWithMarqueeModel:(FJFLiveMarqueeBaseModel *)marqueeModel {
    _marqueeModel = marqueeModel;
}

- (void)sizeToFit {
    CGFloat height = 0.0;
    CGFloat width = 0.0;
    for (CALayer *sublayer in self.layer.sublayers) {
        CGFloat maxY = CGRectGetMaxY(sublayer.frame);
        if (maxY > height) {
            height = maxY;
        }
        CGFloat maxX = CGRectGetMaxX(sublayer.frame);
        if (maxX > width) {
            width = maxX;
        }
    }
    
    if (width == 0 || height == 0) {
        CGImageRef content = (__bridge CGImageRef)self.layer.contents;
        if (content) {
            UIImage *image = [UIImage imageWithCGImage:content];
            width = image.size.width/[UIScreen mainScreen].scale;
            height = image.size.height/[UIScreen mainScreen].scale;
        }
    }
    self.baseViewSize = CGSizeMake(width, height);
}
@end
