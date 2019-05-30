//
//  BBTrade_PriceView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BBTrade_PriceView.h"

@interface BBTrade_PriceView ()
@property (nonatomic, strong) UITextField *priceTextField;
@property (nonatomic, strong) UILabel *currentPriceLabel;
@property (nonatomic, strong) UIButton *addButton;                  // 加按钮
@property (nonatomic, strong) UIButton *minusButton;                // 减按钮
@end

@implementation BBTrade_PriceView
@synthesize price = _price;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addButton];
        [self addSubview:self.minusButton];
        [self addSubview:self.priceTextField];
        [self addSubview:self.currentPriceLabel];
        self.priceType = PriceTypeMarket;
        self.layer.borderColor = kTextLightBlueColor.CGColor;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = kSubBackgroundColor;
    }
    return self;
}


-(UIButton *)addButton
{
    if (nil == _addButton) {
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(30), 0, ScaleW(30), self.height)];
        [_addButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        _addButton.backgroundColor = kSubBackgroundColor;
        [_addButton addTarget:self action:@selector(addPrice) forControlEvents:UIControlEventTouchUpInside];
        _addButton.hidden = YES;
    }
    return _addButton;
}

-(UIButton *)minusButton
{
    if (nil == _minusButton) {
        _minusButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addButton.x - ScaleW(30), 0, ScaleW(30), self.height)];
        [_minusButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        _minusButton.backgroundColor = kSubBackgroundColor;
        [_minusButton addTarget:self action:@selector(reducePrice) forControlEvents:UIControlEventTouchUpInside];
        _minusButton.hidden = YES;

    }
    return _minusButton;
}

-(UITextField *)priceTextField
{
    if (nil == _priceTextField) {
        _priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(5), 0, self.minusButton.x - ScaleW(5), self.height)];
//        _priceTextField.backgroundColor = kSubBackgroundColor;
        _priceTextField.font = systemFont(ScaleW(14));
        _priceTextField.textColor = kMainWihteColor;
        _priceTextField.placeholder = SSKJLocalized(@"请输入价格",nil);
        [_priceTextField setValue:kTextDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTextField.hidden = YES;
    }
    return _priceTextField;
}

-(UILabel *)currentPriceLabel
{
    if (nil == _currentPriceLabel) {
        _currentPriceLabel = [WLTools allocLabel:SSKJLocalized(@"以当前最优交易价格",nil) font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(5), 0, self.width - ScaleW(5), self.height) textAlignment:NSTextAlignmentLeft];
        _currentPriceLabel.backgroundColor = [UIColor clearColor];
    }
    return _currentPriceLabel;
}

-(void)setPriceType:(PriceType)priceType
{
    _priceType = priceType;
    if (_priceType == PriceTypeMarket) {
        self.currentPriceLabel.hidden = NO;
        self.addButton.hidden = YES;
        self.minusButton.hidden = YES;
        self.priceTextField.hidden = YES;
    }else{
        self.currentPriceLabel.hidden = YES;
        self.addButton.hidden = NO;
        self.minusButton.hidden = NO;
        self.priceTextField.hidden = NO;
    }
}

-(void)addPrice
{
    double price = self.priceTextField.text.doubleValue + 1;
    self.priceTextField.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:price afterPointNumber:4]];
}

-(void)reducePrice
{
    double price = self.priceTextField.text.doubleValue - 1;
    if (price < 0) {
        price = 0;
    }
    self.priceTextField.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:price afterPointNumber:4]];
}

-(NSString *)price
{
    return self.priceTextField.text;
}

-(void)setPrice:(NSString *)price
{
    self.priceTextField.text = price;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
