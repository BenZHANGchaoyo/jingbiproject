//
//  SSKJ_UserInfo_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/10.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_UserInfo_Model : NSObject
@property (nonatomic, copy) NSString *account;  // account
@property (nonatomic, copy) NSString *idcard;  // 身份证号
@property (nonatomic, copy) NSString *mail;  // 邮箱
@property (nonatomic, copy) NSString *mobile;  // 手机号
@property (nonatomic, copy) NSString *realname;  // 真实姓名
@property (nonatomic, copy) NSString *status;  // 初级认证 1 未认证 2 待审核 3 已通过  4拒绝
@property (nonatomic, copy) NSString *auth_status;  //高级认证 1 未认证 2 待审核 3 已通过  4拒绝
@property (nonatomic, copy) NSString *tgno;
@property (nonatomic, copy) NSString *wallone;
@property (nonatomic, copy) NSString *tpwd;  // 是否设置支付密码
@property (nonatomic, copy) NSString *pay_list;  // 是否有添加支付方式
@property (nonatomic, copy) NSString *is_shop;  // 是否是商家
@property (nonatomic, copy) NSString *is_apply;  // 申请商家状态
@property (nonatomic, copy) NSString *apply_reason;  // 拒绝原因
@property (nonatomic, copy) NSString *usdt;  // 申请商家冻结金额
@property (nonatomic, copy) NSString *is_start_google;  // 是否开启谷歌验证 0 关 1开
@property (nonatomic, copy) NSString *register_type;  // 1手机号注册2邮箱注册

@end

NS_ASSUME_NONNULL_END

/*
"account": "3841140252",
"idcard": "410521198504108018",
"mail": null,
"mobile": "15738733951",
"realname": "原国俊",
"reg_time": null,
"status": "2",//1 未认证 2 待审核 3 已通过  4拒绝
"auth_status":"1",//高级认证 1 未认证 2 待审核 3 已通过  4拒绝
"wallone": "0.0000",
"tgno": "NEN3841140252",
"tpwd": "1",
"crowd_num": "0",
"pay_list": 0,
"is_shop": false,
"is_apply": "3",
"apply_reason": null,
"concession_rate": "0.00",
"jigou_code": null,
"tb_fee": null,
"tb_max": null,
"tb_min": null,
"usdt": "100000",
"command": 0,
"is_start_google": 0,  0 关 1开
"register_type": "1",    1手机号注册2邮箱注册
"signin": 0

*/
