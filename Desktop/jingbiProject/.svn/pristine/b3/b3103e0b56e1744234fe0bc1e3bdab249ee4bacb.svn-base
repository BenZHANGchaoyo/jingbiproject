//
//  HeBi_Default_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Default_AlertView.h"

@interface HeBi_Default_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmBlock)(void);

@end

@implementation HeBi_Default_AlertView


-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
        [self.showView addSubview:self.lineView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.cancleButton.bottom + ScaleW(20);
        self.showView.centerY = ScreenHeight / 2;
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
        
    }
    return _backView;
}

-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), 0, self.width - ScaleW(24), ScaleW(190))];
        _showView.backgroundColor = UIColorFromRGB(0x0f121c);
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 6.0f;
        _showView.userInteractionEnabled = YES;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"退出登录" font:systemFont(ScaleW(16)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), ScaleW(30), self.showView.width - ScaleW(30), ScaleW(16)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(30), self.showView.width - ScaleW(30), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), 0, self.showView.width - ScaleW(24), 0.5)];
        _lineView.backgroundColor = UIColorFromRGB(0x191d28);
    }
    return _lineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.messageLabel.bottom + ScaleW(14), self.showView.width / 2, ScaleW(35))];
        _cancleButton.layer.masksToBounds = YES;
//        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
//        _cancleButton.layer.borderColor = MainTextColor.CGColor;
//        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(15));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.width / 2, self.cancleButton.y, self.showView.width / 2, ScaleW(35))];
//        _confirmButton.backgroundColor = MainTextColor;
//        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

+(void)showWithTitle:(NSString *)title message:(NSString *)message cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle confirmBlock:(nonnull void (^)(void))confirmblock
{
    
    
    HeBi_Default_AlertView *alertView = [[HeBi_Default_AlertView alloc]init];
    
    
    alertView.confirmBlock = confirmblock;
    alertView.titleLabel.text = title;
    alertView.messageLabel.text = message;
    [alertView.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
    [alertView.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    CGFloat height = [message boundingRectWithSize:CGSizeMake(alertView.messageLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:alertView.messageLabel.font} context:nil].size.height;
    alertView.messageLabel.height = height;
    if (message.length == 0) {
        alertView.lineView.y = alertView.titleLabel.bottom + ScaleW(26);
    }else{
        alertView.lineView.y = alertView.messageLabel.bottom + ScaleW(26);
    }
    
//    alertView.lineView.y = alertView.messageLabel.bottom + ScaleW(26);
    
    alertView.cancleButton.y = alertView.lineView.y;
    
    alertView.confirmButton.y = alertView.cancleButton.y;

    alertView.showView.height = alertView.confirmButton.bottom + ScaleW(20);
    alertView.showView.centerY = ScreenHeight / 2;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
}

-(void)hide
{
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    [self hide];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
