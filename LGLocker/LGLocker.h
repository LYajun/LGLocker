//
//  LGLocker.h
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLockModel.h"
#import <UIKit/UIKit.h>

@interface LGLocker : NSObject
/** 定时数 默认150秒*/
@property (nonatomic,assign) NSInteger timeCount;

+ (LGLocker *)shareInstance;

/**
 检测当前点控是否可用

 @param domain 域名(http://ip:port)
 @param sysID 系统ID
 @param pointID 点ID
 @param completion 请求回调
 */
- (void)setNewLockPointWithDomain:(NSString *)domain sysID:(NSString *)sysID pointID:(NSString *)pointID completion:(void (^)(NSError *error))completion;

/**
 维持当前点控

 @param sysID 系统ID
 @param completion 请求回调
 */
- (void)refreshLockPointWithSysID:(NSString *)sysID Completion:(void (^)(NSError *error))completion;

/**
 释放当前点控

 @param sysID 系统ID
 @param completion 请求回调
 */
- (void)freeLockPointWithWithSysID:(NSString *)sysID Completion:(void (^)(NSError *error))completion;

/** 获取锁控信息 */
- (LGLockModel *)lockInfoWithSysID:(NSString *)sysID;

/** 点控是否有效 */
- (BOOL)pointValidityWithSysID:(NSString *)sysID;

/** 显示点控无效视图 */
- (void)showLockViewOnView:(UIView *) superView  sysID:(NSString *)sysID;

/** 移除点控无效视图 */
- (void)removeLockView;

/** 开启定时维持点控 */
- (void)startTimerRefreshLockPoint;

/** 关闭定时维持点控 */
- (void)stopTimerRefreshLockPoint;
@end
