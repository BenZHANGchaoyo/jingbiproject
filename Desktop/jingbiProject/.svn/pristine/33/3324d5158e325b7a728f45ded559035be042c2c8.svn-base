//
//  BLSafeCenterViewController.m
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import "BLSafeCenterViewController.h"
#import "BFEXReChartWayTableViewCell.h"
#import "My_BindPhone_ViewController.h"
#import "My_ChangePWD_ViewController.h"
#import "My_SetTPWD_ViewController.h"
#import "HeBi_Mine_Certificate_ViewController.h"
#import "My_GoogleVerify_ViewController.h"
#import "My_BindGoogle_AlertView.h"
#import "BFEXSafeSelectViewController.h"
#import "BFEXShowChartView.h"
//#import "BLLabel.h"
#import "BLUserModel.h"
//#import "BLCellModel.h"
#import "BLSafeCenterCell.h"
//
//
//#import "ManagerSocket.h"
//
//
//#import "BFEX_FBC_Apply_Bussiness_ViewController.h"



@interface BLSafeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellTitleArr;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIView *footerView;
//@property(nonatomic,strong)BFEX_FBC_UnVerBuss_View *unVerBussView;
@property (nonatomic, strong) My_BindGoogle_AlertView *googleAlertView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) BFEXShowChartView *showView;

@end

@implementation BLSafeCenterViewController

- (NSMutableArray *)cellTitleArr {
    if (!_cellTitleArr) {
        _cellTitleArr = [NSMutableArray array];
        [_cellTitleArr insertObject:@[SSKJLocalized(@"手机", nil),
                                      SSKJLocalized(@"邮箱", nil),
                                      SSKJLocalized(@"登录密码", nil),
                                      SSKJLocalized(@"交易密码", nil),
                                      SSKJLocalized(@"身份认证", nil),
                                      SSKJLocalized(@"商家认证", nil),
                                      SSKJLocalized(@"谷歌认证", nil)] atIndex:0];
        
        
        [_cellTitleArr insertObject:@[] atIndex:1];
        
        [_cellTitleArr insertObject:@[] atIndex:2];
        
    }
    return _cellTitleArr;
}

-(void)reloadBankList
{
//    self.hud  = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//    [HttpTool getWithURL:KpayWaysApi params:@{@"account":KAccount} success:^(id json)
//    {
//        NSArray *arr = json[@"data"];
//        if (arr.count) {
//            [_cellTitleArr replaceObjectAtIndex:2 withObject:arr];
//            [self.tableView reloadData];
//        }
//        [self.hud  hideAnimated:YES];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    } failure:^(NSError *error) {
//        [self.hud  hideAnimated:YES];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"安全中心", nil);
    [self setupUI];
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BLSafeCenterCell class]) bundle:nil] forCellReuseIdentifier:@"safeCell"];
    
    //[kNotifyCenter addObserver:self selector:@selector(showViewAlert) name:@"showAlertView" object:nil];
//    [kNotifyCenter addObserver:self selector:@selector(reloadBankList) name:@"reloadBankListAction" object:nil];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.unVerBussView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self loadUserData:kPhoneNumber];
    [self reloadBankList];
}


-(My_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _googleAlertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestDeleteGoogleWithCode:smsCode googleCode:googleCode];
        };
    }
    return _googleAlertView;

}

/**
 加载用户数据
 */
- (void)loadUserData:(NSString *)phoneNumber {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"mobile"] = kPhoneNumber;
//    LSLog(@"parmas : %@",params);
//    __weak typeof(self) weakSelf = self;
//    [HttpTool postWithURL:UserInfoURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        LSLog(@"json : %@",json);
//        if (status.integerValue == 200) {
//            weakSelf.userModel = [BLUserModel userModelWithDictionary:json[@"data"]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [ManagerSocket sharedManager].model = weakSelf.userModel;
//                [kUserDefaults setObject:_userModel.mail forKey:@"mail"];
//                [kUserDefaults setObject:_userModel.tpwd forKey:@"payPwd"];
//                [kUserDefaults setObject:_userModel.userid forKey:@"userid"];
////                [weakSelf.userModel.status isEqualToString:@"3"] ? [kUserDefaults setObject:@"1" forKey:@"IDCheck"] : [kUserDefaults setObject:@"0" forKey:@"IDCheck"];
//                [kUserDefaults setObject:_userModel.status forKey:@"IDCheck"];
//                [kUserDefaults synchronize];
//                [self.tableView reloadData];
//            });
//           
//        } else {
//            //[MBProgressHUD showError:json[@"msg"]];
//        }
//      
//    } failure:^(NSError *error) {
//        LSLog(@"error : %@",error);
//        
//    }];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar);
    tableView.delegate = self;
    tableView.separatorColor = kLineGrayColor;
    tableView.backgroundColor  = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.bounces = YES;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.tableFooterView = self.footerView;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    headerView.backgroundColor = kMainBackgroundColor;
    _tableView.tableHeaderView = headerView;
//    WS(weakSelf);
//    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
////        [weakSelf reloadBankList];
//    }];

}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.cellTitleArr[section];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellTitleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        BLSafeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeCell"];
        NSArray *array = self.cellTitleArr[indexPath.section];
        cell.cellTitle.text = array[indexPath.row];
        
        NSString *status = [self statusWithModel:_userModel indexPath:indexPath];
        
        cell.status.text = status;
        
        if ([status containsString:SSKJLocalized(@"已开启", nil)] || [status containsString:SSKJLocalized(@"一级已认证", nil)] || [status isEqualToString:SSKJLocalized(@"修改", nil)]|| [status containsString:SSKJLocalized(@"二级已认证", nil)]) {
            cell.status.textColor = kTextLightBlueColor;
        }else{
            cell.status.textColor = kTextLightBlueColor;
        }
        
        return cell;
    }
    
    
    
    
//    if (indexPath.section == 0) {
//        BLSafeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeCell"];
//         NSArray *array = self.cellTitleArr[indexPath.section];
//        cell.cellTitle.text = array[indexPath.row];
//
//        cell.status.text = [self statusWithModel:_userModel indexPath:indexPath];
//        return cell;
//    }
    if(indexPath.section == 2){
        //BFEXReChartWayTableViewCell *cell = [BFEXReChartWayTableViewCell getCellFromTable:tableView indexPath:indexPath];
        BFEXReChartWayTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),indexPath.row]];
            if (!cell)
            {
                cell = [[BFEXReChartWayTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                WS(weakSelf);
                cell.edtingBlock = ^(NSDictionary *dic) {//修改点击方法
//                    NSString *str = kIDCheck; // 1未认证，2待审核，3已认证 4拒绝
                    NSString *str = @"1"; // 1未认证，2待审核，3已认证 4拒绝

                    switch (str.integerValue) {
                        case 1:
                        {
                            [MBProgressHUD showError:SSKJLocalized(@"初级未认证", nil)];
                            return;
                        }
                            break;
                        case 2:
                        {
                            [MBProgressHUD showError:SSKJLocalized(@"您的实名认证正在审核，请耐心等待", nil)];
                            return;
                        }
                            break;
                        case 3:
                        {
//                            NSString *pwd =  kPayPwd;// 0 未设置资金密码，1 已设置资金密码
                            NSString *pwd =  @"0";// 0 未设置资金密码，1 已设置资金密码
                            if (pwd.integerValue)
                            {
                                
                            }else{
                                [MBProgressHUD showError:SSKJLocalized(@"请设置资金密码", nil)];
                                return;
                            }
                        }
                            break;
                        case 4:
                        {
                            [MBProgressHUD showError:SSKJLocalized(@"已拒绝", nil)];
                            return;
                        }
                            break;
                            
                        default:
                            break;
                    }
                    if (str.integerValue != 3) {
//                        [self judgeFristCertificate];
                        return ;

                    }
                    [weakSelf showViewAlert:dic];
                };
            }
        NSArray *array = self.cellTitleArr[indexPath.section];
        [cell setValueData:array[indexPath.row]];
        return cell;
    }
    return nil;
}

// 设置不同状态
- (NSString *)statusWithModel:(BLUserModel *)model indexPath:(NSIndexPath *)indexPath {
    NSString *status;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            status = (model.mobile && ![model.mobile isEqualToString:@""]) ? SSKJLocalized(@"已开启", nil)  : SSKJLocalized(@"未开启", nil);
        }else if (indexPath.row == 1){
            status = (model.mail && ![model.mail isEqualToString:@""]) ? SSKJLocalized(@"已开启", nil)   : SSKJLocalized(@"未开启", nil);
        }else if (indexPath.row == 2){
            status = SSKJLocalized(@"修改", nil);
        }else if (indexPath.row == 3){
//            status = [[kUserDefaults objectForKey:@"payPwd"] integerValue] == 1 ? SSKJLocalized(@"修改", nil) : SSKJLocalized(@"未设置", nil);
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            if ([model.status integerValue] == 1) {  // 未认证
                status = SSKJLocalized(@"一级未认证", nil);
            } else if ([model.status integerValue] == 2) {
                status = SSKJLocalized(@"一级审核中", nil);
            } else if ([model.status integerValue] == 3) {
                if (model.auth_status.integerValue == 1) {
                    status = SSKJLocalized(@"一级已认证", nil);
                }else if (model.auth_status.integerValue == 2){
                    status = SSKJLocalized(@"二级审核中", nil);
                }
                else if (model.auth_status.integerValue == 3){
                    status = SSKJLocalized(@"二级已认证", nil);
                }
                else if (model.auth_status.integerValue == 4){
                    status = SSKJLocalized(@"二级已拒绝", nil);
                }
            } else if ([model.status integerValue] == 4) {
                status = SSKJLocalized(@"初级已拒绝", nil);
            }
        }else if (indexPath.row == 1){
            if (model.is_start_google.integerValue == 1) {  // 已认证
                status = SSKJLocalized(@"已开启", nil);
            } else{
                status = SSKJLocalized(@"未开启", nil);
            }
        }
            
    }
    
    return status;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 || indexPath.section == 1){
       return ScaleW(56);
    }else{
        return ScaleW(122);
    }

}
//-(BFEX_FBC_UnVerBuss_View *)unVerBussView
//{
//    if (_unVerBussView==nil)
//    {
//
//        _unVerBussView=[[BFEX_FBC_UnVerBuss_View alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//        WS(weakSelf);
//        _unVerBussView.sureButtonBlock = ^{
//
//            [HttpTool postWithURL:KAccountOffApi params:@{@"account":KAccount} success:^(id json) {
//                if ( [[NSString stringWithFormat:@"%@",json[@"status"]] isEqualToString:@"200"])
//                {
//                     [MBProgressHUD showError:json[@"msg"]];
//                     [weakSelf loadUserData:kPhoneNumber];
//                }
//                else
//                {
//                      [MBProgressHUD showError:json[@"msg"]];
//                }
//                weakSelf.unVerBussView.hidden = YES;
//
//            } failure:^(NSError *error) {
//
//            }];
//        };
//    }
//
//    return _unVerBussView;
//}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0 || section == 1){
        return 0.01;
    }
    if(section == 2){
        return self.sectionView.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if(section == 2)
    {
        return self.sectionView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  return [[UIView alloc] initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    if (indexPath.section == 0) {
        BLSafeCenterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 0) {
            if (self.userModel.mobile.length != 0) {
                [MBProgressHUD showError:SSKJLocalized(@"手机号已开启", nil)];
            }else{
                My_BindPhone_ViewController *vc = [[My_BindPhone_ViewController alloc]init];
                vc.bindType = BindTypePhone;
                vc.successBlock = ^(NSString * _Nonnull account) {
                    cell.status.text = account;
                    weakSelf.userModel.mobile = account;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.row == 1) {
            if (self.userModel.mail.length != 0) {
                [MBProgressHUD showError:SSKJLocalized(@"邮箱已开启", nil)];
            } else {
                My_BindPhone_ViewController *bindEmailVC = [[My_BindPhone_ViewController alloc] init];
                bindEmailVC.bindType = BindTypeEmail;
                bindEmailVC.successBlock = ^(NSString * _Nonnull account) {
                    cell.status.text = account;
                    weakSelf.userModel.mail = account;
                };
                [self.navigationController pushViewController:bindEmailVC animated:YES];
            }
        }else if (indexPath.row == 2) {
            My_ChangePWD_ViewController *resetPwdVC = [[My_ChangePWD_ViewController alloc] init];
            [self.navigationController pushViewController:resetPwdVC animated:YES];
        }else if (indexPath.row == 3) {
            My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
            vc.statusBlock = ^{
                cell.status.text = @"已设置";
            };
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"emailIndex"] isEqualToString:@"1"]) {
                vc.phoneNumber = self.userModel.mail;
            }else{
                vc.phoneNumber = self.userModel.mobile;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4) {
            HeBi_Mine_Certificate_ViewController *vc = [[HeBi_Mine_Certificate_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 5){
            
        }else if (indexPath.row == 6) {
            [self.googleAlertView showWithType:GOOGLETYPEDELETE];
            return;
            if (self.userModel.is_start_google.integerValue == 0) {
                My_GoogleVerify_ViewController *vc = [[My_GoogleVerify_ViewController alloc]init];
                WS(weakSelf);
                vc.addGoogleBlock = ^{
                    weakSelf.userModel.is_start_google = @"1";
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self.googleAlertView showWithType:GOOGLETYPEDELETE];
            }
        }
    }

}
    
-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(98))];
        _sectionView.backgroundColor = kSubBackgroundColor;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 10.f)];
        view.backgroundColor = kMainBackgroundColor;
        
        [_sectionView addSubview:view];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(17, 25, 0, 14);
        label.font = [UIFont systemFontOfSize:14];
        label.text = SSKJLocalized(@"支付方式", nil);
        [label sizeToFit];
        label.textColor = kTextLightBlueColor;
        label.textAlignment = NSTextAlignmentCenter;  label.backgroundColor = [UIColor clearColor];
        [_sectionView addSubview:label];
        UILabel *labelcontent = [[UILabel alloc] init];
        labelcontent.font = [UIFont systemFontOfSize:12.f];
        labelcontent.frame = CGRectMake(17, label.bottom + 13, Screen_Width - 34, 0);
        labelcontent.text = SSKJLocalized(@"请务必使用您本人的实名账户，被激活的支付方式将在交易时向买方展示，最多激活3种", nil);
        NSString *string = SSKJLocalized(@"请务必使用您本人的实名账户，被激活的支付方式将在交易时向买方展示，最多激活3种", nil);
        CGFloat height = [string boundingRectWithSize:CGSizeMake(ScreenWidth - 34, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(12)} context:nil].size.height;
        labelcontent.height = height;
        _sectionView.height = height + 65;
        labelcontent.numberOfLines = 0;
        [labelcontent sizeToFit];
        labelcontent.textColor = [UIColor colorWithHexStringToColor:@"8d93bc"];
       
        [_sectionView addSubview:labelcontent];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _sectionView.height - 1, Screen_Width, 1.f)];
        line.backgroundColor = kLineGrayColor;
         [_sectionView addSubview:line];

    }
    return _sectionView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 55)];
        _footerView.backgroundColor = kSubBackgroundColor;
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 0, Screen_Width, 55);
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [button setTitle:SSKJLocalized(@"添加支付方式", nil) forState:UIControlStateNormal];
        [button setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
        
        
    }
    return _footerView;
}
#pragma mark -- 添加支付方式 --
-(void)buttonClicked:(UIButton *)sender
{
//    NSInteger status = [ManagerSocket sharedManager].model.status.integerValue;
//    NSInteger status = @"";
//    if (status != 3) {
////        [self judgeFristCertificate];
//        return;
//    }
//
////    NSString *tpwd = [ManagerSocket sharedManager].model.tpwd;
//    NSString *tpwd  = @"";
//
//    if ([tpwd isEqual:[NSNull null]] || tpwd.length == 0) {
////        [self judgePayPassword];
//        return;
//    }
    
    [self showViewAlert:@"add"];
}
-(void)showViewAlert:(id)type{
    BFEXSafeSelectViewController *vc = [[BFEXSafeSelectViewController alloc]init];
    [vc showViewAlert:type];
    [self.navigationController presentViewController:vc animated:YES completion:^{

    }];

    
}


#pragma mark - 取消谷歌绑定

-(void)requestDeleteGoogleWithCode:(NSString *)smsCode googleCode:(NSString *)googleCode
{
    WS(weakSelf);
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSDictionary *params = @{
//                             @"act":@0,
//                             @"code":smsCode,
//                             @"dyGoodleCommand":googleCode,
//                             @"mobile":kPhoneNumber
//                             };
//    [HttpTool postWithURL:Set_google_state params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        if (status.integerValue == 200) {
//            [MBProgressHUD showError:json[@"msg"]];
//            weakSelf.userModel.is_start_google = @"0";
//            [weakSelf.tableView reloadData];
//        }else{
////            [self.switchBtn setOn:NO animated:YES];
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//        [hud hideAnimated:YES];
//    } failure:^(NSError *error) {
//        [hud hideAnimated:YES];
//        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

