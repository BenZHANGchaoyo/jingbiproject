//
//  My_SetTPWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_SetTPWD_ViewController.h"
#import "My_TitleAndInput_View.h"
#import "RegularExpression.h"
@interface My_SetTPWD_ViewController ()

@property (nonatomic, strong) UIView *pwdBackView;
@property (nonatomic, strong) UILabel *pwdLB;
@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIView *surePwdBackView;
@property (nonatomic, strong) UILabel *surePwdLB;
@property (nonatomic, strong) UITextField *surePwdTextField;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UIView *phoneView;

@end

@implementation My_SetTPWD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = SSKJLocalized(@"修改交易密码", nil);

//    if ([[ManagerSocket sharedManager].model.tpwd isEqual:[NSNull null]] || [ManagerSocket sharedManager].model.tpwd.length == 0) {
//        self.title = SSKJLocalized(@"设置资金密码", nil);
//    }
    [self setUI];
}




#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneLabel];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.phoneView.bottom-1, ScreenWidth-ScaleW(15), 1)];
    line.backgroundColor = kLineGrayColor;
    [self.view addSubview:line];
    
    [self.view addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeTextField];
    [self.codeBackView addSubview:self.smsCodeButton];
    
    [self.view addSubview:self.pwdBackView];
    [self.pwdBackView addSubview:self.pwdLB];
    [self.pwdBackView addSubview:self.pwdTextField];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.pwdBackView.bottom-1, ScreenWidth-ScaleW(15), 1)];
    line1.backgroundColor = kLineGrayColor;
    [self.view addSubview:line1];

    [self.view addSubview:self.surePwdBackView];
    [self.surePwdBackView addSubview:self.surePwdLB];
    [self.surePwdBackView addSubview:self.surePwdTextField];
    [self.view addSubview:self.submitButton];

}


-(UIView *)pwdBackView
{
    if (nil == _pwdBackView) {
        _pwdBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.codeBackView.bottom+ ScaleW(10), ScreenWidth, ScaleW(50))];
        _pwdBackView.backgroundColor = kSubBackgroundColor;
    }
    return _pwdBackView;
}

- (UILabel *)pwdLB {
    if (!_pwdLB) {
        _pwdLB = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(80), ScaleW(50))];
        _pwdLB.text = SSKJLocalized(@"交易密码", nil);
        _pwdLB.textColor = [UIColor colorWithHexStringToColor:@"b3b7e9"];
        _pwdLB.font = [UIFont systemFontOfSize:ScaleW(15)];
    }
    return _pwdLB;
}

-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.pwdLB.right+ScaleW(12), 0, ScaleW(200), ScaleW(50))];
        _pwdTextField.textColor = kMainWihteColor;
        _pwdTextField.placeholder = SSKJLocalized(@"请输入8-20位交易密码", nil);
        [_pwdTextField setValue:[UIColor colorWithHexStringToColor:@"5b5e95"] forKeyPath:@"_placeholderLabel.textColor"];
        _pwdTextField.font = systemFont(ScaleW(14));
        _pwdTextField.secureTextEntry = YES;

    }
    return _pwdTextField;
}



-(UIView *)surePwdBackView
{
    if (nil == _surePwdBackView) {
        _surePwdBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.pwdBackView.bottom, ScreenWidth, ScaleW(50))];
        _surePwdBackView.backgroundColor = kSubBackgroundColor;
    }
    return _surePwdBackView;
}

- (UILabel *)surePwdLB {
    if (!_surePwdLB) {
        _surePwdLB = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(80), ScaleW(50))];
        _surePwdLB.text = SSKJLocalized(@"确认密码", nil);
        _surePwdLB.textColor = [UIColor colorWithHexStringToColor:@"b3b7e9"];
        _surePwdLB.font = [UIFont systemFontOfSize:ScaleW(15)];
    }
    return _surePwdLB;
}

-(UITextField *)surePwdTextField
{
    if (nil == _surePwdTextField) {
        _surePwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.surePwdLB.right+ ScaleW(12), 0, ScaleW(200), ScaleW(50))];
        _surePwdTextField.textColor = kMainWihteColor;
        _surePwdTextField.placeholder = SSKJLocalized(@"请输入重复密码", nil);
        [_surePwdTextField setValue:[UIColor colorWithHexStringToColor:@"5b5e95"] forKeyPath:@"_placeholderLabel.textColor"];
        _surePwdTextField.font = systemFont(ScaleW(14));
        _surePwdTextField.secureTextEntry = YES;
    }
    return _surePwdTextField;
}

- (UIView *)phoneView {
    if (!_phoneView) {
        _phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(50))];
        _phoneView.backgroundColor = kSubBackgroundColor;
    }
    return _phoneView;
}

-(UILabel *)phoneLabel
{
    if (nil == _phoneLabel) {
        NSString *string;
        if ([RegularExpression validateMobile:self.phoneNumber]) {
            
            NSString *phoneNumber = [self.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            
            string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"电话号码", nil),phoneNumber];
        }else{
            
            string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"邮箱地址", nil),self.phoneNumber];
        }
        
        _phoneLabel = [WLTools allocLabel:string font:systemFont(ScaleW(15)) textColor:[UIColor colorWithHexStringToColor:@"b3b7e9"] frame:CGRectMake(ScaleW(15), 0 , ScreenWidth - ScaleW(30), self.phoneView.height) textAlignment:NSTextAlignmentLeft];
//        _phoneLabel.backgroundColor = kSubBackgroundColor;
    }
    return _phoneLabel;
}


-(UIView *)codeBackView
{
    if (nil == _codeBackView) {
        _codeBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, ScreenWidth, ScaleW(50))];
        _codeBackView.backgroundColor = kSubBackgroundColor;
    }
    return _codeBackView;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(50))];
        _codeTextField.textColor = kMainWihteColor;
        _codeTextField.placeholder = SSKJLocalized(@"请输入短信验证码", nil);
        [_codeTextField setValue:[UIColor colorWithHexStringToColor:@"5b5e95"] forKeyPath:@"_placeholderLabel.textColor"];
        _codeTextField.font = systemFont(ScaleW(14));
    }
    return _codeTextField;
}


-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        _smsCodeButton.centerY = self.codeTextField.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        _smsCodeButton.layer.masksToBounds = YES;
        _smsCodeButton.layer.cornerRadius = _smsCodeButton.height / 2;
//        _smsCodeButton.backgroundColor = MainTextColor;
//        _smsCodeButton.layer.borderColor = kBGBlueColor.CGColor;
//        _smsCodeButton.layer.borderWidth = 1;
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.surePwdBackView.bottom + ScaleW(50), ScreenWidth - ScaleW(24), ScaleW(45))];
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
//        _submitButton.backgroundColor = kMainWihteColor;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.layer.masksToBounds = YES;
    }
    return _submitButton;
}


#pragma mark - 用户操作
-(void)getSmsCodeEvent
{
    
    if ([RegularExpression validateMobile:self.phoneNumber] ) {
        [self requestSMSCode];
    }else{
        [self requestEmailCode];
    }
   
}

-(void)requestSMSCode
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"mobile"] = _phoneNumber;
//    params[@"type"] = @"4";
//    LSLog(@"params : %@",params);
//    [[ManagerGlobeUntil sharedManager] showHUDWithMsg:ZBLocalized(@"加载中", nil) inView:self.view];
//
//    [HttpTool postWithURL:SendCodeURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        LSLog(@"json : %@",json);
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//        if (status.integerValue == 200) {
//            [MBProgressHUD showError:json[@"msg"]];
//            WS(weakSelf);
//            [weakSelf changeCheckcodeButtonState];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        LSLog(@"error : %@",error);
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//    }];
}

-(void)requestEmailCode
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"email"] = kPhoneNumber;
//    LSLog(@"params : %@",params);
//    //    __weak typeof(self) weakSelf = self;
//    [[ManagerGlobeUntil sharedManager] showHUDWithMsg:ZBLocalized(@"加载中", nil) inView:self.view];
//
//    [HttpTool postWithURL:Getsend_email params:params success:^(id json) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//        NSString *status = json[@"status"];
//        if (status.integerValue == 200) {
//            //            [MBProgressHUD showError:json[@"msg"]];
//            [self changeCheckcodeButtonState];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:ZBLocalized(@"网络出错", nil)];
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//    }];
}

#pragma mark - 用户操作
// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    WS(weakSelf);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
                weakSelf.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                weakSelf.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}





-(void)submitEvent
{
    if (self.pwdTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入资金密码"];
        return;
    }
    
    if (self.surePwdTextField.text.length == 0) {
        [MBProgressHUD showError:@"请确认资金密码"];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdTextField.text]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码提示", nil)];
        return;
    }
    
    if (![self.pwdTextField.text isEqualToString:self.surePwdTextField.text]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致", nil)];
        return;
    }

    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"mobile"] = kPhoneNumber;
//    params[@"tpwd"] = self.pwdTextField.text;
//    params[@"tpwd1"] = self.surePwdTextField.text;
//    params[@"code"] = _codeTextField.text;
//    params[@"account"] = KAccount;
//    LSLog(@"params : %@",params);
//    __weak typeof(self) weakSelf = self;
//    [HttpTool postWithURL:SetPayPwdURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        LSLog(@"json : %@",json);
//        if (status.integerValue == 200) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [kUserDefaults setObject:self.pwdTextField.text forKey:@"payPwd"];
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//            });
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        LSLog(@"error : %@",error);
//        [MBProgressHUD showError:ZBLocalized(@"请求超时", nil)];
//    }];
    
    
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