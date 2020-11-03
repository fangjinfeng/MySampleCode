//
//  NSISEngine+methodSwizze.m
//  Autolayout
//
//  Created by nangezao on 2018/9/24.
//  Copyright © 2018 Tang Nan. All rights reserved.
//

#import "NSISEngine+methodSwizze.h"
#import <objc/runtime.h>
#import "NSContentSizeLayoutConstraint.h"
#import "_UILayoutSupportConstraint.h"

@import UIKit;

@interface NSObject(methodExchange)
+ (void)replace:(SEL)old byNew:(SEL)new;
@end

@implementation NSISEngine (methodSwizze)

+ (void)load{
  [self replace:@selector(init) byNew:@selector(new_init)];
  
  NSString *version = [UIDevice currentDevice].systemVersion;
  
  if(version.doubleValue < 12.0) {
    [self replace:@selector(tryAddingDirectly:) byNew:@selector(new_tryToAdd:)];
  }
}

- (id)new_init{
  NSLog(@"New NSISEnginer");
  return [self new_init];
}

- (BOOL)new_tryToAdd:(id)arg{
//  NSLog(@"tryToAddConstraiont");
  return [self new_tryToAdd:arg];
}

@end

@implementation NSLayoutConstraint (methodSwizze)

+ (void)load{
   [self replace:@selector(init) byNew:@selector(new_init)];
}

- (instancetype)new_init{
  NSLog(@"New %@",[self class]);
  return [self new_init];
}

@end


//@implementation _UILayoutSupportConstraint (methodSwizze)
//
//+ (void)load{
//  [self replace:@selector(init) byNew:@selector(new_init)];
//}
//
//- (instancetype)new_init{
//  NSLog(@"New NSContentSizeLayoutConstraint");
//  return [self new_init];
//}
//
//@end



@implementation NSObject(methodExchange)

+ (void)replace:(SEL)old byNew:(SEL)new{
  Method oldMethod = class_getInstanceMethod([self class], old);
  Method newMethod = class_getInstanceMethod([self class], new);
  
  method_exchangeImplementations(oldMethod, newMethod);
}

@end
