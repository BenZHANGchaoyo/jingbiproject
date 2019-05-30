//
//  My_UserInfo_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "JB_UserInfo_ViewController.h"
#import "JB_Info_Cell.h"

@interface JB_UserInfo_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JB_UserInfo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"个人信息", nil);
    self.view.backgroundColor = kMainBackgroundColor;
    [self setUI];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:10];
    
    [self.dataSource addObject:@[
//                                 ZBLocalized(@"VIP", nil),
                                 SSKJLocalized(@"手机号：", nil),
                                 SSKJLocalized(@"交易ID：", nil),
                                 SSKJLocalized(@"姓名：", nil),
                                 SSKJLocalized(@"身份证号：", nil)
                                 ]];
    
//    NSInteger vipLevel = [WLTools vipLevelWithModel:self.userModel money:[NSString stringWithFormat:@"%f",self.userModel.wallone]];
//
//    NSString *rate = @"0";
    
//    switch (vipLevel) {
//        case 0:
//            rate = @"0";
//            break;
//        case 1:
//            rate = self.userModel.free_fee1;
//            break;
//        case 2:
//            rate = self.userModel.free_fee2;
//            break;
//        case 3:
//            rate = self.userModel.free_fee3;
//            break;
//        case 4:
//            rate = self.userModel.free_fee4;
//            break;
//        case 5:
//            rate = self.userModel.free_fee5;
//            break;
//
//        default:
//            break;
//    }
    
    
//    NSString *vipString = [NSString stringWithFormat:@"%@VIP%ld，%@%@%%",SSKJLocalized(@"当前为", nil),vipLevel,SSKJLocalized(@"交易手续费减免", nil),[WLTools noroundingStringWith:rate.doubleValue afterPointNumber:2]];
//
//    NSString *phone = _userModel.mobile && ![_userModel.mobile isEqualToString:@""] ? _userModel.mobile : @"--";
//
//    NSString *account = _userModel.account;
//    NSString *userName = _userModel.realname && ![_userModel.realname isEqualToString:@""] ? _userModel.realname : @"--";
//    NSString *idCard = _userModel.idcard && ![_userModel.idcard isEqualToString:@""] ? _userModel.idcard : @"--";
    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:10];
//    [valueArray addObject:vipString];
//    [valueArray addObject:phone];
//    [valueArray addObject:account];
//    [valueArray addObject:userName];
//    [valueArray addObject:idCard];
//    [valueArray addObject:@"vip"];
    [valueArray addObject:@"15617937727"];
    [valueArray addObject:@"188718272"];
    [valueArray addObject:@"James"];
    [valueArray addObject:@"41023123124123123"];
    [self.dataSource addObject:valueArray];

}

-(void)setUI
{
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(10)) style:UITableViewStylePlain];
        _tableView.backgroundColor = kMainBackgroundColor;
        _tableView.separatorColor = kMainBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[JB_Info_Cell class] forCellReuseIdentifier:NSStringFromClass([self class])];
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
        
        
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _tableView.separatorColor = kLineGrayColor;
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate UITableViewDatsSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = self.dataSource.firstObject;
    NSArray *valueArray = self.dataSource.lastObject;
    NSString *title = titleArray[indexPath.row];
    NSString *value = valueArray[indexPath.row];
    
    JB_Info_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    [cell setCellWithTitle:title value:value];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
