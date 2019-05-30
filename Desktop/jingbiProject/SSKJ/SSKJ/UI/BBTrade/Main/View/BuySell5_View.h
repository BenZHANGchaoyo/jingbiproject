//
//  BuySell5_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETF_Contract_Depth_Model.h"
#import "JB_Market_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuySell5_View : UIView
-(void)setViewWithModel:(ETF_Contract_Depth_Model *)model;

-(void)setPriceModel:(JB_Market_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
