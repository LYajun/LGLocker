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

/** 检测当前点控是否可用 */
- (void)setNewLockPointWithDomain:(NSString *)domain sysID:(NSString *)sysID pointID:(NSString *)pointID completion:(void (^)(NSError *error))completion;

/** 维持当前点控 */
- (void)refreshLockPointWithSysID:(NSString *)sysID Completion:(void (^)(NSError *error))completion;

/** 释放当前点控 */
- (void)freeLockPointWithWithSysID:(NSString *)sysID Completion:(void (^)(NSError *error))completion;

/** 获取锁控信息 */
- (LGLockModel *)lockInfoWithSysID:(NSString *)sysID;

/** 点控是否有效 */
- (BOOL)pointValidityWithSysID:(NSString *)sysID;

- (void)showLockViewOnView:(UIView *) superView  sysID:(NSString *)sysID;
- (void)removeLockView;

/** 开启定时维持点控 */
- (void)startTimerRefreshLockPoint;

/** 关闭定时维持点控 */
- (void)stopTimerRefreshLockPoint;
@end
