//
//  JB_ForgetPWD_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_ForgetPWD_ViewController.h"

// view
#import "JB_VTitleAndInputView.h"

// tools
#import "RegularExpression.h"
@interface JB_ForgetPWD_ViewController ()
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *helloLabel;
//@property (nonatomic, strong) UILabel *wellcomeLabel;
//@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) JB_VTitleAndInputView *accountView;
@property (nonatomic, strong) JB_VTitleAndInputView *smsCodeView;
@property (nonatomic, strong) UIButton *getSMSCodeButton;

@property (nonatomic, strong) JB_VTitleAndInputView *pwdView;
@property (nonatomic, strong) JB_VTitleAndInputView *surePWDView;


@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation JB_ForgetPWD_ViewController


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
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.smsCodeView];
    [self.smsCodeView addSubview:self.getSMSCodeButton];

    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.surePWDView];
    
    [self.view addSubview:self.submitButton];
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
        _helloLabel = [WLTools allocLabel:SSKJLocalized(@"忘记密码", nil) font:systemFont(ScaleW(21.5)) textColor:kTextLightWhiteColor frame:CGRectMake(ScaleW(26), Height_StatusBar + ScaleW(75), ScreenWidth - ScaleW(52), ScaleW(22)) textAlignment:NSTextAlignmentLeft];
    }
    return _helloLabel;
}

- (JB_VTitleAndInputView *)accountView
{
    if (nil == _accountView) {
        _accountView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.helloLabel.bottom + ScaleW(20), ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"账号", nil) placeHolder:SSKJLocalized(@"请输入您的手机号或邮箱", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:NO];
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
        _pwdView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.smsCodeView.bottom, ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"登录密码", nil) placeHolder:SSKJLocalized(@"请输入8-20位字母和数字组合", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:YES];
    }
    return _pwdView;
}
-(JB_VTitleAndInputView *)surePWDView
{
    if (nil == _surePWDView) {
        _surePWDView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"确认密码", nil) placeHolder:SSKJLocalized(@"青菜自输入新登录密码", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:YES];
    }
    return _surePWDView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.surePWDView.bottom + ScaleW(50), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 4.0f;
        _submitButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
    }
    return _submitButton;
}

#pragma mark - 用户操作
-(void)backEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitEvent
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
    
    if (self.surePWDView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入新登录密码", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
        return;
    }
    
    [self requestForget];
    
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_GetSMSCode_URL RequestType:RequestTypePost Parameters:@{@"mobile":self.accountView.valueString,@"type":@"2"} Success:^(id responseObject) {
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


#pragma mark - 请求邮箱验证码
-(void)requestForget
{
    
    NSDictionary *params = @{
                             @"mobile":self.accountView.valueString,
                             @"code":self.smsCodeView.valueString,
                             @"opwd":self.pwdView.valueString,
                             @"opwd1":self.surePWDView.valueString
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:ETF_ForgetPWD_URL RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
