//
//  FJFPerson.m
//  FJFRuntimeInterviewQuestionDemo
//
//  Created by macmini on 16/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFPerson.h"

@implementation FJFPerson
- (void)print {
    NSLog(@"self: %p", self);
    NSLog(@"self.name: %p", &_name);
    
    NSLog(@"my name is %@", self.name);
}
@end
