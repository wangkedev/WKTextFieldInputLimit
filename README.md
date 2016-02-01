# WKTextFieldInputLimit
一行代码限制文本框输入长度

UITextField和UITextView，使输入框只输入电话号码，而且只能输入11位，要限制字数。
使用方法：
调用setValue: forKey:这个方法

[self.textField setValue:@11 forKey:@"limit"]

注意事项：
forKey 后面的属性 必须是limit


另外，限制只能输入数字方法用代理实现
