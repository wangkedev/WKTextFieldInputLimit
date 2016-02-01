//
//  WKTextFieldInputLimit.h
//  注册登录测试demo
//
//  Created by 王克 on 16/2/1.
//  Copyright © 2016年 车益佰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextField (limit)

@end

@interface UITextView (limit)

@end

@interface WKTextFieldInputLimit : NSObject



/*
 使用方法：
 调用setValue: forKey:这个方法
 [self.textField setValue:@4 forKey:@"limit"]就是只能输入四个数字
 
 注意事项：
 forKey 后面的属性 必须是limit
 */



+ (WKTextFieldInputLimit *)sharedTextLimit;

@end