//
//  BFEXReChartWayTableViewCell.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEXReChartWayTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^edtingBlock)(NSDictionary *dic);
+(instancetype)getCellFromTable:(UITableView *)table indexPath:(NSIndexPath *)path;
-(void)setValueData:(id)data;
@end
