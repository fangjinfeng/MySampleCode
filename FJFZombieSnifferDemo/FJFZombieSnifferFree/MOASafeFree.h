//
//  MOASafeFree.h
//  MOAZombieSniffer
//
//  Created by fjf on 2018/7/30.
//  Copyright © 2018年 fjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOASafeFree : NSObject
//系统内存警告的时候调用这个函数释放一些内存
void free_some_mem(size_t freeNum);
@end
