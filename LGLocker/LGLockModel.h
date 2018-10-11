//
//  LGLockModel.h
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGLockModel : NSObject

/** 域名 */
@property (nonatomic,copy,readonly) NSString *domain;
/** 系统ID */
@property (nonatomic,copy,readonly) NSString *sysID;
/** 点ID */
@property (nonatomic,copy,readonly) NSString *pointID;

/** 错误码 */
@property (nonatomic,copy,readonly) NSString *errorCode;
/** 结果码 */
@property (nonatomic,copy,readonly) NSString *resultCode;
/** 结果信息 */
@property (nonatomic,copy,readonly) NSString *errorMsg;

/**
 初始化

 @param domain 域名(http://ip:port)
 @param sysID 系统ID
 @param pointID 点ID
 @return 实例对象
 */
- (instancetype)initWithDomain:(NSString *)domain sysID:(NSString *)sysID pointID:(NSString *)pointID;

/** 检测当前点控是否可用 */
- (void)setNewLockPointWithCompletion:(void (^)(NSError *error))completion;

/** 维持当前点控 */
- (void)refreshLockPointWithCompletion:(void (^)(NSError *error))completion;

/** 释放当前点控 */
- (void)freeLockPointWithCompletion:(void (^)(NSError *error))completion;
@end
