//
//  LGLocker.m
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGLocker.h"
#import "LGWeakTimer.h"
#import "LGLockView.h"

@interface LGLocker ()
@property (nonatomic, strong) LGWeakTimer *timer;
@property (nonatomic, strong) LGLockView *lockView;
@property (nonatomic, strong) dispatch_queue_t timerQueue;
@property (nonatomic, strong) NSMutableDictionary<NSString *,LGLockModel *> *lockInfo;
@end
@implementation LGLocker
+ (LGLocker *)shareInstance{
    static LGLocker * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[LGLocker alloc]init];
        [macro configure];
    });
    return macro;
}
- (void)configure{
    _timeCount = 150;
}

- (void)setNewLockPointWithDomain:(NSString *)domain sysID:(NSString *)sysID pointID:(NSString *)pointID completion:(void (^)(NSError *))completion{
    LGLockModel *lockModel = [[LGLockModel alloc] initWithDomain:domain sysID:sysID pointID:pointID];
    [self.lockInfo setObject:lockModel forKey:lockModel.sysID];
    [lockModel setNewLockPointWithCompletion:completion];
    
}
- (void)refreshLockPointWithSysID:(NSString *)sysID Completion:(void (^)(NSError *))completion{
    LGLockModel *lockModel = [self lockInfoWithSysID:sysID];
    [lockModel refreshLockPointWithCompletion:completion];
}

- (void)freeLockPointWithWithSysID:(NSString *)sysID Completion:(void (^)(NSError *))completion{
    LGLockModel *lockModel = [self lockInfoWithSysID:sysID];
    [lockModel freeLockPointWithCompletion:completion];
}

- (LGLockModel *)lockInfoWithSysID:(NSString *)sysID{
    return [self.lockInfo objectForKey:sysID];
}
- (BOOL)pointValidityWithSysID:(NSString *)sysID{
    LGLockModel *lockModel = [self lockInfoWithSysID:sysID];
    if (lockModel.errorCode.integerValue == 0 &&
        lockModel.resultCode.integerValue == 1) {
        return YES;
    }
    return NO;
}
- (void)startTimerRefreshLockPoint{
    [self.timer fire];
}

- (void)stopTimerRefreshLockPoint{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timerAction{
    NSLog(@"\n\n*****************%li秒定时维持锁控*****************\n",self.timeCount);
    for (NSString *key in self.lockInfo.allKeys) {
        LGLockModel *lockModel = [self.lockInfo objectForKey:key];
        if (lockModel.errorCode.integerValue == 0 &&
            lockModel.resultCode.integerValue == 1) {
            [lockModel refreshLockPointWithCompletion:nil];
        }
    }
}
- (void)showLockViewOnView:(UIView *)superView sysID:(NSString *)sysID{
    [self removeLockView];
    if (![self pointValidityWithSysID:@"510"]) {
        self.lockView = [LGLockView showOnView:superView];
        LGLockModel *lockModel = [self lockInfoWithSysID:sysID];
        self.lockView.errorMsg = lockModel.errorMsg;
    }
}
- (void)removeLockView{
    if (self.lockView) {
        [self.lockView removeFromSuperview];
        self.lockView = nil;
    }
}
#pragma mark getter
- (LGWeakTimer *)timer{
    if (!_timer) {
        _timer = [LGWeakTimer scheduledTimerWithTimeInterval:self.timeCount target:self selector:@selector(timerAction) userInfo:nil repeats:YES dispatchQueue:self.timerQueue];
    }
    return _timer;
}
- (dispatch_queue_t)timerQueue{
    if (!_timerQueue) {
        _timerQueue = dispatch_queue_create("com.Lancoo.LGEducationCloud.LGServerInfoManageTimerQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return _timerQueue;
}
- (NSMutableDictionary<NSString *,LGLockModel *> *)lockInfo{
    if (!_lockInfo) {
        _lockInfo = [NSMutableDictionary dictionary];
    }
    return _lockInfo;
}
@end
