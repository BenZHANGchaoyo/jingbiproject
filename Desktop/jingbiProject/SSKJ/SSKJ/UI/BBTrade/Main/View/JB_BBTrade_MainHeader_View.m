//
//  JB_BBTrade_MainHeader_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//


#import "JB_BBTrade_MainHeader_View.h"
#import "BBTrade_NumberView.h"
#import "BuySell5_View.h"
#import "LXY_DeepView.h"
#import "ETF_Default_ActionsheetView.h"

@interface JB_BBTrade_MainHeader_View ()
@property (nonatomic, strong) BuySellSelectView *buySellSelectView; // 买入卖出选择按钮
@property (nonatomic, strong) UIButton *priceTypeButton;            // 市价、限价选择按钮
@property (nonatomic, strong) BBTrade_PriceView *priceView;         // 价格输入框
@property (nonatomic, strong) BBTrade_NumberView *numberView;       // 数量输入框
@property (nonatomic, strong) UILabel *canuseTitleLabel;                 // 可用label
@property (nonatomic, strong) UILabel *canuseLabel;                 // 可用label
@property (nonatomic, strong) UILabel *totalMoneyLabel;             // 交易额
@property (nonatomic, strong) UIButton *buySellButton;              // 买入卖出按钮
@property (nonatomic, strong) LXY_DeepView *deepView;               // 深度图
@property (nonatomic, strong) BuySell5_View *buySell5View;

@property (nonatomic, assign) BuySellType buySellType;

@property (nonatomic, assign) PriceType priceType;

@property (nonatomic, strong) JB_BBTrade_BalanceModel *balanceModel;

@end

@implementation JB_BBTrade_MainHeader_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        self.priceType = PriceTypeMarket;
        self.buySellType = BuySellTypeBuy;
        [self setUI];
        self.userInteractionEnabled = YES;
        self.height = self.deepView.bottom + ScaleW(30);
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.buySellSelectView];
    [self addSubview:self.priceTypeButton];
    [self addSubview:self.priceView];
    [self addSubview:self.numberView];
    [self addSubview:self.canuseTitleLabel];
    [self addSubview:self.canuseLabel];
    [self addSubview:self.totalMoneyLabel];
    [self addSubview:self.buySellButton];
    [self addSubview:self.deepView];
    [self addSubview:self.buySell5View];
}



-(BuySellSelectView *)buySellSelectView
{
    
    if (nil == _buySellSelectView) {
        _buySellSelectView = [[BuySellSelectView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(168), ScaleW(35))];
        WS(weakSelf);
        _buySellSelectView.buySellBlock = ^(BuySellType buySellType) {
            weakSelf.buySellType = buySellType;
            NSString *buyType = SSKJLocalized(@"买入",nil);
            UIColor *color = GREEN_HEX_COLOR;
            
            if (buySellType == BuySellTypeSell) {
                buyType = SSKJLocalized(@"卖出",nil);
                color = RED_HEX_COLOR;
            }
            weakSelf.buySellButton.backgroundColor = color;
            [weakSelf.buySellButton setTitle:buyType forState:UIControlStateNormal];
            
        };
    }
    return _buySellSelectView;
}

-(UIButton *)priceTypeButton
{
    if (nil == _priceTypeButton) {
        _priceTypeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.buySellSelectView.x, self.buySellSelectView.bottom + ScaleW(10), ScaleW(60), ScaleW(30))];
        _priceTypeButton.titleLabel.font = systemFont(ScaleW(13));
        [_priceTypeButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_priceTypeButton setTitle:SSKJLocalized(@"市价",nil) forState:UIControlStateNormal];
        CGFloat width = [WLTools getWidthWithText:SSKJLocalized(@"市价交易",nil) font:_priceTypeButton.titleLabel.font];
        _priceTypeButton.width = width + ScaleW(15);
        [_priceTypeButton setImage:[UIImage imageNamed:@"bc_bb_down"] forState:UIControlStateNormal];
        [_priceTypeButton setImage:[UIImage imageNamed:@"bc_bb_up"] forState:UIControlStateSelected];
        [_priceTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _priceTypeButton.imageView.image.size.width - ScaleW(4), 0, _priceTypeButton.imageView.image.size.width + ScaleW(4))];
        [_priceTypeButton setImageEdgeInsets:UIEdgeInsetsMake(0, _priceTypeButton.titleLabel.bounds.size.width, 0, -_priceTypeButton.titleLabel.bounds.size.width)];
        [_priceTypeButton addTarget:self action:@selector(selectPriceType) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _priceTypeButton;
}

-(BBTrade_PriceView *)priceView
{
    if (nil == _priceView) {
        _priceView = [[BBTrade_PriceView alloc]initWithFrame:CGRectMake(self.buySellSelectView.x, self.priceTypeButton.bottom + ScaleW(10), self.buySellSelectView.width, ScaleW(45))];
    }
    return _priceView;
    
}

-(BBTrade_NumberView *)numberView
{
    if (nil == _numberView) {
        _numberView = [[BBTrade_NumberView alloc]initWithFrame:CGRectMake(self.priceView.x, self.priceView.bottom + ScaleW(10), self.priceView.width, self.priceView.height)];
        WS(weakSelf);
        //        _numberView.numberChangeBlock = ^(NSString * _Nonnull numberChangeBlock) {
        //            weakSelf.totalMoneyLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"交易额", nil),];
        //        };
    }
    return _numberView;
}

-(UILabel *)canuseTitleLabel
{
    if (nil == _canuseTitleLabel) {
        NSString *title = SSKJLocalized(@"可用", nil) ;
        _canuseTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kTextLightWhiteColor frame:CGRectMake(self.numberView.x, self.numberView.bottom + ScaleW(10), self.numberView.width / 3, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
    }
    return _canuseTitleLabel;
}

-(UILabel *)canuseLabel
{
    if (nil == _canuseLabel) {
        NSString *title = @"0.000000USDT";
        
        _canuseLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kMainWihteColor frame:CGRectMake(self.canuseTitleLabel.right, self.numberView.bottom + ScaleW(10), self.numberView.width / 3 * 2, ScaleW(30)) textAlignment:NSTextAlignmentRight];
        _canuseLabel.backgroundColor = [UIColor clearColor];
    }
    return _canuseLabel;
}

-(UILabel *)totalMoneyLabel
{
    if (nil == _totalMoneyLabel) {
        NSString *title = [NSString stringWithFormat:@"%@：--",SSKJLocalized(@"交易额",nil)];
        _totalMoneyLabel = [WLTools allocLabel: title font:systemFont(ScaleW(14)) textColor:kTextLightBlueColor frame:CGRectMake(self.canuseTitleLabel.x, self.canuseLabel.bottom + ScaleW(5), self.numberView.width, ScaleW(43)) textAlignment:NSTextAlignmentLeft];
    }
    return _totalMoneyLabel;
}

-(UIButton *)buySellButton
{
    if (nil == _buySellButton) {
        _buySellButton = [[UIButton alloc]initWithFrame:CGRectMake(self.numberView.x, self.totalMoneyLabel.bottom + ScaleW(5), self.numberView.width, ScaleW(40))];
        NSString *title = SSKJLocalized(@"买入",nil);
        [_buySellButton setTitle:title forState:UIControlStateNormal];
        [_buySellButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _buySellButton.titleLabel.font = systemFont(ScaleW(12));
        _buySellButton.layer.cornerRadius = 4.0f;;
        _buySellButton.backgroundColor = GREEN_HEX_COLOR;
        [_buySellButton addTarget:self action:@selector(confirmBuy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buySellButton;
}

-(LXY_DeepView *)deepView
{
    if (nil == _deepView) {
        _deepView = [[LXY_DeepView alloc]initWithFrame:CGRectMake(self.buySellButton.x, self.buySellButton.bottom + ScaleW(5), self.buySellButton.width, ScaleW(157))];
    }
    return _deepView;
}

-(BuySell5_View *)buySell5View
{
    if (nil == _buySell5View) {
        _buySell5View = [[BuySell5_View alloc]initWithFrame:CGRectMake(self.numberView.right + ScaleW(18), ScaleW(20), self.width - self.numberView.right - ScaleW(18), self.deepView.bottom - self.buySellSelectView.y)];
    }
    return _buySell5View;
}

#pragma mark - 用户操作
#pragma mark 更换市价、限价

-(void)selectPriceType
{
    WS(weakSelf);
    __block NSArray *array = @[SSKJLocalized(@"市价", nil),SSKJLocalized(@"限价", nil)];
    self.priceTypeButton.selected = YES;
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = array[selectIndex];
        [weakSelf.priceTypeButton setTitle:title forState:UIControlStateNormal];
        weakSelf.priceTypeButton.selected = NO;
        if (selectIndex == 0) {
            weakSelf.priceType = PriceTypeMarket;
        }else{
            weakSelf.priceType = PriceTypeLimite;
        }
        weakSelf.priceView.priceType = weakSelf.priceType;
        
        NSString *coinName = weakSelf.coinModel.name;
        
        NSArray *array = [coinName componentsSeparatedByString:@"/"];
        
        if (weakSelf.priceType == PriceTypeMarket) {
            weakSelf.numberView.unitLabel.text = array.lastObject;
            weakSelf.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:weakSelf.balanceModel.right_code.doubleValue afterPointNumber:6],array.lastObject];

        }else{
            weakSelf.numberView.unitLabel.text = array.firstObject;
            weakSelf.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:weakSelf.balanceModel.left_code.doubleValue afterPointNumber:6],array.firstObject];
            weakSelf.priceView.price = [WLTools noroundingStringWith:weakSelf.coinModel.price.doubleValue afterPointNumber:6];
        }
        
    } cancleBlock:^{
        weakSelf.priceTypeButton.selected = NO;

    }];
}

-(void)setPriceType:(PriceType)priceType
{
    _priceType = priceType;
    self.priceView.priceType = priceType;
    if (priceType == PriceTypeMarket) {
        [self.priceTypeButton setTitle:SSKJLocalized(@"市价交易",nil) forState:UIControlStateNormal];
        self.priceTypeButton.selected = NO;
    }else{
        [self.priceTypeButton setTitle:SSKJLocalized(@"限价交易",nil) forState:UIControlStateNormal];
        self.priceTypeButton.selected = NO;
    }
    
    CGFloat width = [WLTools getWidthWithText:[self.priceTypeButton titleForState:UIControlStateNormal] font:_priceTypeButton.titleLabel.font];
    _priceTypeButton.width = width + ScaleW(15);
    [_priceTypeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _priceTypeButton.imageView.image.size.width - ScaleW(4), 0, _priceTypeButton.imageView.image.size.width + ScaleW(4))];
    [_priceTypeButton setImageEdgeInsets:UIEdgeInsetsMake(0, _priceTypeButton.titleLabel.bounds.size.width, 0, -_priceTypeButton.titleLabel.bounds.size.width)];
}

-(void)confirmBuy
{
    
    if (self.numberView.numberTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入数量", nil)];
        return;
    }else if (self.numberView.numberTextField.text.doubleValue == 0){
        [MBProgressHUD showError:SSKJLocalized(@"数量不能为0", nil)];
        return;
    }
    
    if (self.confirmBuyBlock) {

        self.confirmBuyBlock(self.numberView.numberTextField.text,self.buySellType,self.priceType,self.priceView.price);
    }
}


-(void)setCoinModel:(JB_Market_Index_Model *)coinModel
{
    _coinModel = coinModel;
    
    NSString *coinName = coinModel.name;
    
    NSArray *array = [coinName componentsSeparatedByString:@"/"];
    
    if (self.priceType == PriceTypeMarket) {
        self.numberView.unitLabel.text = array.lastObject;
    }else{
        self.numberView.unitLabel.text = array.firstObject;
        self.priceView.price = [WLTools noroundingStringWith:coinModel.price.doubleValue afterPointNumber:6];
    }
}

-(void)setViewWithBalanceModel:(JB_BBTrade_BalanceModel *)balanceModel
{
    self.balanceModel = balanceModel;
    NSString *coinName = self.coinModel.name;
    
    NSArray *array = [coinName componentsSeparatedByString:@"/"];
    
    if (self.priceType == PriceTypeMarket) {
        
        self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:balanceModel.right_code.doubleValue afterPointNumber:6],array.lastObject];
    }else{
        self.canuseLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:balanceModel.left_code.doubleValue afterPointNumber:6],array.firstObject];
        
    }
}


-(void)setDeepData:(NSDictionary *)deepData
{
    [self.deepView setData:deepData];
}

-(void)setPankouData:(ETF_Contract_Depth_Model *)Model
{
    [self.buySell5View setViewWithModel:Model];
}

-(void)setMarketData:(JB_Market_Index_Model *)Model
{
    [self.buySell5View setPriceModel:Model];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
