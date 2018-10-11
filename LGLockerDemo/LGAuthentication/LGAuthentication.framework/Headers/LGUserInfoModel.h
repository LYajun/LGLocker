//
//  LGUserInfoModel.h
//  身份验证Lib
//
//  Created by b233 on 15/12/5.
//  Copyright © 2015年 LGCloudPlatform. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGUserInfoModel : NSObject
// 获取回来用户数据信息变量
@property (nonatomic, assign, readonly) NSUInteger UserType;
@property (nonatomic, copy, readonly) NSString *GroupName;
@property (nonatomic, copy, readonly) NSString *UpdateTime;
@property (nonatomic, copy, readonly) NSString *PreLoginIP;
@property (nonatomic, copy, readonly) NSString *Sign;
@property (nonatomic, copy, readonly) NSString *UserName;
@property (nonatomic, copy, readonly) NSString *GroupID;
@property (nonatomic, copy, readonly) NSString *GradeID;
@property (nonatomic, copy, readonly) NSString *ShortName;
@property (nonatomic, copy, readonly) NSString *PhotoPath;
@property (nonatomic, copy, readonly) NSString *SchoolID;
@property (nonatomic, copy, readonly) NSString *Gender;
@property (nonatomic, copy, readonly) NSString *PreLoginTime;
@property (nonatomic, copy, readonly) NSString *GradeName;
@property (nonatomic, copy, readonly) NSString *UserID;
@property (nonatomic, assign, readonly) NSUInteger  UserClass;


@property (nonatomic, copy ,readonly) NSString *SubjectIDs;
@property (nonatomic, copy ,readonly) NSString *SubjectNames;
/* 统一的年级标志 */
@property (nonatomic, copy ,readonly) NSString *GlobalGrade;

/* 登录成功后的令牌 */
@property (nonatomic, copy ,readonly) NSString *Token;
/* 登录来源信息 */
@property (nonatomic, copy ,readonly) NSString *LoginInfo;

@property (nonatomic, copy, readonly) NSString *SchoolName;
@property (nonatomic, strong, readonly) NSString *StudyLevel;

/* 点控状态 */
@property (nonatomic, copy ,readonly) NSString *LockerState;

@property (nonatomic, copy) NSDictionary *storeUserInfoDic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)storeUserInfoInCheyChain;
- (NSDictionary *) readUserInfoFromCheyChain;
@end
