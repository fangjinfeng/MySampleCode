//
//  FJFTableViewCell.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/4/21.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFTableViewCell.h"

@implementation FJFTableViewCell

#pragma mark - Life Circle

- (void)dealloc {
    NSLog(@"------------------");
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}


#pragma mark - Private Methods

- (void)setupViewControls {
    
}

- (void)layoutViewControls {
    
}

@end
