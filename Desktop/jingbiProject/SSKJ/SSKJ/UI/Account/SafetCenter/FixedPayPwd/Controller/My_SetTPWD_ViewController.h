//
//  My_SetTPWD_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface My_SetTPWD_ViewController : SSKJ_BaseViewController


@property (nonatomic, copy) void (^statusBlock)(void);
@property (nonatomic, copy) NSString *phoneNumber;
@end

NS_ASSUME_NONNULL_END
