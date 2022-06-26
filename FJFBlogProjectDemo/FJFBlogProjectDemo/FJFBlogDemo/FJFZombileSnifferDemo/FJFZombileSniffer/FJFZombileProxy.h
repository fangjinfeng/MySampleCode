//
//  FJFZombileProxy.h
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2021/11/25.
//  Copyright © 2021 方金峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFZombileProxy : NSProxy
@property (nonatomic, assign) Class originClass;
@end

NS_ASSUME_NONNULL_END
