//
//  JB_BBTrade_OrderList_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_OrderList_Cell.h"

@interface JB_BBTrade_OrderList_Cell ()
@property (nonatomic, strong) UILabel *buySellTypeLabel;
@property (nonatomic, strong) UILabel *coinNameLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *entrustTimeTitleLabel;           // 委托时间
@property (nonatomic, strong) UILabel *entrustTimeLabel;           // 委托时间

@property (nonatomic, strong) UILabel *entrustPriceTitleLabel;   // 委托价格
@property (nonatomic, strong) UILabel *entrustPriceLabel;   // 委托价格

@property (nonatomic, strong) UILabel *entrustAmountTitleLabel;  // 委托量
@property (nonatomic, strong) UILabel *entrustAmountLabel;  // 委托量

@property (nonatomic, strong) UILabel *dealTotalPriceTitleLabel;// 成交总额
@property (nonatomic, strong) UILabel *dealTotalPriceLabel;// 成交总额

@property (nonatomic, strong) UILabel *dealPriceTitleLabel;      // 成交均价
@property (nonatomic, strong) UILabel *dealPriceLabel;      // 成交均价

@property (nonatomic, strong) UILabel *dealAmountTitleLabel; // 成交量
@property (nonatomic, strong) UILabel *dealAmountLabel; // 成交量

@property (nonatomic, strong) UILabel *dealTimeTitleLabel; // 成交时间
@property (nonatomic, strong) UILabel *dealTimeLabel; // 成交时间

@property (nonatomic, strong) UILabel *sxFeeTitleLabel; // 手续费
@property (nonatomic, strong) UILabel *sxFeeLabel; // 手续费


@end

@implementation JB_BBTrade_OrderList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.buySellTypeLabel];
        [self addSubview:self.coinNameLabel];
        [self addSubview:self.statusLabel];
        
        
        [self addLabels];
    }
    return self;
}

- (UILabel *)buySellTypeLabel
{
    if (nil == _buySellTypeLabel) {
        _buySellTypeLabel = [WLTools allocLabel:SSKJLocalized(@"买入", nil) font:systemFont(ScaleW(14)) textColor:RED_HEX_COLOR frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(30), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _buySellTypeLabel;
}

- (UILabel *)coinNameLabel
{
    if (nil == _coinNameLabel) {
        _coinNameLabel = [WLTools allocLabel:@"BTC/USDT" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(self.buySellTypeLabel.right + ScaleW(17), self.buySellTypeLabel.y, ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _coinNameLabel;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"已成交" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(100), 0, ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentRight];
        _statusLabel.centerY = self.coinNameLabel.centerY;
    }
    return _statusLabel;
}

-(void)addLabels
{
    
    NSArray *titleArray = @[
                            SSKJLocalized(@"委托时间", nil),
                            SSKJLocalized(@"委托价(USDT)", nil),
                            SSKJLocalized(@"委托量(ETH)", nil),
                            SSKJLocalized(@"成交总额(ETH)", nil),
                            SSKJLocalized(@"成交均价(ETH)", nil),
                            SSKJLocalized(@"成交量(ETH)", nil),
                            SSKJLocalized(@"成交时间", nil),
                            SSKJLocalized(@"手续费(USDT)", nil),
                            ];
    
    CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
    
    for (int i = 0; i < titleArray.count; i++) {
        NSInteger line = i % 3;
        NSInteger row = i / 3;
        NSString *title = titleArray[i];
        
        NSTextAlignment aligment = NSTextAlignmentLeft;
        if (line == 0) {
            aligment = NSTextAlignmentLeft;
        }else if (line == 2){
            aligment = NSTextAlignmentRight;
        }
        
        
        UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13.5)) textColor:UIColorFromRGB(0x8591ac) frame:CGRectMake(ScaleW(15) + line * width, self.buySellTypeLabel.bottom + ScaleW(20) + row * ScaleW(55), width, ScaleW(13.5)) textAlignment:aligment];
        
        [self addSubview:titleLabel];
        
        UILabel *valueLabel = [WLTools allocLabel:@"xx" font:systemBoldFont(ScaleW(13.5)) textColor:kMainWihteColor frame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(12), width, ScaleW(13.5)) textAlignment:aligment];
        
        [self addSubview:valueLabel];
        
        switch (i) {
            case 0:
                {
                    self.entrustTimeTitleLabel = titleLabel;
                    self.entrustTimeLabel = valueLabel;
                }
                break;
            case 1:
            {
                self.entrustPriceTitleLabel = titleLabel;
                self.entrustPriceLabel = valueLabel;
            }
                break;
            case 2:
            {
                self.entrustAmountTitleLabel = titleLabel;
                self.entrustAmountLabel = valueLabel;
            }
                break;
            case 3:
            {
                self.dealTotalPriceTitleLabel = titleLabel;
                self.dealTotalPriceLabel = valueLabel;
            }
                break;
            case 4:
            {
                self.dealPriceTitleLabel = titleLabel;
                self.dealPriceLabel = valueLabel;
            }
                break;
            case 5:
            {
                self.dealAmountTitleLabel = titleLabel;
                self.dealAmountLabel = valueLabel;
            }
                break;
            case 6:
            {
                self.dealTimeTitleLabel = titleLabel;
                self.dealTimeLabel = valueLabel;
            }
                break;
            case 7:
            {
                self.sxFeeTitleLabel = titleLabel;
                self.sxFeeLabel = valueLabel;
            }
                break;
                
            default:
                break;
        }
    }
    
}

-(void)setCellWithModel:(JB_BBTrade_Order_Index_Model *)model
{
    NSString *type;
    UIColor *color;
    if (model.type.integerValue == 1 ) {
        type = SSKJLocalized(@"买入", nil);
        color = GREEN_HEX_COLOR;
    }else{
        type = SSKJLocalized(@"卖出", nil);
        color = RED_HEX_COLOR;
    }
    
    self.buySellTypeLabel.textColor = color;
    self.buySellTypeLabel.layer.borderColor = color.CGColor;
    self.buySellTypeLabel.text = type;
    
    self.coinNameLabel.text = model.pname;
    NSString *statusString;
    NSInteger status = model.status.integerValue;
    switch (status) {
        case 0:
            statusString = SSKJLocalized(@"委托中", nil);
            break;
        case 1:
            statusString = SSKJLocalized(@"交易中", nil);
            break;
        case 2:
            statusString = SSKJLocalized(@"已成交", nil);
            break;
        case -1:
            statusString = SSKJLocalized(@"已撤销", nil);
            break;
            
        default:
            break;
    }
    self.statusLabel.text = statusString;
    
    self.entrustTimeLabel.text = [WLTools convertTimestamp:model.add_time.doubleValue andFormat:@"MM-dd HH:mm:ss"];
    
    NSArray *array = [model.pname componentsSeparatedByString:@"/"];
    
    NSInteger priceType = model.otype.integerValue;
    
    self.entrustPriceTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托价", nil),array.lastObject];
    
    self.entrustAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"委托量", nil),array.firstObject];

    if (priceType == 1) {       // 限价价
        self.entrustPriceLabel.text = [WLTools noroundingStringWith:model.wtprice.doubleValue afterPointNumber:4];
        self.entrustAmountLabel.text = [WLTools noroundingStringWith:model.wtnum.doubleValue afterPointNumber:4];

    }else{                  // 市价
        
        self.entrustPriceLabel.text = SSKJLocalized(@"市价", nil);
        self.entrustAmountLabel.text = @"--";

    }
    
    self.dealTotalPriceTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交总额", nil),array.lastObject];
    self.dealTotalPriceLabel.text = [WLTools noroundingStringWith:model.totalprice.doubleValue afterPointNumber:4];
    
    self.dealPriceTitleLabel.text =  [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交均价", nil),array.lastObject];
    self.dealPriceLabel.text = [WLTools noroundingStringWith:model.cjprice.doubleValue afterPointNumber:4];
    
    self.dealAmountTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"成交量", nil),array.firstObject];
    self.dealAmountLabel.text = [WLTools noroundingStringWith:model.cjnum.doubleValue afterPointNumber:4];
    
    self.dealTimeLabel.text = [WLTools convertTimestamp:model.trade_time.doubleValue andFormat:@"MM-dd HH:mm:ss"];
    
    self.sxFeeTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"手续费", nil),array.lastObject];
    self.sxFeeLabel.text = [WLTools noroundingStringWith:model.fee.doubleValue afterPointNumber:4];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
