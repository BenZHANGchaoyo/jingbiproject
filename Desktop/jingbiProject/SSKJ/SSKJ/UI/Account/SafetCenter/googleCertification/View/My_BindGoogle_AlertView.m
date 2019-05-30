//
//  My_BindGoogle_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_BindGoogle_AlertView.h"
#import "RegularExpression.h"
@interface My_BindGoogle_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *googleView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submiteButton;
@end
@implementation My_BindGoogle_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        [self setUI];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    
    self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
    
    [self.alertView addSubview:self.googleView];
    
    NSString *title = SSKJLocalized(@"验证手机", nil);
    NSString *placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
//    if ([kauth_emailIndex integerValue] == 1) {
//        title = SSKJLocalized(@"验证邮箱", nil);
//        placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
//    }
    
    self.phoneView = [self addInputViewWithFrame:CGRectMake(0, self.googleView.bottom , ScreenWidth, ScaleW(88)) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeEmailAddress];
    
    [self.alertView addSubview:self.phoneView];
    [self.alertView addSubview:self.submiteButton];
    
    self.alertView.height = self.submiteButton.bottom + ScaleW(27);
    
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, ScreenWidth, 0)];
        _alertView.backgroundColor = kSubBackgroundColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_alertView addGestureRecognizer:tap];
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemBoldFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(24), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)addInputViewWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kSubBackgroundColor;
    UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14), ScaleW(200), ScaleW(40))];
    textField.textColor = kMainWihteColor;
    textField.font = systemFont(ScaleW(15));
    textField.placeholder = placeHolder;
    textField.keyboardType = keyBoardType;
    [textField setValue:kTextLightBlueColor forKeyPath:@"_placeholderLabel.textColor"];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), textField.bottom, ScreenWidth, 1)];
    line.backgroundColor = kLineGrayColor;
    [view addSubview:line];
    
    [view addSubview:textField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(textField.x, textField.bottom, view.width - ScaleW(24), 1)];
    [view addSubview:lineView];
    
    if ([title isEqualToString:SSKJLocalized(@"谷歌验证码", nil)]) {
        self.codeTextField = textField;
        textField.width = ScreenWidth - ScaleW(24);
    }else{
        self.iphoneTextField = textField;
        self.smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        self.smsCodeButton.centerY = textField.centerY;
        [self.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [self.smsCodeButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        self.smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        self.smsCodeButton.layer.masksToBounds = YES;
        self.smsCodeButton.layer.cornerRadius = self.smsCodeButton.height / 2;
        self.smsCodeButton.layer.borderColor = kTextLightBlueColor.CGColor;
        self.smsCodeButton.layer.borderWidth = 1;
        [self.smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.smsCodeButton];
    }
    
    
    return view;

}

-(UIButton *)submiteButton
{
    if (nil == _submiteButton) {
        _submiteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.phoneView.bottom + ScaleW(38), ScreenWidth - ScaleW(50), ScaleW(45))];
        _submiteButton.layer.cornerRadius = _submiteButton.height / 2;
        _submiteButton.backgroundColor = kMainTextColor;
        [_submiteButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submiteButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submiteButton.titleLabel.font = systemFont(ScaleW(16));
        [_submiteButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submiteButton addGradientColor];
        _submiteButton.layer.masksToBounds = YES;
        _submiteButton.layer.cornerRadius = ScaleW(5);
    }
    return _submiteButton;
}




-(void)showWithType:(GOOGLETYPE)googleType
{
    NSString *string = SSKJLocalized(@"绑定谷歌验证", nil);
    if (googleType == GOOGLETYPEDELETE) {
        string = SSKJLocalized(@"解绑谷歌验证", nil);
    }
    self.titleLabel.text = string;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height -weakSelf.alertView.height;
    }];
}

-(void)hide
{
    
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

#pragma mark - 用户操作
-(void)getSmsCodeEvent
{
    
    if ([RegularExpression validateMobile:@"111"] ) {
        [self requestSmsCode];
    }else{
        [self requestEmailCode];
    }
}




-(void)submitEvent
{
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
//
    if (self.iphoneTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
        return;
    }
    
    if (self.submitBlock) {
        self.submitBlock(self.codeTextField.text, self.iphoneTextField.text);
    }
    [self hide];
}

#pragma mark - 请求验证码

-(void)requestSmsCode
{
//    [MBProgressHUD showHUDAddedTo:self animated:YES];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"mobile"] = kPhoneNumber;
//    params[@"type"] = @"7";
//    LSLog(@"params : %@",params);
//    __weak typeof(self) weakSelf = self;
//    [HttpTool postWithURL:SendCodeURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
//        if (status.integerValue == 200) {
//            [MBProgressHUD showError:ZBLocalized(@"发送成功", nil)];
//            [weakSelf changeCheckcodeButtonState];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
//        [MBProgressHUD showError:ZBLocalized(@"网络出错", nil)];
//    }];
}

-(void)requestEmailCode
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"email"] = kPhoneNumber;
//    LSLog(@"params : %@",params);
//    //    __weak typeof(self) weakSelf = self;
//    [MBProgressHUD showHUDAddedTo:self animated:YES];
//
//    WS(weakSelf);
//    [HttpTool postWithURL:Getsend_email params:params success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
//
//        NSString *status = json[@"status"];
//        if (status.integerValue == 200) {
//            //            [MBProgressHUD showError:json[@"msg"]];
//            [self changeCheckcodeButtonState];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:ZBLocalized(@"网络出错", nil)];
//        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
//    }];
}

// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                self.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%@秒后重新发送", nil), seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
