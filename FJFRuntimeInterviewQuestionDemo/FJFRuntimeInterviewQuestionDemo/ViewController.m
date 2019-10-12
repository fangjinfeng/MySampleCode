//
//  ViewController.m
//  FJFRuntimeInterviewQuestionDemo
//
//  Created by macmini on 16/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFPerson.h"
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id cls = [FJFPerson class];
    
    void *obj = &cls;
    [(__bridge id)obj print];
    
    FJFPerson *tmpPerson = [[FJFPerson alloc] init];
    

}


@end
