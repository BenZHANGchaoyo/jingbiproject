//
//  ETF_BBTrade_TableHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "ETF_BBTrade_TableHeaderView.h"

@interface ETF_BBTrade_TableHeaderView ()
@property (nonatomic, strong) UILabel *currentPricelabel;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UILabel *CNYLabel;
@property (nonatomic, strong) UILabel *highTitleLabel;
@property (nonatomic, strong) UILabel *highLabel;
@property (nonatomic, strong) UILabel *lowTitleLabel;
@property (nonatomic, strong) UILabel *lowLabel;

@end

@implementation ETF_BBTrade_TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBackgroundColor;
        [self addSubview:self.currentPricelabel];
        [self addSubview:self.rateLabel];
        [self addSubview:self.CNYLabel];
        [self addSubview:self.highLabel];
        [self addSubview:self.highTitleLabel];
        [self addSubview:self.lowLabel];
        [self addSubview:self.lowTitleLabel];
    }
    return self;
}

-(UILabel *)currentPricelabel
{
    if (nil == _currentPricelabel) {
        _currentPricelabel = [WLTools allocLabel:@"0000.0000" font:systemBoldFont(17) textColor:GREEN_HEX_COLOR frame:CGRectMake(ScaleW(15), ScaleW(18), ScaleW(130), ScaleW(17)) textAlignment:NSTextAlignmentLeft];
        _currentPricelabel.adjustsFontSizeToFitWidth = YES;

    }
    return _currentPricelabel;
}

-(UILabel *)rateLabel
{
    if (nil == _rateLabel) {
        _rateLabel = [WLTools allocLabel:@"+0.00%" font:systemFont(ScaleW(11)) textColor:self.currentPricelabel.textColor frame:CGRectMake(self.currentPricelabel.x, self.currentPricelabel.bottom + ScaleW(15), ScaleW(50), ScaleW(11)) textAlignment:NSTextAlignmentLeft];
        _rateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rateLabel;
}

- (UILabel *)CNYLabel
{
    if (nil == _CNYLabel) {
        _CNYLabel = [WLTools allocLabel:@"≈00000.00CNY" font:systemFont(ScaleW(11)) textColor:kTextLightBlueColor frame:CGRectMake(self.rateLabel.right+ ScaleW(10), self.rateLabel.y, ScaleW(100), ScaleW(11)) textAlignment:NSTextAlignmentLeft];
    }
    return _CNYLabel;
}

- (UILabel *)highLabel
{
    if (nil == _highLabel) {
        _highLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(10)) textColor:kTextLightBlueColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(70), 0, ScaleW(70), ScaleW(10)) textAlignment:NSTextAlignmentRight];
        _highLabel.centerY = self.currentPricelabel.centerY;
    }
    return _highLabel;
}

-(UILabel *)highTitleLabel
{
    if (nil == _highTitleLabel) {
        _highTitleLabel = [WLTools allocLabel:SSKJLocalized(@"高",nil)  font:systemFont(ScaleW(12)) textColor:kTextLightBlueColor frame:CGRectMake(self.highLabel.x - ScaleW(10) - ScaleW(50), 0, ScaleW(50), ScaleW(12)) textAlignment:NSTextAlignmentRight];
        _highTitleLabel.centerY = self.highLabel.centerY;
    }
    return _highTitleLabel;
}

- (UILabel *)lowLabel
{
    if (nil == _lowLabel) {
        _lowLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(10)) textColor:kTextLightBlueColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(70), 0, ScaleW(70), ScaleW(10)) textAlignment:NSTextAlignmentRight];
        _lowLabel.centerY = self.rateLabel.centerY;
    }
    return _lowLabel;
}

-(UILabel *)lowTitleLabel
{
    if (nil == _lowTitleLabel) {
        _lowTitleLabel = [WLTools allocLabel:SSKJLocalized(@"低",nil) font:systemFont(ScaleW(12)) textColor:kTextLightBlueColor frame:CGRectMake(self.highLabel.x - ScaleW(10) - ScaleW(50), 0, ScaleW(50), ScaleW(12)) textAlignment:NSTextAlignmentRight];
        _lowTitleLabel.centerY = self.lowLabel.centerY;
    }
    return _lowTitleLabel;
}


-(void)setCoinModel:(JB_Market_Index_Model *)coinModel
{
    if (coinModel == nil) {
        return;
    }
    self.currentPricelabel.text = [WLTools noroundingStringWith:coinModel.price.doubleValue afterPointNumber:4];
    
    if (![coinModel.changeRate hasPrefix:@"-"]) {
        
        self.rateLabel.text = [@"+" stringByAppendingString:coinModel.changeRate];
        
    }else{
        self.rateLabel.text = [NSString stringWithFormat:@"%@",coinModel.changeRate];
    }
    
    UIColor *color;
    if (coinModel.change.doubleValue < 0) {
        color = RED_HEX_COLOR;
    }else{
        color = GREEN_HEX_COLOR;
    }
    self.rateLabel.textColor = color;
    self.currentPricelabel.textColor = color;
    
    self.CNYLabel.text = [NSString stringWithFormat:@"≈%@CNY",[WLTools noroundingStringWith:coinModel.cnyPrice.doubleValue afterPointNumber:2]];
    self.highLabel.text = [WLTools noroundingStringWith:coinModel.high.doubleValue afterPointNumber:4];
    
    self.lowLabel.text = [WLTools noroundingStringWith:coinModel.low.doubleValue afterPointNumber:4];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
