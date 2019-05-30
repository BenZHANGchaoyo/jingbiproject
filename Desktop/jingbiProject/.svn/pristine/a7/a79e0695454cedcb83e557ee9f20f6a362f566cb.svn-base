//
//  HeBi_Extract_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Extract_ViewController.h"

// view
#import "HeBi_TitleAndInput_View.h"

// controller
#import "HeBi_AddressManager_ViewController.h"
#import "HeBi_TiBi_Record_ViewController.h"
// model
#import "HeBi_TiBiInfo_Model.h"
#import "RegularExpression.h"

@interface HeBi_Extract_ViewController ()
@property (nonatomic, strong) HeBi_TitleAndInput_View *usableView;  // 可用
@property (nonatomic, strong) HeBi_TitleAndInput_View *addressView;  // 地址
@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) HeBi_TitleAndInput_View *amountView;  // 数量

@property (nonatomic, strong) UILabel *unitLabel;   // 单位
@property (nonatomic, strong) UIButton *allButton;//全部按钮
@property (nonatomic, strong) UILabel *feeLabel;   // 收付费
@property (nonatomic, strong) UILabel *maxLabel;  // 可提币最大数量
@property (nonatomic, strong) HeBi_TitleAndInput_View *pwdView;  // 资金密码
@property (nonatomic, strong) HeBi_TitleAndInput_View *smsCodeView; // 验证码
@property (nonatomic, strong) UIButton *smsCodebutton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) HeBi_TiBiInfo_Model *tibiInfoModel;

@end

@implementation HeBi_Extract_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = [NSString stringWithFormat:@"%@%@",self.coinModel.pname,SSKJLocalized(@"提币", nil)];
    self.title = SSKJLocalized(@"提币", nil);
    
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"mine_jiaoyijilu"]];
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestCoinInfo];
}

-(void)rigthBtnAction:(id)sender
{
    HeBi_TiBi_Record_ViewController *vc = [[HeBi_TiBi_Record_ViewController alloc]init];
    vc.dealType = DealTypeTibi;
    vc.coinModel = self.coinModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.usableView];
    [self.view addSubview:self.addressView];
    [self.addressView addSubview:self.addressButton];
    [self.view addSubview:self.amountView];
    [self.amountView addSubview:self.unitLabel];
    [self.amountView addSubview:self.allButton];
    [self.view addSubview:self.maxLabel];
    [self.view addSubview:self.feeLabel];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.smsCodeView];
    [self.smsCodeView addSubview:self.smsCodebutton];
    
    [self.view addSubview:self.confirmButton];
}



-(HeBi_TitleAndInput_View *)usableView
{
    if (nil == _usableView) {
        _usableView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0,ScaleW(5), ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"可用", nil) placeHolder:SSKJLocalized(@"", nil) keyBoardType:UIKeyboardTypeDefault isSecured:NO];
        _usableView.textField.enabled = NO;
        _usableView.valueString = [NSString stringWithFormat:@"0.0000%@",self.coinModel.pname];
        _usableView.titleLabel.textColor = [UIColor colorWithHexStringToColor:@"6b6fb9"];
        _usableView.textField.textColor = [UIColor colorWithHexStringToColor:@"a7abdb"];
    }
    return _usableView;
}

-(HeBi_TitleAndInput_View *)addressView
{
    if (nil == _addressView) {
        _addressView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.usableView.bottom, ScreenWidth , ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"提币地址", nil) placeHolder:SSKJLocalized(@"输入或长按粘贴地址", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:NO];
        
    }
    return _addressView;
}

-(UIButton *)addressButton
{
    if (nil == _addressButton) {
        _addressButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addressView.width - ScaleW(47), 0, ScaleW(47), ScaleW(40))];
        _addressButton.centerY = self.addressView.textField.centerY;
        [_addressButton setImage:[UIImage imageNamed:@"tibi-dzlb"] forState:UIControlStateNormal];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScaleW(15))];
        lineView.backgroundColor = kLineGrayColor;
        lineView.centerY = _addressButton.height / 2;
        [_addressButton addSubview:lineView];
        
        [_addressButton addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
    
}


-(HeBi_TitleAndInput_View *)amountView
{
    if (nil == _amountView) {
        _amountView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.addressView.bottom + ScaleW(5), ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"数量", nil) placeHolder:SSKJLocalized(@"最小提币数量200", nil) keyBoardType:UIKeyboardTypeDecimalPad isSecured:NO];
    }
    return _amountView;
}

-(UILabel *)unitLabel
{
    
    if (nil == _unitLabel) {
        _unitLabel = [WLTools allocLabel:self.coinModel.pname font:systemFont(ScaleW(14)) textColor:[UIColor colorWithHexStringToColor:@"878ff5"] frame:CGRectMake(self.amountView.width - ScaleW(56)*2-ScaleW(10), 0, ScaleW(56), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        _unitLabel.centerY = self.amountView.textField.centerY;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScaleW(15))];
        lineView.backgroundColor = kLineGrayColor;
        lineView.centerY = _unitLabel.height / 2;
        [_unitLabel addSubview:lineView];
        _unitLabel.text = @"USDT";
        
    }
    return _unitLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [[UIButton alloc]initWithFrame:CGRectMake(self.amountView.width-ScaleW(56), 0, ScaleW(56), ScaleW(30))];
        [_allButton setTitle:SSKJLocalized(@"全部", nil) forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        _allButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
        _allButton.centerY = self.amountView.textField.centerY;
    }
    return _allButton;
    
}
- (UILabel *)maxLabel
{
    if (nil == _maxLabel) {
        _maxLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.amountView.bottom, ScreenWidth - ScaleW(75), ScaleW(30)) textAlignment:NSTextAlignmentLeft];
//        _maxLabel.backgroundColor = ;
        _maxLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _maxLabel;
}
- (UILabel *)feeLabel{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11.5)) textColor:kMainTextColor frame:CGRectMake(ScreenWidth - ScaleW(75), self.amountView.bottom, ScaleW(70), ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _feeLabel.adjustsFontSizeToFitWidth = YES;
//        _feeLabel.backgroundColor = kSubBackgroundColor;
        
    }
    return _feeLabel;
}

-(HeBi_TitleAndInput_View *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.maxLabel.bottom, ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:SSKJLocalized(@"资金密码", nil) placeHolder:SSKJLocalized(@"请输入资金密码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:YES];
        _pwdView.secureButton.hidden = YES;
    }
    return _pwdView;
}

-(HeBi_TitleAndInput_View *)smsCodeView
{
    if (nil == _smsCodeView) {
        
        NSString *title = SSKJLocalized(@"手机验证码", nil);
        NSString *placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
        
//        if ([kauth_emailIndex integerValue] == 1) {
//            title = SSKJLocalized(@"邮箱验证码", nil);
//            placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
//        }
        
        _smsCodeView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(80)) leftGap:ScaleW(15) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeASCIICapable isSecured:NO];
    }
    return _smsCodeView;
}

-(UIButton *)smsCodebutton
{
    if (nil == _smsCodebutton) {
        _smsCodebutton = [[UIButton alloc]initWithFrame:CGRectMake(self.addressView.width - ScaleW(100), 0, ScaleW(100), ScaleW(40))];
        _smsCodebutton.centerY = self.smsCodeView.textField.centerY;
        [_smsCodebutton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodebutton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        [_smsCodebutton setTitleColor:kLineGrayColor forState:UIControlStateDisabled];
        _smsCodebutton.titleLabel.font = systemFont(ScaleW(13));
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScaleW(15))];
        lineView.backgroundColor = kLineGrayColor;
        lineView.centerY = _smsCodebutton.height / 2;
        [_smsCodebutton addSubview:lineView];
        
        [_smsCodebutton addTarget:self action:@selector(getSmsCode) forControlEvents:UIControlEventTouchUpInside];
    

    }
    return _smsCodebutton;
    
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {

        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.smsCodeView.bottom + ScaleW(31), ScreenWidth - ScaleW(30), ScaleW(45))];
//        _confirmButton.backgroundColor = kMainTextColor;
        [_confirmButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton addGradientColor];
        _confirmButton.layer.cornerRadius = ScaleW(5);
        _confirmButton.layer.masksToBounds = YES;
    }
    return _confirmButton;
}

#pragma mark - 用户操作

// 选择地址
-(void)selectAddress
{
    HeBi_AddressManager_ViewController *vc = [[HeBi_AddressManager_ViewController alloc]init];
    WS(weakSelf);
    vc.addressSelectBlock = ^(HeBi_WalletAddress_Model * _Nonnull addressModel) {
        weakSelf.addressView.valueString = addressModel.qiaobao_url;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

// 获取验证码
-(void)getSmsCode
{

//    if ([RegularExpression validateMobile:kPhoneNumber] ) {
    if ([RegularExpression validateMobile:@""] ) {
        [self requestSmsCode];
    }else{
        [self requestEmailCode];
    }
}


// 确认提取
-(void)confirmEvent
{
    if (self.addressView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币地址", nil)];
        return;
    }
    
    if (self.amountView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币数量", nil)];
        return;
    }
    
    if (self.amountView.valueString.doubleValue < self.tibiInfoModel.tb_min.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%@ USDT",SSKJLocalized(@"最小提币数量", nil),self.tibiInfoModel.tb_min]];
        return;
    }
    
    if (self.amountView.valueString.doubleValue > self.tibiInfoModel.tb_max.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"可提币最大数量%@ USDT",self.tibiInfoModel.tb_max]];
        return;
    }
    
    if (self.amountView.valueString.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"提币数量不能为0", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return;
    }
    
    if (self.smsCodeView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
        return;
    }
    
    [self requestExtract];
}



#pragma mark - 倒计时
// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WS(weakSelf);
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodebutton setTitle:SSKJLocalized(@"重新获取", nil) forState:UIControlStateNormal];
                weakSelf.smsCodebutton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%02ds后重试", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodebutton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                weakSelf.smsCodebutton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 网络请求
#pragma mark 请求币种信息
-(void)requestCoinInfo
{
    NSDictionary *params = @{
                             @"pid":self.coinModel.pid
                             };
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [HttpTool postWithURL:KKindsSXfeeApi params:params success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_NetWork_Model *net_model = [WL_NetWork_Model mj_objectWithKeyValues:json];
//        if ([net_model.status isEqualToString:SUCCESS]) {
//            [weakSelf handleCoinInfoWithModel:net_model];
//        }else{
//            [MBProgressHUD showError:net_model.msg];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:ZBLocalized(@"网络异常", nil)];
//    }];
    
    
}

-(void)handleCoinInfoWithModel:(WL_Network_Model *)net_model
{
    self.tibiInfoModel = [HeBi_TiBiInfo_Model mj_objectWithKeyValues:net_model.data];
    self.usableView.valueString = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.tibiInfoModel.balance.doubleValue afterPointNumber:2],self.coinModel.pname];
    self.amountView.textField.placeholder = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提币数量", nil),self.tibiInfoModel.tb_min];
    self.maxLabel.text = [NSString stringWithFormat:@"%@（%@）：%@",SSKJLocalized(@"可提币最大数量", nil),self.coinModel.pname,self.tibiInfoModel.tb_max];
    self.feeLabel.text = [NSString stringWithFormat:@"%@%@/%@",SSKJLocalized(@"手续费", nil),self.tibiInfoModel.tb_fee,SSKJLocalized(@"次", nil)];
}

#pragma mark 请求验证码

-(void)requestSmsCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    params[@"mobile"] = [ManagerSocket sharedManager].model.mobile;
//
//    params[@"type"] = @"5";
//
//
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [HttpTool postWithURL:SendCodeURL params:params success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_NetWork_Model *net_model = [WL_NetWork_Model mj_objectWithKeyValues:json];
//        if ([net_model.status isEqualToString:SUCCESS]) {
//            [weakSelf changeCheckcodeButtonState];
//        }else{
//            [MBProgressHUD showError:net_model.msg];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:ZBLocalized(@"网络异常", nil)];
//    }];
    
   
}


#pragma mark - 请求邮箱验证码
-(void)requestEmailCode
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"email"] = kPhoneNumber;
//    LSLog(@"params : %@",params);
//    //    __weak typeof(self) weakSelf = self;
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    WS(weakSelf);
//    [HttpTool postWithURL:Getsend_email params:params success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
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
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//    }];
}

#pragma mark 请求提币
-(void)requestExtract
{
//    NSDictionary *params = @{
//                            @"num":self.amountView.valueString,
//                            @"pid":self.coinModel.pid,
//                            @"tpwd":self.pwdView.valueString,
//                            @"code":self.smsCodeView.valueString,
//                            @"account":kPhoneNumber,
//                            @"address":self.addressView.valueString
//                            };
//
//
//
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [HttpTool postWithURL:TiBiURL params:params success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_NetWork_Model *net_model = [WL_NetWork_Model mj_objectWithKeyValues:json];
//        if ([net_model.status isEqualToString:SUCCESS]) {
//            [weakSelf clearView];
//            HeBi_TiBi_Record_ViewController *vc = [[HeBi_TiBi_Record_ViewController alloc]init];
//            vc.dealType = DealTypeTibi;
//            vc.coinModel = weakSelf.coinModel;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }else{
//            [MBProgressHUD showError:net_model.msg];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:ZBLocalized(@"网络异常", nil)];
//    }];
    
    
    
}

-(void)clearView
{
    self.amountView.valueString = @"";
    self.pwdView.valueString = @"";
    self.smsCodeView.valueString = @"";
    self.addressView.valueString = @"";

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
