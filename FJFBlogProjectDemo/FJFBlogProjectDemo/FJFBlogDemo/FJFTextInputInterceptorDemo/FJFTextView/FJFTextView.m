//
//  IWTextView.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "FJFTextView.h"

@interface FJFTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation FJFTextView

#pragma mark -------------------------- Life Circle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewControls];
        [self addNotiObserver];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {

        [self setupViewControls];
        [self addNotiObserver];
    }
    return self;
}

#pragma mark -------------------------- Public Methods
// 清除提示语
- (void)clearPlaceHoder {
    self.placeholder = @"";
    [self textDidChange];
}

#pragma mark -------------------------- Noti Methods
- (void)textDidChange {
    self.placeholderLabel.hidden = (self.text.length != 0);
}


#pragma mark -------------------------- Setter / Getter

- (void)setPlaceholder:(NSString *)placeholder {
    if (self.text.length <= 0) {
        _placeholder = [placeholder copy];
        
        self.placeholderLabel.text = placeholder;
        if (placeholder.length) { // 需要显示
            self.placeholderLabel.hidden = NO;
            
            // 计算frame
            CGFloat placeholderX = 5;
            CGFloat placeholderY = 7;
            CGFloat maxW = self.frame.size.width - 2 * placeholderX;
            
            NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
            [attDic setObject:self.placeholderLabel.font forKey:NSFontAttributeName];
            CGSize placeholderSize = [placeholder boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:attDic
                                                            context:nil].size;
            self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
        } else {
            self.placeholderLabel.hidden = YES;
        }
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

#pragma mark -------------------------- Private Methods
- (void)setupViewControls {
    // 1.添加提示文字
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.textColor = [UIColor lightGrayColor];
    placeholderLabel.hidden = YES;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.font = self.font;
    [self insertSubview:placeholderLabel atIndex:0];
    self.placeholderLabel = placeholderLabel;
    
    self.textColor = [UIColor whiteColor];
}

- (void)addNotiObserver {
    // 2.监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

@end
