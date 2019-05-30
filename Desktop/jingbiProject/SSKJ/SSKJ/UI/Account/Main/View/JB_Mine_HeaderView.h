//
//  ETF_Mine_HeaderView.h
//  SSKJ
//
//  Created by James on 2019/5/5.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_Mine_CellItemView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_Mine_HeaderView : UIView
@property (nonatomic, strong) JB_Mine_CellItemView *TradeItem;
@property (nonatomic, strong) JB_Mine_CellItemView *DealMoneyItem;
//- (void)configureViewWithAssetsDic:(NSDictionary *)assetsDic;
//- (void)configureUserInfoWithModel:(SSKJ_UserInfo_Model *)model;
@end

NS_ASSUME_NONNULL_END
