//
//  WKTextFieldInputLimit.m
//  注册登录测试demo
//
//  Created by 王克 on 16/2/1.
//  Copyright © 2016年 车益佰. All rights reserved.
//

#import "WKTextFieldInputLimit.h"
#import <objc/runtime.h>

@implementation UITextField (limit)

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
}

@end

@implementation UITextView (limit)

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"limit"]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
}

@end

@implementation WKTextFieldInputLimit

+ (void)load
{
    [super load];
    [WKTextFieldInputLimit sharedTextLimit];
}

+ (WKTextFieldInputLimit *)sharedTextLimit
{
    static WKTextFieldInputLimit *textLimit;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textLimit = [[WKTextFieldInputLimit alloc] init];
    });
    return textLimit;
}

- (id)init
{
    if (self = [super init]) {
        // 通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textViewDidChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object: nil];
    }
    return self;
}
#pragma mark - 通知事件
- (void)textFieldDidChange:(NSNotification*)notification
{
    UITextField *textField = (UITextField *)notification.object;
    
    NSNumber *number = [textField valueForKey:@"limit"];
    if (number && textField.text.length > [number integerValue] && textField.markedTextRange == nil) {
        textField.text = [textField.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
}


- (void)textViewDidChange: (NSNotification *) notificaiton
{
    UITextView *textView = (UITextView *)notificaiton.object;
    
    NSNumber *number = [textView valueForKey:@"limit"];
    if (number && textView.text.length > [number integerValue] && textView.markedTextRange == nil) {
        textView.text = [textView.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
}



#pragma mark - UITextField Delegate
//代理实现 只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
    
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    
    return res;
}


@end
