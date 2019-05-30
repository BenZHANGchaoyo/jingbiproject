//
//  JB_PledgeBorrow_ViewController.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_PledgeBorrow_ViewController.h"
#import "JB_PledgeBorrowTableViewCell.h"
#import "JB_PledgeBorrowModel.h"
#import "JB_WalletHeaderView.h"
#import "JB_PledgeRecordListViewController.h"
#define kPage_size @"10"
@interface JB_PledgeBorrow_ViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) JB_WalletHeaderView *headerView;

@end

@implementation JB_PledgeBorrow_ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"抵押借款", nil);
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.headerView;
    [self addRightNavItemWithTitle:SSKJLocalized(@"抵押记录", nil)
                             color:kMainWihteColor
                              font:[UIFont systemFontOfSize:ScaleW(14)]];
    
    
}

- (void)rigthBtnAction:(id)sender {
    JB_PledgeRecordListViewController *vc = [[JB_PledgeRecordListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self headerRefresh];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}



#pragma mark -- 网络请求

#pragma mark - 请求资产
-(void)requestPborrow
{
    //    NSDictionary *params = @{
    //                             @"page":@(self.page),
    //                             @"size":kPage_size,
    //                             @"pid":self.coinKeyString?:@"",
    //                             @"type":@"1",
    //                             @"wall_type":self.wallTypeString?:@""
    //                             };
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    WS(weakSelf);
    //    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_AssetDetail_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
    //        //        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    //        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
    //        if ([network_model.status integerValue] == SUCCESSED) {
    //            [weakSelf handleTeamDataWithModel:network_model];
    //        }else{
    //            [weakSelf endRefresh];
    //            [MBProgressHUD showError:network_model.msg];
    //        }
    //
    //    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
    //        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    //        [weakSelf endRefresh];
    //        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    //    }];
    
}


-(void)handleTeamDataWithModel:(WL_Network_Model *)network_model
{
    
    NSArray *array = [JB_PledgeBorrowModel mj_objectArrayWithKeyValuesArray:network_model.data];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    _page++;
    [self.dataSource addObjectsFromArray:array];
    
    if (array.count != kPage_size.integerValue) {
        self.mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.mainTableView offY:ScaleW(50)];
    
    [self endRefresh];
    
    [self.mainTableView reloadData];
    
    
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JB_PledgeBorrowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
//    [cell configureCellWithModel:self.dataSource[indexPath.row]];
    
    
    return cell;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = kMainBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = ScaleW(64);
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[JB_PledgeBorrowTableViewCell class] forCellReuseIdentifier:@"cell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _mainTableView;
}

- (JB_WalletHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JB_WalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(157))];
        _headerView.bgIM.image = [UIImage imageNamed:@"dyjk_bg_icon"];
    }
    return _headerView;
}


#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestPborrow];
}

-(void)footerRefresh
{
    [self requestPborrow];
}

-(void)endRefresh
{
    //    UITableView *tableView = _type == 0 ? self.teamTableView : self.incomeTableView;
    if (self.mainTableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.mainTableView.mj_header endRefreshing];
    }
    
    if (self.mainTableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.mainTableView.mj_footer endRefreshing];
    }
}



@end
