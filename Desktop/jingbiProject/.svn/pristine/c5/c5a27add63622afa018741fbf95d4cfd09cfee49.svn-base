//
//  MarketCoinCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MarketCoinCell.h"
@interface MarketCoinCell()
@property (nonatomic, strong)UIImageView *coinImage;
@property (nonatomic, strong) UILabel *coinLable;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *percentlabel;

@property (nonatomic, strong) JB_Market_Index_Model *coinModel;

@end

@implementation MarketCoinCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    [self.contentView addSubview:self.coinImage];
    [self.contentView addSubview:self.coinLable];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.percentlabel];
    //kMianBgColor
    self.contentView.backgroundColor = self.backgroundColor = kMianBgColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(UIImageView *)coinImage
{
    if (!_coinImage) {
        _coinImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btc"]];
        _coinImage.frame = CGRectMake(ScaleW(28), ScaleW(12), ScaleW(25), ScaleW(25));
        
    }
    return _coinImage;
}
-(UILabel *)coinLable{
    if (!_coinLable) {
        _coinLable = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(9) + _coinImage.right, 0, ScaleW(100), ScaleW(14))];
        [_coinLable label:_coinLable font:ScaleW(14) textColor:kTextColorb3b7e9 text:@"BTC/USDT"];
        _coinLable.centerY = _coinImage.centerY;
        
    }
    return _coinLable;
}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(130) + _coinImage.right, 0, ScaleW(90), ScaleW(12))];
        _priceLabel.centerY = _coinImage.centerY;
        [_priceLabel label:_priceLabel font:ScaleW(12) textColor:kTextColorff5755 text:@"0000.0000"];
        
    }
    return _priceLabel;
}

-(UILabel *)percentlabel
{
    if (!_percentlabel) {
        _percentlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScaleW(100), ScaleW(12))];
        _percentlabel.centerY = _coinImage.centerY;
        _percentlabel.right = ScreenWidth - ScaleW(30);
        [_percentlabel label:_percentlabel font:ScaleW(12) textColor:kTextColorff5755 text:@"-00.00%"];
        _percentlabel.textAlignment = NSTextAlignmentRight;
    }
    return _percentlabel;
}

-(void)setCellWithModel:(JB_Market_Index_Model *)model
{
    self.coinModel = model;
    NSString *name = model.code;
    NSArray *array = [name componentsSeparatedByString:@"/"];
    
    self.coinImage.image = [UIImage imageNamed:array.firstObject];
    
//    name = [NSString stringWithFormat:@"%@ /%@",array.firstObject,array.lastObject];
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:name];
//    [attributeString addAttribute:NSFontAttributeName value:systemFont(ScaleW(11)) range:NSMakeRange(name.length - [array.lastObject length], [array.lastObject length])];
    
    self.coinLable.text = model.code;
    
    UIColor *color = GREEN_HEX_COLOR;
    if (model.change.doubleValue < 0) {
        color = RED_HEX_COLOR;
    }
    
    self.priceLabel.textColor = color;
    
    self.priceLabel.text = [WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:4];
    
    if ([model.changeRate containsString:@"-"]) {
        self.percentlabel.text = model.changeRate;
    }else{
        self.percentlabel.text = [@"+" stringByAppendingString:model.changeRate];
    }
    
    self.percentlabel.textColor = color;
}

@end
