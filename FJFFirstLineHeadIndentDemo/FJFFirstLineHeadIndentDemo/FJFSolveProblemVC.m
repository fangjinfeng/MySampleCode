//
//  FJFSolveProblemVC.m
//  FJFFirstLineHeadIndentDemo
//
//  Created by MacMini on 10/16/20.
//

#import "FJFSolveProblemVC.h"

@interface FJFSolveProblemVC ()
// testLabel
@property (nonatomic, strong) UILabel *testLabel;
@end

@implementation FJFSolveProblemVC

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
    self.testLabel.numberOfLines = 0;


    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 7;

    // 占位符
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image =  [FJFSolveProblemVC xm_imageWithColor:[UIColor clearColor] imageSize:CGSizeMake(150, 14)];
    NSAttributedString *blankImageAttrStr = [NSAttributedString attributedStringWithAttachment:attchImage];
    
    
    NSString *message = @"yank3:发送一个直播间红包!";
    NSDictionary *attrs = @{
            NSFontAttributeName : [UIFont systemFontOfSize:14],
            NSForegroundColorAttributeName : [UIColor redColor],
            NSParagraphStyleAttributeName : paraStyle,
            NSAttachmentAttributeName: attchImage,
    };
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:message];
    [attrText insertAttributedString:blankImageAttrStr atIndex:0];
    self.testLabel.attributedText = [[NSAttributedString alloc]initWithString:[attrText string] attributes:attrs];
    self.testLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.testLabel];
    
}

#pragma mark - Private Methods
+ (UIImage *)xm_imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize {
    if (color == nil) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
