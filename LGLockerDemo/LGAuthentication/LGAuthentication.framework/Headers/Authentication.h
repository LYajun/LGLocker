//
//  Authentication.h
//  身份验证Lib
//
//  Created by b233 on 15/12/10.
//  Copyright © 2015年 LGCloudPlatform. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface Authentication : NSObject


/*
 检测当前点控是否可用（初次进入）
 
 @params:sysID:系统标识位
 @params:CheckType:(1或者2)，注：1表示UserID（按人数检测），2表示Mac地址（按设备检测）
 
 @return:1-- 点控可用；0-- 超过点数上限；-1-- 未检测到加密锁；-2-- 加密锁已过试用期；-3-- 没有购买该产品；-4-- 加密锁接口调用错误；-5-- 加密锁时钟错误；-100-- 检测错误（错误原因未知）。
 */
- (NSString *)SetNewLockPointWithSysID:(NSString *)sysID WithCheckType:(NSInteger)CheckType;
/*
 维持当前点控（定时刷新）
 @params:sysID:系统标识位
 @params:CheckType:(1或者2)，注：1表示UserID（按人数检测），2表示Mac地址（按设备检测）
 @return: 0-- 正常；1-- 参数错误；2--函数不存在；3--非法调用
 */
- (NSString *)RefreshLockPointWithSysID:(NSString *)sysID WithCheckType:(NSInteger)CheckType;
/*
 解除当前点控（退出系统）
 
 @params:sysID:系统标识位
 @params:CheckType:(1或者2)，注：1表示UserID（按人数检测），2表示Mac地址（按设备检测）
 @return: 0-- 正常；1-- 参数错误；2--函数不存在；3--非法调用
 */
- (NSString *)FreeLockPointWithSysID:(NSString *)sysID WithCheckType:(NSInteger)CheckType;




/*
 登出
 @return:1--登出成功；0-- 登出失败
 
 */
- (NSUInteger)logOut;

/*
 登录界面的加载
 @params:sysID:云平台的系统标识位
 @params:suceess:登录成功回调，跳转后的界面在这里接入
 */
- (void)loginWithSystemID:(NSUInteger)sysID success:(void(^)(void))success;


/*
 登录界面的加载 可修改登录标题
 @params:sysID:云平台的系统标识位
 @params:suceess:登录成功回调，跳转后的界面在这里接入
 */
- (void)loginWithSystemID:(NSUInteger)sysID titleName:(NSString *)title success:(void(^)(void))success;



/*
 带返回按钮登录界面的加载
 @params:sysID:云平台的系统标识位
 @params:suceess:登录成功回调，跳转后的界面在这里接入
 */

- (void)loginModelWithSystemID:(NSUInteger)sysID andCurrentController:(UIViewController *)controller success:(void(^)(void))success;


/*
 登录接口
 params:success: 成功回调
 */
- (void)loginWithSuccess:(void(^)(void))success;

/*
 重新登录
 return:0-timeOut（登录异常） 1-登录成功 2-账号不存在 3-账号密码不匹配 4-已在其他ip登录 5-服务器错误  6-没有用户数据
 */
- (NSInteger)reLogin;

/*
 获取用户状态
 params:userID:用户账号串
 return:账号｜状态标识，
 */
- (NSString *)getUserStateWithAccount:(NSString *)userID;

/*
 检测token的有效性
 return:0-token 不存在或者失效 1-用户在线 2-不可认证
 */
- (NSUInteger)getUserTokenState;



//- (void)loginWithAlertViewWithCurrentController:(UIViewController *)controller success:(void(^)(void))success  popResult:(void(^)(void))popResult;
- (void)loginWithAlertViewWithCurrentController:(UIViewController *)controller titleName:(NSString *)titleName success:(void(^)(void))success  popResult:(void(^)(void))popResult;

/**
 *  返回用户已加密的密码串
 *
 *  @return 已加密的密码串
 */
- (NSString *) userPassword;

/**
 *  返回用户账号
 *
 *  @return 用户的账号
 */
- (NSString *) userAccount;

/**
 *  http://IP:port/
 *
 *  @return http://IP:port/
 */
- (NSString *) serverUrl;

/**
 *  获取用户服务器的端口号
 *
 *  @return 用户服务器的端口号字符串
 */
- (NSString *) serverPort;

/**
 *  获取用户的服务器IP
 *
 *  @return 服务器字符串
 */
- (NSString *) serverIP;

/**
 *  获取返回的token
 *
 *  @return token的字符串
 */
- (NSString *) userToken;

/**
 *  获取用户信息
 *
 *  @return 返回装有用户数据的字典
 */
- (NSDictionary *) userInfofromCheyChain;


@end
