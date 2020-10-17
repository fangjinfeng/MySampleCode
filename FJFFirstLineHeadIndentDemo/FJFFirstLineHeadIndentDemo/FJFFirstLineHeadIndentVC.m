//
//  FJFFirstLineHeadIndentVC.m
//  FJFFirstLineHeadIndentDemo
//
//  Created by MacMini on 10/16/20.
//

#import "FJFFirstLineHeadIndentVC.h"

@interface FJFFirstLineHeadIndentVC ()
// testLabel
@property (nonatomic, strong) UILabel *testLabel;
@end

@implementation FJFFirstLineHeadIndentVC
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
    self.testLabel.numberOfLines = 0;


    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.firstLineHeadIndent = 150;
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 7;

    
    NSString *message = @"yank3:发送一个直播间红包!";
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor redColor], NSParagraphStyleAttributeName : paraStyle};
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:message attributes:attrs];


    self.testLabel.attributedText = attrText;
    self.testLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.testLabel];
    
}
@end
