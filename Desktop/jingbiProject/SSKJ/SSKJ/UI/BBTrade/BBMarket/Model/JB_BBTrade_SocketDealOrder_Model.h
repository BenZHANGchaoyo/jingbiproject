//
//  JB_BBTrade_SocketDealOrder_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_SocketDealOrder_Model : UIView
@property (nonatomic, copy) NSString *amount;       // 成交量
@property (nonatomic, copy) NSString *dc;           // 买卖
@property (nonatomic, copy) NSString *dt;           // 时间
@property (nonatomic, copy) NSString *price;        // 价格

@end

NS_ASSUME_NONNULL_END
