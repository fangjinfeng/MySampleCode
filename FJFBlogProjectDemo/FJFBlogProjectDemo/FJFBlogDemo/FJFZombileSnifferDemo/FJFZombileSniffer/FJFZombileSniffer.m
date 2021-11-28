//
//  FJFZombileSniffer.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2021/11/25.
//  Copyright © 2021 方金峰. All rights reserved.
//


#import <dlfcn.h>
#include <stdatomic.h>
#include <objc/runtime.h>
#include <malloc/malloc.h>

#import "fishhook.h"
#import "FJFZombileProxy.h"
#import "FJFZombileSniffer.h"

static Class _ZombileProxyIsa;

static size_t _ZombileProxySize;

// 原始的free函数
static void(* orig_free)(void *p);

// 僵尸 对象 默认 容量
static u_int64_t _ZombieObjectDefaultCapacity = 10000;

// 已注册的类
static CFMutableSetRef _RegisteredClassList = nil;

// 僵尸对象 队列容量
static u_int64_t _ZombieObjectQueueCapacity = 0;

// 自增计算器
static atomic_ullong _ZombieObjectIncrementer = 0;

// 僵尸 对象 队列
static atomic_uintptr_t **_ZombieObjectQueue = NULL;


@implementation FJFZombileSniffer

#pragma mark - Public Methods
// 开始 僵尸 对象探测器
+ (void)startZombileSniffer {
    loadZombileProxyClass();
    initZombileSniffer();
}

#pragma mark - Private  Methods
// 僵尸 对象 队列 初始化
static void _ZombileObjectQueueInit(u_int64_t zombileCount) {
    _ZombieObjectQueueCapacity = zombileCount;
    _ZombieObjectQueue = (atomic_uintptr_t **)malloc(sizeof(atomic_uintptr_t *) * _ZombieObjectQueueCapacity);
    for (u_int64_t i = 0; i < _ZombieObjectQueueCapacity; i++) {
        _ZombieObjectQueue[i] = calloc(1, sizeof(atomic_uintptr_t));
    }
}

static void *addZombileObject(void *zombileObject) {
    unsigned long long value = atomic_fetch_add_explicit(&_ZombieObjectIncrementer, 1, memory_order_relaxed);
    atomic_uintptr_t *oldZombile = _ZombieObjectQueue[(value % _ZombieObjectIncrementer)];
    return (void *)atomic_exchange(oldZombile, (uintptr_t)zombileObject);
}

// 替换free函数
static void safe_free(void* p){
    size_t memSiziee = malloc_size(p);
    if (memSiziee > _ZombileProxySize) {//有足够的空间才覆盖
        id obj = (__bridge id)p;
        Class origClass = object_getClass(obj);
        // 判断是不是objc对象
        char *type = @encode(typeof(obj));
        if (strcmp("@", type) == 0 &&
            CFSetContainsValue(_RegisteredClassList, (__bridge const void *)(origClass))) {
            memset(p, 0x55, memSiziee);
            memcpy(p, &_ZombileProxyIsa, sizeof(void*));//把我们自己的类的isa复制过去
            object_setClass(obj, [FJFZombileProxy class]);
            ((FJFZombileProxy *)obj).originClass = origClass;
            addZombileObject(p);
        }else{
           orig_free(p);
        }
    }else{
       orig_free(p);
    }
}

// 加载 僵尸对象代理类
static void loadZombileProxyClass() {
    _RegisteredClassList = CFSetCreateMutable(NULL, 0, NULL);

    unsigned int count = 0;
    Class *classes = objc_copyClassList(&count);
    for (unsigned int i = 0; i < count; i++) {
        CFSetAddValue(_RegisteredClassList, (__bridge const void *)(classes[i]));
    }
    free(classes);
    classes = NULL;
    
    _ZombileProxyIsa = objc_getClass("FJFZombileProxy");
    _ZombileProxySize = class_getInstanceSize(_ZombileProxyIsa);
}

// 初始化 僵尸对象探测器
static void initZombileSniffer() {
    _ZombileObjectQueueInit(_ZombieObjectDefaultCapacity);
    orig_free = (void(*)(void*))dlsym(RTLD_DEFAULT, "free");
    rebind_symbols((struct rebinding[]){{"free", (void*)safe_free}}, 1);
}


@end
