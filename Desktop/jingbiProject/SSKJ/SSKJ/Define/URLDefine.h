//
//  UrlDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//


#define SUCCESSED 200

#define ENVIRONMENT 1 //  0－开发/1－正式

#if ENVIRONMENT == 0
/* ************************  开发服务器接口地址  *********************************** */
//192.168.1.222:8080
#define ProductBaseServer  @"http://113.52.135.113"// @"http://47.75.240.138:8080" //  @"http://192.168.1.222:8080"  //http://47.92.147.107



#define BBMarketSocketUrl @"ws://113.52.135.113:7272"   // 行情推送

#define BBDeepthSocketUrl @"ws://113.52.135.113:7274"   // 深度推送

#define BBPankouSocketUrl @"ws://113.52.135.113:7273"   // 盘口推送

#define BBDealRecordSocketUrl @"ws://113.52.135.113:7275"   // 实时成交推送

/*******************************************************************************************/

#elif ENVIRONMENT ==1

/* ************************  发布正式服务器接口地址  *********************************** */


#define ProductBaseServer    @"http://113.52.135.113"

#define BBMarketSocketUrl @"ws://113.52.135.113:7272"   // 行情推送

#define BBDeepthSocketUrl @"ws://113.52.135.113:7274"   // 深度推送

#define BBPankouSocketUrl @"ws://113.52.135.113:7273"   // 盘口推送

#define BBDealRecordSocketUrl @"ws://113.52.135.113:7275"   // 实时成交推送

/*******************************************************************************************/

#endif


/************************************ 登录、注册、忘记密码、获取验证码 ****************************/

/* 用户注册 */
#define JB_Register_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/register"]

/* 发送手机验证码 */
#define JB_GetSMSCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/send_sms"]

/* 发送邮箱验证码 */
#define JB_GetEmailCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/send_email"]

/* 登录 */
#define JB_Login_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_login"]


///* 钱包隐私协议 */
//#define ETF_PRAVITYPROTOCOL_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/wallet_rule"]

/* 注册时服务协议 */
#define ETF_REGISTERPROTOCOL_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/fw_rule"]

/* 重置登录密码*/
#define ETF_ResetPWD_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/xiugai_pwd"]


/* 忘记登录密码*/
#define ETF_ForgetPWD_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/find_opwd"]


/************************************ BB交易 ****************************/


/* 币币交易市场行情*/
#define ETF_BBTrade_MarketList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getpro"]

/* 币币交易历史记录*/
#define ETF_BBTrade_OrderList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/tranlist"]

/* 币币交易下单*/
#define ETF_BBTrade_ConfirmBuy_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/bbtran"]

/* 币币交易K线图*/
#define JB_BBTrade_KLine_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Ajax/index"]

/* 币币交易K线图*/
#define ETF_BBTrade_CoinIntroduce_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/get_info"]


/* 币币交易获取币种余额*/
#define ETF_BBTrade_GetCoinBalance_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/getCodeBalance"]


/* 币币交易获取币种余额*/
#define ETF_BBTrade_CoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/get_pro"]




//法币交易大厅

#define ETF_FBHomeFbtransTrading_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/trading"]
//交易记录
#define ETF_FBHomeFbtransRecode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/get_mx"]
/* 主页获取轮播图*/
#define ETF_Main_GetBanner_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getBanner"]

/************************************ 理财 ****************************/

/* 主页获取轮播图*/
#define JB_Account_LicaiCoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/lend/lend_coin_list"]

/************************************ 我的 ****************************/

/* 个人中心*/
#define JB_Account_UserInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_info"]


