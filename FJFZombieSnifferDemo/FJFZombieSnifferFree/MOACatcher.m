
//
//  MOACatcher.m
//  MOAZombieSniffer
//
//  Created by fjf on 2018/7/30.
//  Copyright © 2018年 fjf. All rights reserved.
//


#include <objc/runtime.h>
#import "MOACatcher.h"

@implementation MOACatcher
- (BOOL)respondsToSelector: (SEL)aSelector
{
    return [self.originClass instancesRespondToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector: (SEL)sel
{
    return [self.originClass instanceMethodSignatureForSelector:sel];
}

- (void)forwardInvocation: (NSInvocation *)invocation
{
    [self _throwMessageSentExceptionWithSelector: invocation.selector];
}


#define MOAZombieThrowMesssageSentException() [self _throwMessageSentExceptionWithSelector: _cmd]
- (Class)class
{
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (BOOL)isEqual:(id)object
{
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (NSUInteger)hash
{
    MOAZombieThrowMesssageSentException();
    return 0;
}

- (id)self
{
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    MOAZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)isProxy
{
    MOAZombieThrowMesssageSentException();
    
    return NO;
}

- (id)retain
{
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (oneway void)release
{
    MOAZombieThrowMesssageSentException();
}

- (id)autorelease
{
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (void)dealloc
{
    MOAZombieThrowMesssageSentException();
    [super dealloc];
}

- (NSUInteger)retainCount
{
    MOAZombieThrowMesssageSentException();
    return 0;
}

- (NSZone *)zone
{
    MOAZombieThrowMesssageSentException();
    return nil;
}

- (NSString *)description
{
    MOAZombieThrowMesssageSentException();
    return nil;
}


#pragma mark - Private
- (void)_throwMessageSentExceptionWithSelector: (SEL)selector
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"(-[%@ %@]) was sent to a zombie object at address: %p", NSStringFromClass(self.originClass), NSStringFromSelector(selector), self] userInfo:nil];
}

@end
