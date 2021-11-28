//
//  FJFZombileProxy.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2021/11/25.
//  Copyright © 2021 方金峰. All rights reserved.
//

#include <objc/runtime.h>
#import "FJFZombileProxy.h"

@implementation FJFZombileProxy
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


#define FJFZombieThrowMesssageSentException() [self _throwMessageSentExceptionWithSelector: _cmd]
- (Class)class
{
    FJFZombieThrowMesssageSentException();
    return nil;
}

- (BOOL)isEqual:(id)object
{
    FJFZombieThrowMesssageSentException();
    return NO;
}

- (NSUInteger)hash
{
    FJFZombieThrowMesssageSentException();
    return 0;
}

- (id)self
{
    FJFZombieThrowMesssageSentException();
    return nil;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    FJFZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    FJFZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    FJFZombieThrowMesssageSentException();
    return NO;
}

- (BOOL)isProxy
{
    FJFZombieThrowMesssageSentException();
    
    return NO;
}

- (id)retain
{
    FJFZombieThrowMesssageSentException();
    return nil;
}

- (oneway void)release
{
    FJFZombieThrowMesssageSentException();
}

- (id)autorelease
{
    FJFZombieThrowMesssageSentException();
    return nil;
}

- (void)dealloc
{
    FJFZombieThrowMesssageSentException();
    [super dealloc];
}

- (NSUInteger)retainCount
{
    FJFZombieThrowMesssageSentException();
    return 0;
}

- (NSZone *)zone
{
    FJFZombieThrowMesssageSentException();
    return nil;
}

- (NSString *)description
{
    FJFZombieThrowMesssageSentException();
    return nil;
}


#pragma mark - Private
- (void)_throwMessageSentExceptionWithSelector: (SEL)selector
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"(-[%@ %@]) was sent to a zombie object at address: %p", NSStringFromClass(self.originClass), NSStringFromSelector(selector), self] userInfo:nil];
}

@end
