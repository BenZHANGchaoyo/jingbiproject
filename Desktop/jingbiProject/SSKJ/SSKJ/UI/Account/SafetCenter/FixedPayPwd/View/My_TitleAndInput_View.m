//
//  My_TitleAndInput_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_TitleAndInput_View.h"

@interface My_TitleAndInput_View ()
{
    NSString *_title;
    NSString *_placeHolder;
    UIKeyboardType _keyBoardType;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation My_TitleAndInput_View

@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kSubBackgroundColor;
        _title = title;
        _placeHolder = placeHolder;
        _keyBoardType = keyBoardType;
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
    }
    return self;
}


-(UILabel *)titleLabel
{
    
    if (nil == _titleLabel) {
        _titleLabel =[WLTools allocLabel:_title font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"b3b7e9"] frame:CGRectMake(ScaleW(12), ScaleW(20) + self.height - ScaleW(88), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + ScaleW(14), self.width - self.titleLabel.x - ScaleW(50), ScaleW(40))];
        _textField.textColor = kMainWihteColor;
        _textField.font = systemFont(ScaleW(15));
        _textField.placeholder = _placeHolder;
        _textField.keyboardType = _keyBoardType;
        [_textField setValue:UIColorFromRGB(0x5b5e95) forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _textField;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.textField.x, self.height - 1, self.width - ScaleW(24), 1)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

-(NSString *)valueString
{
    return self.textField.text;
}

-(void)setValueString:(NSString *)valueString
{
    self.textField.text = valueString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
