//
//  MOACatcher.h
//  MOAZombieSniffer
//
//  Created by fjf on 2018/7/30.
//  Copyright © 2018年 fjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOACatcher : NSProxy
@property (nonatomic, assign) Class originClass;
@end
