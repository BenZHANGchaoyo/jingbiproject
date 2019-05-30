//
//  WL_LoginUser_Tool.h
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "WL_Network_Model.h"

#import "SSKJ_Login_Model.h"

#import "SSKJ_UserInfo_Model.h"



@interface SSKJ_User_Tool : NSObject

@property (nonatomic, strong) SSKJ_UserInfo_Model *userInfoModel;

//  清除本地保存的用户信息
+(void)clearUserInfo;

// 单例
+(SSKJ_User_Tool *)sharedUserTool;


// 保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;

// 保存用户信息
-(void)saveUserInfoWithUserInfoModel:(SSKJ_UserInfo_Model *)userInfoModel;


-(NSString *)getMobile; // 用户手机号

-(NSString *)getToken;  // 用户token

-(NSString *)getAccount;  // 用户acount

-(NSString *)getUID;        // 用户id



@end

















