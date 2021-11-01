//
//  FJFPermanentThread.h
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/10/8.
//  Copyright © 2021 fjf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFPermanentThread : NSObject
-(void)doAction:(dispatch_block_t)action;
-(void)cancel;
@end

NS_ASSUME_NONNULL_END
