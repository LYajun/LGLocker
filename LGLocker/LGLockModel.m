//
//  LGLockModel.m
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGLockModel.h"
#import "LGLockRequester.h"
#import "NSString+LGEncrypt.h"


static NSString *kCPSysAPI_GetBaseLockerInfo = @"/LockerMgr/API/Service_LockerMgr.ashx";
static NSString *kSetNewLockPoint = @"SetNewLockPoint";
static NSString *kRefreshLockPoint = @"RefreshLockPoint";
static NSString *kFreeLockPoint = @"FreeLockPoint";

@interface LGLockModel ()
/** 错误码 */
@property (nonatomic,copy,readwrite) NSString *errorCode;
/** 结果码 */
@property (nonatomic,copy,readwrite) NSString *resultCode;
/** 结果信息 */
@property (nonatomic,copy,readwrite) NSString *errorMsg;

/** 请求 */
@property (nonatomic,strong) LGLockRequester *req;
@end
@implementation LGLockModel


- (instancetype)initWithDomain:(NSString *)domain sysID:(NSString *)sysID pointID:(NSString *)pointID{
    if (self = [super init]) {
        _domain = domain;
        _sysID = sysID;
        _pointID = pointID;
    }
    return self;
}
- (void)setNewLockPointWithCompletion:(void (^)(NSError *))completion{
    NSString *secCode = [NSString lg_md5EncryptStr:[self.sysID stringByAppendingString:self.pointID]].lg_reverse;
    NSString *url = [self.domain stringByAppendingFormat:@"%@?method=%@&params=%@|%@&SecCode=%@",kCPSysAPI_GetBaseLockerInfo,kSetNewLockPoint,self.sysID,self.pointID,secCode];
    __weak typeof(self) weakSelf = self;
    [[LGLockRequester shareInstance] get:url success:^(id response) {
        [weakSelf setLockInfoWithResponseJson:response];
        NSError *error;
        if (weakSelf.errorCode.integerValue > 0) {
            error = [NSError errorWithDomain:@"setNewLockPointError" code:100 userInfo:@{NSLocalizedDescriptionKey:weakSelf.errorMsg}];
        }
        if (completion) {
            completion(error);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
}
- (void)setLockInfoWithResponseJson:(NSDictionary *) responseJson{
    NSLog(@"系统%@点控信息：%@",self.sysID,responseJson);
    if (!responseJson || responseJson.count == 0) {
        self.errorCode = @"2";
        self.errorMsg = @"点控函数不存在";
    }else{
        self.errorCode = [responseJson objectForKey:@"error"];
        switch (self.errorCode.integerValue) {
            case 0:
            {
                self.errorMsg = @"正常";
                NSDictionary *resultDic = [responseJson objectForKey:@"data"];
                self.resultCode = [resultDic objectForKey:@"Result"];
                switch (self.resultCode.integerValue) {
                    case 1:
                        self.errorMsg = @"点控可用";
                        break;
                    case 0:
                        self.errorMsg = @"超过点数上限";
                        break;
                    case -1:
                        self.errorMsg = @"未检测到加密锁";
                        break;
                    case -2:
                        self.errorMsg = @"加密锁已过试用期";
                        break;
                    case -3:
                        self.errorMsg = @"没有购买该产品";
                        break;
                    case -4:
                        self.errorMsg = @"加密锁接口调用错误";
                        break;
                    case -5:
                        self.errorMsg = @"加密锁时钟错误";
                        break;
                    default:
                        break;
                }
            }
                break;
            case 1:
                self.errorMsg = @"点控参数有误";
                break;
            case 2:
                self.errorMsg = @"点控函数不存在";
                break;
            case 3:
                self.errorMsg = @"点控非法调用";
                break;
            default:
                break;
        }
        
    }
}
- (void)refreshLockPointWithCompletion:(void (^)(NSError *))completion{
    NSString *secCode = [NSString lg_md5EncryptStr:[self.sysID stringByAppendingString:self.pointID]].lg_reverse;
    NSString *url = [self.domain stringByAppendingFormat:@"%@?method=%@&params=%@|%@&SecCode=%@",kCPSysAPI_GetBaseLockerInfo,kRefreshLockPoint,self.sysID,self.pointID,secCode];
    __weak typeof(self) weakSelf = self;
    [[LGLockRequester shareInstance] get:url success:^(NSDictionary *response) {
        NSError *error;
        if (response &&
            [response objectForKey:@"error"] &&
            [[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"系统%@：维持锁控成功",weakSelf.sysID);
        }else{
            NSLog(@"系统%@：维持锁控成失败",weakSelf.sysID);
            error = [NSError errorWithDomain:@"setNewLockPointError" code:101 userInfo:@{NSLocalizedDescriptionKey:@"维持锁控失败!"}];
        }
        if (completion) {
            completion(error);
        }
    } failure:^(NSError *error) {
        NSLog(@"系统%@：维持锁控成失败",weakSelf.sysID);
        if (completion) {
            completion(error);
        }
    }];
}

- (void)freeLockPointWithCompletion:(void (^)(NSError *))completion{
    NSString *secCode = [NSString lg_md5EncryptStr:[self.sysID stringByAppendingString:self.pointID]].lg_reverse;
    NSString *url = [self.domain stringByAppendingFormat:@"%@?method=%@&params=%@|%@&SecCode=%@",kCPSysAPI_GetBaseLockerInfo,kFreeLockPoint,self.sysID,self.pointID,secCode];
    __weak typeof(self) weakSelf = self;
    [[LGLockRequester shareInstance] get:url success:^(id response) {
        NSError *error;
        if (response &&
            [response objectForKey:@"error"] &&
            [[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"系统%@：释放锁控成功",weakSelf.sysID);
        }else{
            NSLog(@"系统%@：释放锁控失败",weakSelf.sysID);
            error = [NSError errorWithDomain:@"setNewLockPointError" code:102 userInfo:@{NSLocalizedDescriptionKey:@"释放锁控失败!"}];
        }
        if (completion) {
            completion(error);
        }
    } failure:^(NSError *error) {
        NSLog(@"系统%@：释放锁控失败",weakSelf.sysID);
        if (completion) {
            completion(error);
        }
    }];
}
@end
