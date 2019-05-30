//
//  BuySell5_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BuySell5_View.h"
#import "BuySell5_HeaderView.h"
#import "BuySell5_Cell.h"
#import "BBTrade_SectiobHeaderView.h"

static NSString *cellid = @"BuySell5_Cell";

@interface BuySell5_View ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BuySell5_HeaderView *headerView;
@property (nonatomic, strong) BBTrade_SectiobHeaderView *sectionHeaderView;

@property (nonatomic, strong) UILabel *deepPriceView;
@property (nonatomic, strong) UILabel *deepCNYPriceView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger dotNumber;

@property (nonatomic, strong) ETF_Contract_Depth_Model *model;
@end

@implementation BuySell5_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dotNumber = 1;
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BuySell5_Cell class] forCellReuseIdentifier:cellid];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(BuySell5_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[BuySell5_HeaderView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(24))];
        WS(weakSelf);
        _headerView.changeDotBlock = ^(NSInteger dotNumber) {
            weakSelf.dotNumber = dotNumber;
        };
    }
    return _headerView;
}

-(BBTrade_SectiobHeaderView *)sectionHeaderView
{
    if (nil == _sectionHeaderView) {
        _sectionHeaderView = [[BBTrade_SectiobHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(75))];
    }
    return _sectionHeaderView;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(25);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return ScaleW(75);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return ScaleW(24);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        return self.sectionHeaderView;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuySell5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    ETF_Contract_Depth_Index_Model *model;

    NSArray *array;
    if (indexPath.section == 0) {
        array = [[self.model.asks reverseObjectEnumerator] allObjects];
        NSInteger index = 6 -  indexPath.row;
        if (index >= array.count) {
            model = nil;
        }else{
            model = array[index];
        }
    }else{
        array = self.model.bids;
        model = array[indexPath.row];
    }
    
    
//    if (indexPath.row >= array.count) {
//        model = nil;
//    }else{
//        model = array[indexPath.row];
//    }
    
    NSString *price = model.price;
    if ([price isEqual:[NSNull null]] || price.length == 0) {
        price = @"--";
    }
    
    NSString *volume = model.totalSize;
    if ([volume isEqual:[NSNull null]] || volume.length == 0) {
        volume = @"--";
    }
    
    [cell setCellWithIndexPath:indexPath price:price number:volume dotNumber:self.dotNumber];

    return cell;
}


-(void)setViewWithModel:(ETF_Contract_Depth_Model *)model
{
    self.model = model;
    
    if (![self.model.asks isKindOfClass:[NSArray class]]) {
        self.model.asks = [NSMutableArray arrayWithCapacity:10];
    }
    
    if (![self.model.bids isKindOfClass:[NSArray class]]) {
        self.model.bids = [NSMutableArray arrayWithCapacity:10];
    }
    
    [self.tableView reloadData];
}

-(void)setPriceModel:(JB_Market_Index_Model *)model
{
//    self.sectionHeaderView.priceLabel.text = [WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:4];
    
    
    NSString *formate = [NSString stringWithFormat:@"%%.%ldf",self.dotNumber];
    
    NSString *priceString = [NSString stringWithFormat:formate,[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:self.dotNumber].doubleValue];
    
    self.sectionHeaderView.priceLabel.text = [NSString stringWithFormat:@"%.4f",priceString.doubleValue];
    
    UIColor *color;
    if (model.change.doubleValue > 0) {
        color = GREEN_HEX_COLOR;
    }else{
        color = RED_HEX_COLOR;
    }
    
    self.sectionHeaderView.priceLabel.textColor = color;
    self.sectionHeaderView.cnyPriceLabel.text = [NSString stringWithFormat:@"≈%@CNY",[WLTools noroundingStringWith:model.cnyPrice.doubleValue afterPointNumber:2]];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
