//
//  FBCToBuyTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCToBuyTableViewCell.h"
@interface FBCToBuyTableViewCell()
@property (nonatomic, strong) NSMutableArray *imagPayWaysArray;
@end

@implementation FBCToBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.backView setCornerRadius:10.f];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)gotoBuyAction:(id)sender {
    
}

-(void)setPayWaysArray:(NSArray *)payWaysArray
{
    for (UIImageView *v in self.imagPayWaysArray) {
        [v removeFromSuperview];
    }
    _payWaysArray = payWaysArray;
    
    for (int i = 0; i < _payWaysArray.count; i ++) {
        UIImageView * imagView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(281) + i *27, 28, 15, 15)];
        imagView.image = [UIImage imageNamed:_payWaysArray[i]];
        imagView.right = ScreenWidth - 31 - i *27;
        [self.imagPayWaysArray addObject:imagView];
        [self.contentView addSubview:imagView];
    }
}
@end
