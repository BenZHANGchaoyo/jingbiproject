//
//  HeBi_AddressManager_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_AddressManager_ViewController.h"

// view
#import "HeBi_Address_SectionHeaderView.h"
#import "HeBi_Address_Cell.h"
#import "HeBi_Default_AlertView.h"
// controller
#import "HeBi_AddAddress_ViewController.h"

// model
#import "HeBi_WalletAddress_Model.h"



static NSString *sectionID = @"HeBi_Address_SectionHeaderView";
static NSString *cellID = @"HeBi_Address_Cell";

@interface HeBi_AddressManager_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<HeBi_WalletAddress_Model *> *btcArray;
@property (nonatomic, strong) NSArray<HeBi_WalletAddress_Model *> *ethArray;


@property (nonatomic, strong) NSIndexPath *deleteIndexpath;
@end

@implementation HeBi_AddressManager_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"添加提币地址", nil);
    // Do any additional setup after loading the view.
    [self setUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestAddressList];
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.separatorColor = kLineGrayColor;
        _tableView.backgroundColor = kMainBackgroundColor;

        
        [_tableView registerClass:[HeBi_Address_Cell class] forCellReuseIdentifier:cellID];
        [_tableView registerClass:[HeBi_Address_SectionHeaderView class] forHeaderFooterViewReuseIdentifier:sectionID];
        
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.btcArray.count;
    }else{
        return self.ethArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(72);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(54);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeBi_Address_SectionHeaderView *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionID];

    if (section == 0) {
        sectionHeader.coinName = @"BTC";
        
        WS(weakSelf);
        sectionHeader.addBlock = ^(NSString * _Nonnull coinName) {
            HeBi_AddAddress_ViewController *vc = [[HeBi_AddAddress_ViewController alloc]init];
            vc.coinType = @"btc";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }else{
        sectionHeader.coinName = @"ETH";
        
        WS(weakSelf);
        sectionHeader.addBlock = ^(NSString * _Nonnull coinName) {
            HeBi_AddAddress_ViewController *vc = [[HeBi_AddAddress_ViewController alloc]init];
            vc.coinType = @"eth";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    
    
    return sectionHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeBi_Address_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    HeBi_WalletAddress_Model *model;
    if (indexPath.section == 0) {
        model = self.btcArray[indexPath.row];
    }else{
        model = self.ethArray[indexPath.row];
    }
    
    [cell setCellWithModel:model];
    WS(weakSelf);
    cell.deleteBlock = ^{
        weakSelf.deleteIndexpath = indexPath;
        
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提醒",nil)  message:SSKJLocalized(@"是否确定删除该地址？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
            [weakSelf requestDeleteAddressWithIndex:weakSelf.deleteIndexpath];
        }];
        
    };
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.btcArray;
    if (indexPath.section == 1) {
        array = self.ethArray;
    }
    HeBi_WalletAddress_Model *model = array[indexPath.row];
    if (self.addressSelectBlock) {
        self.addressSelectBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

#pragma mark - 请求地址列表

-(void)requestAddressList
{
    
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    [HttpTool postWithURL:AddressListURL params:nil success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_NetWork_Model *net_model = [WL_NetWork_Model mj_objectWithKeyValues:json];
//        if ([net_model.status isEqualToString:SUCCESS]) {
//            [weakSelf handleAddressListWithModel:net_model];
//        }else{
//            [MBProgressHUD showError:net_model.msg];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:ZBLocalized(@"网络异常", nil)];
//    }];
    

}


//-(void)handleAddressListWithModel:(WL_NetWork_Model *)net_model
//{
//    self.btcArray = [HeBi_WalletAddress_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"btc"]];
//    self.ethArray = [HeBi_WalletAddress_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"eth"]];
//    [self.tableView reloadData];
//}


#pragma mark - 删除地址

-(void)requestDeleteAddressWithIndex:(NSIndexPath *)indexPath
{
    
    NSArray *array;
    if (indexPath.section == 0) {
        array = self.btcArray;
    }else{
        array = self.ethArray;
    }

    HeBi_WalletAddress_Model *model = array[indexPath.row];
//
//    NSDictionary *params = @{
//                             @"qiaobao_url":model.qiaobao_url,
//                             @"notes":model.notes,
//                             @"type":model.type,
//                             @"act":@"del",
//                             @"id":model.ID
//                             };
//
//
//
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//
//    [HttpTool postWithURL:AddTiBiAddressURL params:params success:^(id json) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_NetWork_Model *net_model = [WL_NetWork_Model mj_objectWithKeyValues:json];
//        if ([net_model.status isEqualToString:SUCCESS]) {
//            [MBProgressHUD showSuccess:net_model.msg];
//            [weakSelf requestAddressList];
//        }else{
//            [MBProgressHUD showError:net_model.msg];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:ZBLocalized(@"网络异常", nil)];
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
