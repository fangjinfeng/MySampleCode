//
//  NSObject+FJFSwizzle.h
//  FJFBlogProject
//
//  Created by peakfang on 2022/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FJFSwizzle)
+ (BOOL)fjf_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_;
+ (BOOL)fjf_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_;

+ (BOOL)fjf_swizzleMethod:(SEL)origSel_  withClass:(Class)altCla_ withMethod:(SEL)altSel_ error:(NSError **)error_;
@end

NS_ASSUME_NONNULL_END
