//
//  JB_Register_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Register_ViewController.h"
#import "JB_VTitleAndInputView.h"

// controller
#import "JB_WebView_Controller.h"

// tools
#import "RegularExpression.h"

@interface JB_Register_ViewController ()
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *helloLabel;
@property (nonatomic, strong) UILabel *wellcomeLabel;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) JB_VTitleAndInputView *accountView;
@property (nonatomic, strong) JB_VTitleAndInputView *smsCodeView;
@property (nonatomic, strong) UIButton *getSMSCodeButton;
@property (nonatomic, strong) JB_VTitleAndInputView *pwdView;
@property (nonatomic, strong) JB_VTitleAndInputView *invicateView;


@property (nonatomic, strong) UIButton *boxButton;
@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UILabel *protocolLabel;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation JB_Register_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.helloLabel];
    [self.view addSubview:self.wellcomeLabel];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.smsCodeView];
    [self.smsCodeView addSubview:self.getSMSCodeButton];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.invicateView];
    [self.view addSubview:self.boxButton];
    [self.view addSubview:self.warningLabel];
    [self.view addSubview:self.protocolLabel];
    
    [self.view addSubview:self.registerButton];
}

-(UIButton *)backButton
{
    if (nil == _backButton) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height_StatusBar, ScaleW(68), ScaleW(48))];
        [_backButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UILabel *)helloLabel
{
    if (nil == _helloLabel) {
        _helloLabel = [WLTools allocLabel:SSKJLocalized(@"新用户注册", nil) font:systemFont(ScaleW(21.5)) textColor:kTextLightWhiteColor frame:CGRectMake(ScaleW(26), Height_StatusBar + ScaleW(75), ScreenWidth - ScaleW(52), ScaleW(22)) textAlignment:NSTextAlignmentLeft];
    }
    return _helloLabel;
}


-(UILabel *)wellcomeLabel
{
    if (nil == _wellcomeLabel) {
        
        NSString *text = SSKJLocalized(@"已有账号，立即", nil);
        
        _wellcomeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(13)) textColor:kTextLightWhiteColor frame:CGRectMake(self.helloLabel.x, self.helloLabel.bottom + ScaleW(10), self.helloLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        
        CGFloat width = [WLTools getWidthWithText:text font:_wellcomeLabel.font];
        _wellcomeLabel.width = width;
    }
    return _wellcomeLabel;
}

-(UIButton *)loginButton
{
    if (nil == _loginButton) {
        NSString *text = SSKJLocalized(@"登录>", nil);
        CGFloat width = [WLTools getWidthWithText:text font:systemFont(ScaleW(13))];
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(self.wellcomeLabel.right, 0, width, ScaleW(40))];
        _loginButton.centerY = self.wellcomeLabel.centerY;
        [_loginButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_loginButton setTitle:text forState:UIControlStateNormal];
        _loginButton.titleLabel.font = systemFont(ScaleW(13));
        [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginButton;
}



- (JB_VTitleAndInputView *)accountView
{
    if (nil == _accountView) {
        _accountView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.wellcomeLabel.bottom + ScaleW(20), ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"账号", nil) placeHolder:SSKJLocalized(@"请输入您的手机号或邮箱", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:NO];
    }
    return _accountView;
}

- (JB_VTitleAndInputView *)smsCodeView
{
    if (nil == _smsCodeView) {
        _smsCodeView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.accountView.bottom, ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"验证码", nil) placeHolder:SSKJLocalized(@"请输入验证码", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:NO];
    }
    return _smsCodeView;
}


-(UIButton *)getSMSCodeButton
{
    if (nil == _getSMSCodeButton) {
        _getSMSCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(26) - ScaleW(97), 0, ScaleW(97), ScaleW(35))];
        _getSMSCodeButton.centerY = self.smsCodeView.textField.centerY;
        [_getSMSCodeButton setBackgroundImage:[UIImage imageNamed:@"sms_border_img"] forState:UIControlStateNormal];
        [_getSMSCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_getSMSCodeButton setTitleColor:kTextLightWhiteColor forState:UIControlStateNormal];
        _getSMSCodeButton.titleLabel.font = systemFont(ScaleW(13.5));
        [_getSMSCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSMSCodeButton;
}

-(JB_VTitleAndInputView *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.smsCodeView.bottom, ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"登录密码", nil) placeHolder:SSKJLocalized(@"请输入8-20位字谜和数字组合", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:YES];
    }
    return _pwdView;
}
-(JB_VTitleAndInputView *)invicateView
{
    if (nil == _invicateView) {
        _invicateView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"邀请码", nil) placeHolder:SSKJLocalized(@"请输入邀请码", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:NO];
    }
    return _invicateView;
}


-(UIButton *)registerButton
{
    if (nil == _registerButton) {
        _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.boxButton.bottom + ScaleW(50), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_registerButton setTitle:SSKJLocalized(@"立即登录", nil) forState:UIControlStateNormal];
        [_registerButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 4.0f;
        _registerButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_registerButton addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton addGradientColor];
    }
    return _registerButton;
}

-(UIButton *)boxButton
{
    if (nil == _boxButton) {
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(22), self.invicateView.bottom, ScaleW(30), ScaleW(70))];
        [_boxButton setImage:[UIImage imageNamed:@"box_normal"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"box_selected"] forState:UIControlStateSelected];
        [_boxButton addTarget:self action:@selector(boxEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _boxButton;
}

-(UILabel *)warningLabel
{
    if (nil == _warningLabel) {
        
        NSString *title = SSKJLocalized(@"点击注册即表示同意", nil);
        
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(13))];
        _warningLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.boxButton.right, 0, width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _warningLabel.adjustsFontSizeToFitWidth = YES;
        _warningLabel.centerY = self.boxButton.centerY;
    }
    return _warningLabel;
}

-(UILabel *)protocolLabel
{
    
    if (nil == _protocolLabel) {
        NSString *title = SSKJLocalized(@"《用户服务协议》", nil);
        
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(13))];
        
        _protocolLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(self.warningLabel.right, 0, width, ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        _protocolLabel.centerY = self.boxButton.centerY;
        _protocolLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protocolEvent)];
        [_protocolLabel addGestureRecognizer:tap];
    }
    return _protocolLabel;
}


#pragma mark - 用户操作
-(void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerEvent
{
    if (![RegularExpression validateMobile:self.accountView.valueString] && ![RegularExpression validateEmail:self.accountView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
        return;
    }
    
    if (self.smsCodeView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
        return;
    }
    
    if (self.invicateView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邀请码", nil)];
        return;
    }
    
    if (!self.boxButton.selected) {
        [MBProgressHUD showError:SSKJLocalized(@"请阅读并同意用户服务协议", nil)];
        return;
    }
    
    [self requestRegister];

}

-(void)loginEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)forgetEvent
{
    
}

-(void)boxEvent
{
    self.boxButton.selected = !self.boxButton.selected;
}


-(void)protocolEvent
{
    JB_WebView_Controller *webVc = [[JB_WebView_Controller alloc]init];
    webVc.protocolType = PROTOCOLTYPEREGISTER;
    webVc.title = SSKJLocalized(@"用户服务协议",nil);
    [self.navigationController pushViewController:webVc animated:YES];
}


#pragma mark - 网络请求

-(void)getCode
{
    if ([RegularExpression validateMobile:self.accountView.valueString]) {
        [self requestSmsCode];
    }else if([RegularExpression validateEmail:self.accountView.valueString]){
        [self requestEmailCode];
    }else{
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
    }
}


// 倒计时
-(void)countDown
{
    self.getSMSCodeButton.enabled = NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WS(weakSelf);
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [weakSelf.getSMSCodeButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                
                weakSelf.getSMSCodeButton.enabled = YES;
                
            });
            
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf.getSMSCodeButton setTitle:[NSString stringWithFormat:@"%@s%@",strTime,SSKJLocalized(@"重新获取", nil)] forState:UIControlStateDisabled];
                
                //标记第一次点击的时候，当在此启用倒计时的时候 可点击
                
                // sender.userInteractionEnabled =!_isGetPawd;
                
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark - 请求手机验证码

-(void)requestSmsCode
{
    
    NSDictionary *params = @{
                             @"mobile":self.accountView.valueString,
                             @"type":@"1"
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_GetSMSCode_URL RequestType:RequestTypeGet Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf countDown];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 请求邮箱验证码
-(void)requestEmailCode
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_GetEmailCode_URL RequestType:RequestTypePost Parameters:@{@"email":self.accountView.valueString} Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf countDown];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

#pragma mark - 注册

-(void)requestRegister
{
    NSDictionary *params = @{
                             @"mobile":self.accountView.valueString,
                             @"code":self.smsCodeView.valueString,
                             @"opwd":self.pwdView.valueString,
                             @"opwd1":self.pwdView.valueString,
                             @"tjuser":self.invicateView.valueString
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_Register_URL RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [MBProgressHUD showSuccess:SSKJLocalized(@"注册成功", nil)];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}



@end
