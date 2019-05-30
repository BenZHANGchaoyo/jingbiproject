//
//  My_PromoteDetail_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/11/29.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "My_PromoteDetail_ViewController.h"


#import "My_PromoteDetail_Cell.h"


#import "My_PromoteDetail_Model.h"

#import "My_Friend_HeaderView.h"

#define kPage_Size @"10"

@interface My_PromoteDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) My_Friend_HeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) My_PromoteDetail_Model *detailModel;
@end

@implementation My_PromoteDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kMainBackgroundColor;
    self.title = SSKJLocalized(@"我的客户", nil);
    self.page = 1;
    [self setUI];
    [self requestData];
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.tableView];
}
-(My_Friend_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[My_Friend_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.backgroundColor = kMainBackgroundColor;
        _tableView.separatorColor = kLineGrayColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[My_PromoteDetail_Cell class] forCellReuseIdentifier:@"promoteDetailCell"];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        
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
        
        
    }
    return _tableView;
}

#pragma mark - 上拉、下拉

// 下拉刷新
-(void)headerRefresh
{
    self.page = 1;
    [self requestData];
}


// 上拉加载
-(void)footerRefresh
{
    [self requestData];
}

-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        self.tableView.mj_header.state = MJRefreshStateIdle;
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
}

#pragma mark - UITableViewDelegate UITalbleDataSource


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(60);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_PromoteDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"promoteDetailCell"];
    My_Promote_Index_Model *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

#pragma mark - 网络请求
// 请求推广明细列表
-(void)requestData
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"p"] = @(self.page);
//    params[@"size"] = kPage_Size;
//
//    LSLog(@"parmas : %@",params);
//
//    WS(weakSelf);
//
//    [hud hideAnimated:YES afterDelay:5.f];
//
//    [HttpTool getWithURL:MyPromotDetailURL params:params success:^(id json)
//     {
//         WL_NetWork_Model *network_Model=[WL_NetWork_Model mj_objectWithKeyValues:json];
//
//         [hud hideAnimated:YES];
//
//         if ([network_Model.status isEqualToString:SUCCESS])
//         {
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 [weakSelf handleDataWithNetModel:network_Model];
//
//             });
//         }else
//         {
//             [MBProgressHUD showError:network_Model.msg];
//             [weakSelf endRefresh];
//         }
//
//     } failure:^(NSError *error)
//     {
//         [weakSelf endRefresh];
//
//         [hud hideAnimated:YES];
//     }];
}

//-(void)handleDataWithNetModel:(WL_NetWork_Model *)net_model
//{
//
//    if (self.page == 1) {
//        [self.dataSource removeAllObjects];
//    }
//
//    self.detailModel = [My_PromoteDetail_Model mj_objectWithKeyValues:net_model.data];
//    if (self.detailModel.list.count != kPage_Size.integerValue) {
//        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//    }
//
//    [self.dataSource addObjectsFromArray:self.detailModel.list];
//
//    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(30)];
//    [self.tableView reloadData];
//    self.page++;
//
//    [self endRefresh];
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
