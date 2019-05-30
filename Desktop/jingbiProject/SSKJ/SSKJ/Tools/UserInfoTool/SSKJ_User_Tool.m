//
//  WL_LoginUser_Tool.m
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "SSKJ_User_Tool.h"

@interface SSKJ_User_Tool()

@end

@implementation SSKJ_User_Tool

+(void)clearUserInfo
{
//    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    SSKJUserDefaultsSET(@"", @"token");
    SSKJUserDefaultsSET(@"", @"account");
    SSKJUserDefaultsSET(@"", @"mobile");
    SSKJUserDefaultsSET(@"", @"uid");
    SSKJUserDefaultsSET(@"0", @"kLogin");

}

+(SSKJ_User_Tool *)sharedUserTool
{
    
    static SSKJ_User_Tool *sharedSVC=nil;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
        ^{
            
            sharedSVC = [[self alloc] init];
        });
  
    return sharedSVC;
}

#pragma mark -保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
    if (![loginModel.mobile isEqual:[NSNull null]]){
        [settings setObject:loginModel.mobile forKey:@"mobile"];
    }
    
    if (![loginModel.token isEqual:[NSNull null]]){
        [settings setObject:loginModel.token forKey:@"token"];
    }
    
    if (![loginModel.account isEqual:[NSNull null]]) {
        [settings setObject:loginModel.account forKey:@"account"];
    }
    
    if (![loginModel.uid isEqual:[NSNull null]]) {
        [settings setObject:loginModel.uid forKey:@"uid"];
    }
    
    
    
    [settings setObject:@"1" forKey:@"kLogin"];
    
}

// 保存用户信息
-(void)saveUserInfoWithUserInfoModel:(SSKJ_UserInfo_Model *)userInfoModel
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
//    if (![userInfoModel.uid isEqual:[NSNull null]]){
//        [settings setObject:userInfoModel.uid forKey:@"uid"];
//    }
    
    
    
}

#pragma mark - 获取手机号
-(NSString *)getMobile
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"mobile"];
    
}

#pragma mark - 获取token
-(NSString *)getToken
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"token"];
}


#pragma mark - 获取用户account
-(NSString *)getAccount
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"account"];
    
}

#pragma mark - 获取用户id
-(NSString *)getUID
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"uid"];
    
}


@end




























