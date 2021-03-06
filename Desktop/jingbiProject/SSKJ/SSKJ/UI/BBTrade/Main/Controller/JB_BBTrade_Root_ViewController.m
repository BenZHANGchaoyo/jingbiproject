//
//  JB_BBTrade_Root_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_Root_ViewController.h"
// view
#import "JB_BBTrade_MainHeader_View.h"
#import "JB_BBTrade_SectinHeaderView.h"
#import "Nodata_Cell.h"

// controller
#import "JB_BBTrade_SliderMarket_ViewController.h"
#import "CWLateralSlideConfiguration.h"
#import "UIViewController+CWLateralSlide.h"
#import "JB_BBTrade_OrderList_ViewController.h"
#import "JB_BBTrade_MarketDetail_ViewController.h"

// model
#import "JB_BBTrade_BalanceModel.h"

// tools
#import "ManagerSocket.h"

static NSString *marketSocketIdentifier = @"marketSocketIdentifier";

static NSString *pankouSocketIdentifier = @"pankouSocketIdentifier";

static NSString *deepSocketIdentifier = @"deepSocketIdentifier";


#define kPageSize @"10"

static NSString *cellid = @"ETF_Withdraw_Cell";
static NSString *nodataCellid = @"Nodata_Cell";

@interface JB_BBTrade_Root_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JB_BBTrade_MainHeader_View *headerView;
@property (nonatomic, strong) JB_BBTrade_SectinHeaderView *sectionHeaderView;
@property (nonatomic, strong) UILabel *coinNameLabel;

@property (nonatomic, strong) JB_Market_Index_Model *coinModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) ManagerSocket *marketSocket;  // 行情（价格推送）
@property (nonatomic, strong) ManagerSocket *pankouSocket;  // 盘口推送
@property (nonatomic, strong) ManagerSocket *deepthSocket;  // 深度推送


@end

@implementation JB_BBTrade_Root_ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetCoinModel:) name:@"didGetCoinModel" object:nil];
    }
    return self;
}

-(void)didGetCoinModel:(NSNotification *)notification
{
    
    JB_Market_Index_Model *model = notification.object;
    
    self.coinModel = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self setUI];
    self.page = 1;
    
    [self selectCoinModel:self.coinModel];
    
    [self setLeftBarButtonItem];
    
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"market_icon"]];

}


-(void)setLeftBarButtonItem
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(100), ScaleW(44))];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    imageView.centerY = view.height / 2;
    imageView.image = [UIImage imageNamed:@"position_slider"];
    [view addSubview:imageView];
//    NSString *coinName = [[self.coinModel.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    UILabel *label = [WLTools allocLabel:@"ETH/USDT" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(imageView.right + ScaleW(5), 0, ScaleW(80), view.height) textAlignment:NSTextAlignmentLeft];
    self.coinNameLabel = label;
    [view addSubview:label];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(NavigationLeftEvent)];
    [view addGestureRecognizer:tap];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
}

-(void)NavigationLeftEvent
{
    JB_BBTrade_SliderMarket_ViewController *vc = [[JB_BBTrade_SliderMarket_ViewController alloc]init];
    vc.sliderWidth = ScreenWidth - ScaleW(120);
    WS(weakSelf);
    vc.selectCoinBlock = ^(JB_Market_Index_Model * _Nonnull coinModel) {
        weakSelf.coinModel = coinModel;
        [weakSelf selectCoinModel:weakSelf.coinModel];
    };
    CWLateralSlideConfiguration *config = [[CWLateralSlideConfiguration alloc]initWithDistance:vc.sliderWidth maskAlpha:0.6 scaleY:1 direction:CWDrawerTransitionFromLeft backImage:nil];
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:config];
}

//-(void)setCoinModel:(JB_Market_Index_Model *)coinModel
//{
//    if (![self.coinModel.code isEqualToString:coinModel.code]) {
//        _coinModel = coinModel;
//        [self closeSocket];
//    }
//
//    [self openSocket];
//}


-(void)selectCoinModel:(JB_Market_Index_Model *)coinModel
{
    self.coinNameLabel.text = coinModel.name;
    self.title = coinModel.name;
    self.headerView.coinModel = self.coinModel;
}

-(void)rigthBtnAction:(id)sender
{
    JB_BBTrade_MarketDetail_ViewController *vc = [[JB_BBTrade_MarketDetail_ViewController alloc]init];
    vc.isFromBBTrade = YES;
    vc.coinModel = self.coinModel;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefresh];
    
    [self openSocket];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self closeSocket];
}


#pragma mark - socket

-(ManagerSocket *)marketSocket
{
    if (nil == _marketSocket) {
        _marketSocket = [[ManagerSocket alloc]initWithUrl:BBMarketSocketUrl identifier:marketSocketIdentifier];
    }
    return _marketSocket;
}
-(ManagerSocket *)pankouSocket
{
    if (nil == _pankouSocket) {
        _pankouSocket = [[ManagerSocket alloc]initWithUrl:BBPankouSocketUrl identifier:pankouSocketIdentifier];
    }
    return _pankouSocket;
}

-(ManagerSocket *)deepthSocket
{
    if (nil == _deepthSocket) {
        _deepthSocket = [[ManagerSocket alloc]initWithUrl:BBDeepthSocketUrl identifier:deepSocketIdentifier];
    }
    return _deepthSocket;
}

-(void)openSocket
{
    
    if (self.coinModel == nil) {
        return;
    }
    
    if (!self.marketSocket.socketIsConnected) {
        self.marketSocket.delegate = self;
        WS(weakSelf);
        [self.marketSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
            [weakSelf.marketSocket socketSendMsg:type];
        }];
    }
    if (!self.pankouSocket.socketIsConnected) {
        self.pankouSocket.delegate = self;
        WS(weakSelf);
        [self.pankouSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
            [weakSelf.pankouSocket socketSendMsg:type];

        }];
    }
//    return;
    if (!self.deepthSocket.socketIsConnected) {
        self.deepthSocket.delegate = self;
        WS(weakSelf);
        [self.deepthSocket openConnectSocketWithConnectSuccess:^{
            NSString *type = [WLTools wlDictionaryToJson:@{@"code":@"all"}];
            [weakSelf.deepthSocket socketSendMsg:type];
        }];
    }
}


-(void)closeSocket
{
    if (self.marketSocket.socketIsConnected) {
        [self.marketSocket closeConnectSocket];
        self.marketSocket.delegate = nil;
    }
    if (self.deepthSocket.socketIsConnected) {
        [self.deepthSocket closeConnectSocket];
        self.deepthSocket.delegate = nil;
    }
    
    if (self.pankouSocket.socketIsConnected) {
        [self.pankouSocket closeConnectSocket];
        self.pankouSocket.delegate = nil;
    }
}

-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    NSDictionary *dic = [self dicWithData:data];
    
    if (![dic[@"code"] isEqualToString:self.coinModel.code]) {
        return;
    }
    
    if ([identifier isEqualToString:deepSocketIdentifier]) {
        [self.headerView setDeepData:dic];
    }else if ([identifier isEqualToString:pankouSocketIdentifier]){
        ETF_Contract_Depth_Model *model = [ETF_Contract_Depth_Model mj_objectWithKeyValues:dic];
        [self.headerView setPankouData:model];
    }else if ([identifier isEqualToString:marketSocketIdentifier]){
        JB_Market_Index_Model *model = [JB_Market_Index_Model mj_objectWithKeyValues:dic];
        [self.headerView setMarketData:model];
    }
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.tableView];
    
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight  - Height_NavBar - ScaleW(10)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerClass:[ETF_Withdraw_Cell class] forCellReuseIdentifier:cellid];
        [_tableView registerClass:[Nodata_Cell class] forCellReuseIdentifier:nodataCellid];

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
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _tableView;
}


-(JB_BBTrade_MainHeader_View *)headerView
{
    if (nil == _headerView) {
        _headerView = [[JB_BBTrade_MainHeader_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(100))];
        WS(weakSelf);
        _headerView.confirmBuyBlock = ^(NSString * _Nonnull number, BuySellType buySellType, PriceType priceType,NSString *price) {
            [weakSelf confirmBuyWithAmount:number priceType:priceType buySellType:buySellType price:price];
        };
    }
    return _headerView;
}

- (JB_BBTrade_SectinHeaderView *)sectionHeaderView
{
    if (nil == _sectionHeaderView) {
        _sectionHeaderView = [[JB_BBTrade_SectinHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(60))];
        WS(weakSelf);
        _sectionHeaderView.allBlock = ^{
            JB_BBTrade_OrderList_ViewController *vc = [[JB_BBTrade_OrderList_ViewController alloc]init];
            vc.coinModel = weakSelf.coinModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _sectionHeaderView;
}

#pragma mark - UITableViewDelegate UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(60);
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ScaleW(0.01);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > 0) {
        return ScaleW(95);
    }else{
        return ScaleW(400);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > 0) {
        return nil;
    }else{
        
        Nodata_Cell *cell = [tableView dequeueReusableCellWithIdentifier:nodataCellid];
        return cell;
    }
}


#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestCoinBalance];
//    [self requestRecordList];
}

-(void)footerRefresh
{
//    [self requestRecordList];
}

-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - 网络请求

-(void)confirmBuyWithAmount:(NSString *)amount priceType:(PriceType)priceType buySellType:(BuySellType)buySellType price:(NSString *)price
{
    
    NSString *type = @"1";
    
    if (buySellType == BuySellTypeSell) {
        type = @"2";
    }
    
    NSString *oType = @"1";
    
    if (priceType == PriceTypeMarket) {
        oType = @"2";
    }
    
    NSDictionary *params = @{
                             @"mobile":kPhoneNumber,
                             @"code":self.coinModel.code,
                             @"buyprice":price,
                             @"buynum":amount,
                             @"toalprice":amount,
                             @"toalnum":amount,
                             @"type":type,
                             @"otype":oType
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_BBTrade_ConfirmBuy_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            JB_BBTrade_MarketDetail_ViewController *vc = [[JB_BBTrade_MarketDetail_ViewController alloc]init];
            vc.isFromBBTrade = YES;
            vc.coinModel = self.coinModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];

}

-(void)requestCoinBalance
{
        
    NSDictionary *params = @{
                             @"code":self.coinModel.code,
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_BBTrade_GetCoinBalance_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            JB_BBTrade_BalanceModel *model = [JB_BBTrade_BalanceModel mj_objectWithKeyValues:network_model.data];
            [weakSelf.headerView setViewWithBalanceModel:model];
            
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
        [weakSelf endRefresh];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf endRefresh];

    }];
    
}



-(NSDictionary *)dicWithData:(id)data
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSDictionary *singleGoodsDatas = nil;
    if ([data isKindOfClass:[NSString class]]) {
        singleGoodsDatas = [self dictionaryWithJsonString:data];
        dic = [singleGoodsDatas mutableCopy];
    } else if ([data isKindOfClass:[NSDictionary class]])
    {
        singleGoodsDatas = data;
        NSString *goodsCode = [WLTools stringTransformObject:[singleGoodsDatas objectForKey:@"code"]];
        [dic setObject:singleGoodsDatas forKey:goodsCode];
    }
    return dic;
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}






@end
