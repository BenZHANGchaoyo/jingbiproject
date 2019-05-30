//
//  BuySell5_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "BuySell5_Cell.h"

@interface BuySell5_Cell ()
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation BuySell5_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    CGFloat width = ScaleW(160)  / 3;
    
    for (int i = 0; i < 3; i++) {
        UILabel *label = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(width * i, 0, width, ScaleW(24)) textAlignment:NSTextAlignmentLeft];
        if (i == 0) {
            label.textAlignment = NSTextAlignmentLeft;
            self.indexLabel = label;
        }else if (i == 1){
            label.textAlignment = NSTextAlignmentCenter;
            self.priceLabel = label;
            self.priceLabel.adjustsFontSizeToFitWidth = YES;
        }else{
            label.textAlignment = NSTextAlignmentRight;
            self.numberLabel = label;
        }
        
        [self addSubview:label];
    }
}
-(void)setCellWithIndexPath:(NSIndexPath *)indexPath price:(NSString *)price number:(NSString *)number dotNumber:(NSInteger)dotNumber
{
    if (indexPath.section == 0) {
        self.indexLabel.text = [NSString stringWithFormat:@"%d",7 - indexPath.row];
        self.priceLabel.textColor = RED_HEX_COLOR;
    }else{
        self.indexLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
        self.priceLabel.textColor = GREEN_HEX_COLOR;
    }
    
    if ([price isEqualToString:@"--"]) {
        self.priceLabel.text = price;
    }else{
        
        NSString *formate = [NSString stringWithFormat:@"%%.%ldf",dotNumber];
        
        NSString *priceString = [NSString stringWithFormat:formate,[WLTools noroundingStringWith:price.doubleValue afterPointNumber:dotNumber].doubleValue];
        
        self.priceLabel.text = [NSString stringWithFormat:@"%.4f",priceString.doubleValue];
    }
    
    if ([number isEqualToString:@"--"]) {
        self.numberLabel.text = number;
    }else{
        self.numberLabel.text = [WLTools noroundingStringWith:number.doubleValue afterPointNumber:2];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
