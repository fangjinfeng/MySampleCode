
//
//  FJFTextInputIntercepter.m
//  FJTextInputIntercepterDemo
//
//  Created by fjf on 2018/7/4.
//  Copyright © 2018年 fjf. All rights reserved.
//

#import "FJFTextInputIntercepter.h"
#import <objc/runtime.h>
// category
#import "NSString+FJFTextInputStringType.h"



//UITextField

@interface UITextField (FJFTextInputIntercepter)

@property (nonatomic, strong) FJFTextInputIntercepter *yb_textInputIntercepter;

@end


@implementation UITextField (FJFTextInputIntercepter)

- (void)setYb_textInputIntercepter:(FJFTextInputIntercepter *)yb_textInputIntercepter {
    objc_setAssociatedObject(self, @selector(yb_textInputIntercepter), yb_textInputIntercepter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FJFTextInputIntercepter *)yb_textInputIntercepter {
    return objc_getAssociatedObject(self, @selector(yb_textInputIntercepter));
}

@end



//UITextView

@interface UITextView (FJFTextInputIntercepter)

@property (nonatomic, strong) FJFTextInputIntercepter *yb_textInputIntercepter;

@end


@implementation UITextView (FJFTextInputIntercepter)

- (void)setYb_textInputIntercepter:(FJFTextInputIntercepter *)yb_textInputIntercepter {
    
    objc_setAssociatedObject(self, @selector(yb_textInputIntercepter), yb_textInputIntercepter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FJFTextInputIntercepter *)yb_textInputIntercepter {
    
    return objc_getAssociatedObject(self, @selector(yb_textInputIntercepter));
}

@end


@interface FJFTextInputIntercepter()<UITextFieldDelegate, UITextViewDelegate>

@end


//FJFTextInputIntercepter
@implementation FJFTextInputIntercepter

#pragma mark - Life  Circle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _emojiAdmitted = NO;
        _maxCharacterNum = UINT_MAX;
        _doubleBytePerChineseCharacter = NO;
        _intercepterNumberType = FJFTextInputIntercepterNumberTypeNone;
    }
    return self;
}


#pragma mark - Public  Methods

+ (FJFTextInputIntercepter *)textInputView:(UIView <UITextInput>*)textInputView beyoudLimitBlock:(FJFTextInputIntercepterBlock)beyoudLimitBlock {
    FJFTextInputIntercepter *tmpInputIntercepter = [[FJFTextInputIntercepter alloc] init];
    tmpInputIntercepter.beyondLimitBlock = [beyoudLimitBlock copy];
    [self textInputView:textInputView setInputIntercepter:tmpInputIntercepter];
    return tmpInputIntercepter;
    
}

/// 更新  文本
/// @param inputView 输入框
- (void)updateTextWithInputView:(UIView <UITextInput>*)inputView {
    if ([inputView isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)inputView;
        [self updateTextFieldWithTextField:textField];
        
    } else if ([inputView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)inputView;
        [self updateTextViewWithTextView:textView];
    }
}

- (void)textInputView:(UIView <UITextInput>*)textInputView {
    [FJFTextInputIntercepter textInputView:textInputView setInputIntercepter:self];
}

+ (void)textInputView:(UIView <UITextInput>*)textInputView setInputIntercepter:(FJFTextInputIntercepter *)intercepter {
    
    if ([textInputView isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)textInputView;
        textField.delegate = intercepter;
        textField.yb_textInputIntercepter = intercepter;
        [[NSNotificationCenter defaultCenter] addObserver:intercepter
                                                 selector:@selector(textInputDidChangeWithNotification:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textInputView];
        
    } else if ([textInputView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInputView;
        textView.delegate = intercepter;
        textView.yb_textInputIntercepter = intercepter;
        [[NSNotificationCenter defaultCenter] addObserver:intercepter
                                                 selector:@selector(textInputDidChangeWithNotification:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:textInputView];
    }
}

#pragma mark - Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *primaryLanguage = [textField.textInputMode primaryLanguage];
    
    return [self isAllowedInputWithReplaceRange:range replaceText:string previousText:textField.text primaryLanguage:primaryLanguage];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *primaryLanguage = [textView.textInputMode primaryLanguage];
    return [self isAllowedInputWithReplaceRange:range replaceText:text previousText:textView.text primaryLanguage:primaryLanguage];
}

#pragma mark - Noti  Methods
- (void)textInputDidChangeWithNotification:(NSNotification *)noti {
    if (![((UIView *)noti.object) isFirstResponder]) {
        return;
    }

    if ([noti.object isKindOfClass:[UITextField class]] &&
        [noti.name isEqualToString:UITextFieldTextDidChangeNotification]) {
        [self updateTextFieldWithTextField:noti.object];
    }
    else if([noti.object isKindOfClass:[UITextView class]] &&
            [noti.name isEqualToString:UITextViewTextDidChangeNotification]) {
        [self updateTextViewWithTextView:noti.object];
    }
}

#pragma mark - Private Methods

- (void)updateTextFieldWithTextField:(UITextField *)textField {
    if ([self isBeyondLimtWithInputText:textField.text]) {
        textField.text = [self handleInputTextWithInputText:textField.text];
        if (self.beyondLimitBlock) {
            self.beyondLimitBlock(self, textField.text);
        }
    }
    if (self.inputBlock) {
        self.inputBlock(self, textField.text);
    }
}



- (void)updateTextViewWithTextView:(UITextView *)textView {
    if ([self isBeyondLimtWithInputText:textView.text]) {
        textView.text = [self handleInputTextWithInputText:textView.text];
        if (self.beyondLimitBlock) {
            self.beyondLimitBlock(self, textView.text);
        }
    }
    if (self.inputBlock) {
        self.inputBlock(self, textView.text);
    }
}


- (BOOL)isAllowedInputWithReplaceRange:(NSRange)replaceRange
                           replaceText:(NSString *)replaceText
                          previousText:(NSString *)previousText
                       primaryLanguage:(NSString *)primaryLanguage {

    NSString *newString = [previousText stringByReplacingCharactersInRange:replaceRange withString:replaceText];
    // 如果是删除 直接返回true
    if (newString.length < previousText.length) {
        return true;
    }
    
    // 是否 允许 输入
    if ([self isAllowedInputWithReplaceText:replaceText previousText:previousText primaryLanguage:primaryLanguage] == false) {
        return false;
    }
    
    // 是否 超出 限制
    if ([self isBeyondLimtWithInputText:newString]) {
        if (self.beyondLimitBlock) {
            self.beyondLimitBlock(self, previousText);
        }
        return false;
    }
    return true;
}


// 处理字符串
- (NSString *)handleInputTextWithInputText:(NSString *)inputText {
    // 允许 输入 表情 (UTF8编码 英文一个字节 汉字三个字节 表情4-6个字节
    if (self.emojiAdmitted) {
        // 调用 UTF8 编码处理 一个字符一个字节 一个汉字3个字节 一个表情4个字节
        NSUInteger textBytesLength = [inputText lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (textBytesLength > self.maxCharacterNum) {
            NSRange range;
            NSUInteger byteLength = 0;
            NSString *text = inputText;
            for(int i = 0; i < inputText.length && byteLength <= self.maxCharacterNum; i += range.length) {
                range = [inputText rangeOfComposedCharacterSequenceAtIndex:i];
                byteLength += strlen([[text substringWithRange:range] UTF8String]);
                if (byteLength > self.maxCharacterNum) {
                    NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    inputText = newText;
                }
            }
            return inputText;
        }
    }
    // 汉字两个字节(kCFStringEncodingGB_18030_2000)编码
    else if(self.isDoubleBytePerChineseCharacter) {
        // 一个字符一个字节 一个汉字2个字节
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [inputText dataUsingEncoding:encoding];
        NSInteger length = [data length];
        if (length > self.maxCharacterNum) {
            NSData *subdata = [data subdataWithRange:NSMakeRange(0, self.maxCharacterNum)];
            NSString *content = [[NSString alloc] initWithData:subdata encoding:encoding];//注意：当截取CharacterCount长度字符时把中文字符截断返回的content会是nil
            if (!content || content.length == 0) {
                subdata = [data subdataWithRange:NSMakeRange(0, self.maxCharacterNum - 1)];
                content =  [[NSString alloc] initWithData:subdata encoding:encoding];
            }
            return content;
        }
    }
    else {
        // 正常 字符 比较
        if (inputText.length > self.maxCharacterNum) {
            NSRange rangeIndex = [inputText rangeOfComposedCharacterSequenceAtIndex:self.maxCharacterNum];
            if (rangeIndex.length == 1) {
                inputText = [inputText substringToIndex:self.maxCharacterNum];
            } else {
                NSRange rangeRange = [inputText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxCharacterNum)];
                inputText = [inputText substringWithRange:rangeRange];
            }
            return inputText;
        }
    }
    return inputText;
}

// 释放 超出 字符 限制
- (BOOL)isBeyondLimtWithInputText:(NSString *)inputText {
    // 允许 输入 表情 (UTF8编码 英文一个字节 汉字三个字节 表情4-6个字节
    if (self.emojiAdmitted) {
        // 调用 UTF8 编码处理 一个字符一个字节 一个汉字3个字节 一个表情4个字节
        NSUInteger textBytesLength = [inputText lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (textBytesLength > self.maxCharacterNum) {
            return true;
        }
    }
    // 汉字两个字节(kCFStringEncodingGB_18030_2000)编码
    else if(self.isDoubleBytePerChineseCharacter) {
        // 一个字符一个字节 一个汉字2个字节
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [inputText dataUsingEncoding:encoding];
        NSInteger length = [data length];
        if (length > self.maxCharacterNum) {
            return true;
        }
    }
    else {
        // 正常 字符 比较
        if (inputText.length > self.maxCharacterNum) {
            return true;
        }
    }
    return false;
}



// 是否 允许 输入
- (BOOL)isAllowedInputWithReplaceText:(NSString *)replaceText
                         previousText:(NSString *)previousText
                       primaryLanguage:(NSString *)primaryLanguage {
    
    if (!replaceText.length) {
        return true;
    }
    
    // 只允许 输入 数字
    if (self.intercepterNumberType == FJFTextInputIntercepterNumberTypeNumberOnly) {
        return [replaceText fjf_isContainStringType:FJFTextInputStringTypeNumber];
    }
    // 输入 小数
    else if(self.intercepterNumberType == FJFTextInputIntercepterNumberTypeDecimal){
        NSRange tmpRange = NSMakeRange(previousText.length, 0);
        return [self inputText:previousText shouldChangeCharactersInRange:tmpRange replacementString:replaceText];

    }
    // 不允许 输入 表情 并且 不包含表情
    else if (!self.isEmojiAdmitted) {
        return ![self isContainEmojiWithReplacementText:replaceText primaryLanguage:primaryLanguage];
    }
    return true;
}


// 是否 包含 表情
- (BOOL)isContainEmojiWithReplacementText:(NSString *)replaceText
                          primaryLanguage:(NSString *)primaryLanguage {
    if ([replaceText fjf_isContainEmoji]) {
        return YES;
    }
    
    if ([primaryLanguage isEqualToString:@"emoji"] ||
        primaryLanguage.length == 0) {
        return YES;
    }
    return NO;
}


- (BOOL)inputText:(NSString *)inputText shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([inputText rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            if(inputText.length == 0){
                if(single == '.') {
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    //判断小数点的位数
                    NSRange ran = [inputText rangeOfString:@"."];
                    if (range.location - ran.location <= _decimalPlaces) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            return NO;
        }
    }
    return YES;
}


#pragma mark -------------------------- Setter / Getter
- (void)setIntercepterNumberType:(FJFTextInputIntercepterNumberType)intercepterNumberType {
    _intercepterNumberType = intercepterNumberType;
    // 小数
    if (_intercepterNumberType == FJFTextInputIntercepterNumberTypeDecimal && (_decimalPlaces == 0)) {
        _decimalPlaces = 2;
    }
    
    if (_intercepterNumberType != FJFTextInputIntercepterNumberTypeNone) {
        _doubleBytePerChineseCharacter = NO;
    }
}
@end

