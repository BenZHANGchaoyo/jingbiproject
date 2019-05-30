//
//  HomepageHeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_Market_Index_Model.h"
#import "JB_Main_BannerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomepageHeaderView : UIView

@property (nonatomic, copy) void (^coinTapBlock)(JB_Market_Index_Model *coinModel);
@property (nonatomic, strong) NSArray *bannerArray;
@property (nonatomic, strong) NSArray *noticeArray;

@property (nonatomic, strong) NSArray<JB_Market_Index_Model *> *coinArray;

-(void)didGetSocketModel:(JB_Market_Index_Model *)socketModel;

@end

NS_ASSUME_NONNULL_END
