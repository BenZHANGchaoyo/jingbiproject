//
//  JB_Login_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Login_ViewController.h"

// view
#import "JB_VTitleAndInputView.h"

// controller
#import "JB_Register_ViewController.h"
#import "JB_ForgetPWD_ViewController.h"

// tools
#import "RegularExpression.h"

@interface JB_Login_ViewController ()
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *helloLabel;
@property (nonatomic, strong) UILabel *wellcomeLabel;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) JB_VTitleAndInputView *accountView;
@property (nonatomic, strong) JB_VTitleAndInputView *pwdView;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *forgetButton;

@end

@implementation JB_Login_ViewController

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
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.pwdView];
    
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetButton];
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
        _helloLabel = [WLTools allocLabel:SSKJLocalized(@"您好！", nil) font:systemFont(ScaleW(21.5)) textColor:kTextLightWhiteColor frame:CGRectMake(ScaleW(26), Height_StatusBar + ScaleW(75), ScreenWidth - ScaleW(52), ScaleW(22)) textAlignment:NSTextAlignmentLeft];
    }
    return _helloLabel;
}


-(UILabel *)wellcomeLabel
{
    if (nil == _wellcomeLabel) {
        
        NSString *text = SSKJLocalized(@"欢迎来到鲸币，", nil);
        
        _wellcomeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(13)) textColor:kTextLightWhiteColor frame:CGRectMake(self.helloLabel.x, self.helloLabel.bottom + ScaleW(10), self.helloLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        
        CGFloat width = [WLTools getWidthWithText:text font:_wellcomeLabel.font];
        _wellcomeLabel.width = width;
    }
    return _wellcomeLabel;
}

-(UIButton *)registerButton
{
    if (nil == _registerButton) {
        NSString *text = SSKJLocalized(@"立即注册>", nil);
        CGFloat width = [WLTools getWidthWithText:text font:systemFont(ScaleW(13))];
        _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(self.wellcomeLabel.right, 0, width, ScaleW(40))];
        _registerButton.centerY = self.wellcomeLabel.centerY;
        [_registerButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_registerButton setTitle:text forState:UIControlStateNormal];
        _registerButton.titleLabel.font = systemFont(ScaleW(13));
        [_registerButton addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerButton;
}

- (JB_VTitleAndInputView *)accountView
{
    if (nil == _accountView) {
        _accountView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.wellcomeLabel.bottom + ScaleW(20), ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"账号", nil) placeHolder:SSKJLocalized(@"请输入您的手机号或邮箱", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:NO];
    }
    return _accountView;
}


-(JB_VTitleAndInputView *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.accountView.bottom, ScreenWidth, ScaleW(79)) leftGap:ScaleW(25) title:SSKJLocalized(@"登录密码", nil) placeHolder:SSKJLocalized(@"请输入8-20位字谜和数字组合", nil) font:systemFont(ScaleW(14.5)) keyBoardType:UIKeyboardTypeDefault isShowSecured:YES];
    }
    return _pwdView;
}


-(UIButton *)loginButton
{
    if (nil == _loginButton) {
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.pwdView.bottom + ScaleW(50), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_loginButton setTitle:SSKJLocalized(@"立即登录", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 4.0f;
        _loginButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton addGradientColor];
    }
    return _loginButton;
}

-(UIButton *)forgetButton
{
    if (nil == _forgetButton) {
        _forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.loginButton.bottom + ScaleW(10), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_forgetButton setTitle:SSKJLocalized(@"忘记密码", nil) forState:UIControlStateNormal];
        [_forgetButton setTitleColor:kTextDarkBlueColor forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_forgetButton addTarget:self action:@selector(forgetEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

-(void)backEvent
{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoMainView" object:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

-(void)registerEvent
{
    JB_Register_ViewController *vc = [[JB_Register_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginEvent
{
    if (![RegularExpression validateMobile:self.accountView.valueString] && ![RegularExpression validateEmail:self.accountView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
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
    
    
    [self requestLogin];
}


-(void)forgetEvent
{
    JB_ForgetPWD_ViewController *vc = [[JB_ForgetPWD_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 注册

-(void)requestLogin
{
    NSDictionary *params = @{
                             @"mobile":self.accountView.valueString,
                             @"opwd":self.pwdView.valueString,
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL:JB_Login_URL RequestType:RequestTypePost Parameters:params Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            SSKJ_Login_Model *loginModel = [SSKJ_Login_Model mj_objectWithKeyValues:network_model.data];
            
            [[SSKJ_User_Tool sharedUserTool]saveLoginInfoWithLoginModel:loginModel];
            
            [[NSUserDefaults standardUserDefaults]setObject:weakSelf.accountView.valueString forKey:@"kPhoneNumber"];
            
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            
            
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
