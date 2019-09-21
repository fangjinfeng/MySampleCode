
//
//  FJFMarqueeView.h
//  ButtonPopMenu
//
//  Created by fjf on 06/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "FJFMarqueeView.h"
#import <JhtMarquee/JhtHorizontalMarquee.h>

@implementation FJFMarqueeView

#pragma mark - Life Circle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupViewControls {
    
    [self addSubview:self.marqueeLabel];

    self.shadowViewLayer.frame = self.bounds;
    self.shadowViewLayer.colors =@[(id)kRGBColorAlpha(0, 0, 0, 0.3).CGColor, (id)kRGBColorAlpha(0, 0, 0, 1.0).CGColor, (id)kRGBColorAlpha(0, 0, 0, 1.0).CGColor, (id)kRGBColorAlpha(0, 0, 0, 0.3).CGColor];
    self.shadowViewLayer.startPoint = CGPointMake(0, 0);
    self.shadowViewLayer.endPoint = CGPointMake(1, 0);
    self.shadowViewLayer.locations = @[@(0.0f), @(0.3f),@(0.7f), @(1.0f)];
    self.layer.mask = self.shadowViewLayer;
}


#pragma mark - setter / getter
// marqueeLabel
- (JhtHorizontalMarquee *)marqueeLabel {
    if (!_marqueeLabel) {
        _marqueeLabel = [[JhtHorizontalMarquee alloc] initWithFrame:self.bounds singleScrollDuration:0.0];
        _marqueeLabel.text = @"生活是个大傻逼!    ";
        _marqueeLabel.numberOfLines = 1;
        _marqueeLabel.textAlignment = NSTextAlignmentCenter;
        [_marqueeLabel marqueeOfSettingWithState:MarqueeStart_H];
    }
    return _marqueeLabel;
}


// shadowViewLayer
- (CAGradientLayer *)shadowViewLayer {
    if (!_shadowViewLayer) {
        _shadowViewLayer = [CAGradientLayer layer];
    }
    return _shadowViewLayer;
}

@end
