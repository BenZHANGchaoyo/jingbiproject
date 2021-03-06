//
//  CommonDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


//写
#define SSKJUserDefaultsSET(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

// 取
#define SSKJUserDefaultsGET(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

// 删
#define SSKJUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

// 存
#define SSKJUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

// 交易类型  normal正常交易，scratch抢筹交易
typedef NS_ENUM(NSInteger,sellAndBuyStyle){
    //normal
    sellAndBuyStyleNomal,
    //抢筹
    sellAndBuyStyleScratch=1,
    // 全币交易
    sellAndBuyStyleQBTrade
};

// 历史记录类型, 充值记录和提币记录
typedef NS_ENUM(NSInteger, RecordType) {
    RecordTypeChongZhi,
    RecordTypeTiBi,
};


#define KSocketLongNofication     @"KSocketLongNofication"

