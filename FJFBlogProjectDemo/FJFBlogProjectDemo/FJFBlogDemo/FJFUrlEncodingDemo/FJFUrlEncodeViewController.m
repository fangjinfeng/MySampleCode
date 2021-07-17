//
//  FJFUrlEncodeViewController.m
//  FJFBlogDemo
//
//  Created by jspeakfang on 1/2/21.
//

#import "NSString+MethodTool.h"
#import "FJFUrlEncodeViewController.h"

@interface FJFUrlEncodeViewController ()

@end

@implementation FJFUrlEncodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 0 - 9字符集
    NSString *numberStr = @"0123456789";
    NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:numberStr];
    NSString *str = @"7chinafjf78990love";
    // 过滤str字符串里面的0-9内的字符
    NSLog(@"numberSet----%@",[[str componentsSeparatedByCharactersInSet:numberSet] componentsJoinedByString:@""]);
    
    // 保留str字符串里面的0-9内的字符
    NSCharacterSet *invertedSet = [[NSCharacterSet characterSetWithCharactersInString:numberStr] invertedSet];
    NSLog(@"invertedSet----%@",[[str componentsSeparatedByCharactersInSet:invertedSet] componentsJoinedByString:@""]);
 
    

    NSString *tmpUrlString = @"https://www.baidu.com/devtest-news/app/news/keyword/recommend?keyword=土甲,巴利基斯,萨姆桑斯堡&test=你好*2";
    
    NSLog(@"编码后的请求地址:%@\n", [NSString fjf_encodeUrlStringWithString:tmpUrlString]);

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Util Method


@end
