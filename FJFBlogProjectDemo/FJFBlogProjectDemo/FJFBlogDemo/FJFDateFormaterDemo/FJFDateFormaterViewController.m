//
//  FJFDateFormaterViewController.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/6/25.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFDateFormaterViewController.h"

@interface FJFDateFormaterViewController ()

@end

@implementation FJFDateFormaterViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    [self testDateFormatterOne];
    [self testDateFormatterSecond];
    [self testDateFormatterThree];
}


#pragma mark - Private Methods
- (void)testDateFormatterOne {
    double startTime = CFAbsoluteTimeGetCurrent();
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    for (int i = 0; i < 100000; i++) {
        if (i % 3 == 0) {
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd-HH:mm:ss-SSS";
        }
        else if (i % 3 == 1) {
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
        else if (i % 3 == 2) {
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"HH:mm:ss";
        }
        [formatter stringFromDate:[NSDate date]];
//        [formatter dateFromString:@"2022-06-25 22:52:10"];
    }
    [self costTimeWithStartTime:startTime tipStr:@"testDateFormatterOne"];
}

- (void)testDateFormatterSecond {
    double startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100000; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        formatter.dateFormat = @"yyyy-MM-dd";
//        if (i % 3 == 0) {
//            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//            formatter.dateFormat = @"yyyy-MM-dd-HH:mm:ss-SSS";
//        }
//        else if (i % 3 == 1) {
//            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
//            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        }
//        else if (i % 3 == 2) {
//            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//            formatter.dateFormat = @"HH:mm:ss";
//        }
        [formatter stringFromDate:[NSDate date]];
//        [formatter dateFromString:@"2022-06-25 22:52:10"];
    }
    [self costTimeWithStartTime:startTime tipStr:@"testDateFormatterSecond"];
}

- (void)testDateFormatterThree {
    double startTime = CFAbsoluteTimeGetCurrent();
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"yyyy-MM-dd";
    for (int i = 0; i < 100000; i++) {
        [formatter stringFromDate:[NSDate date]];
//        [formatter dateFromString:@"2022-06-25 22:52:10"];
    }
    [self costTimeWithStartTime:startTime tipStr:@"testDateFormatterThree"];
}

- (void)costTimeWithStartTime:(double)startTime tipStr:(NSString *)tipStr {
    double costTime = CFAbsoluteTimeGetCurrent() - startTime;
    NSLog(@"----------------提示语:%@, costTime: %lf",tipStr, costTime * 1000);
}
@end
