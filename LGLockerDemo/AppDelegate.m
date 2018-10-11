//
//  AppDelegate.m
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "AppDelegate.h"
#import <LGAuthentication/LGAuthentication.h>
#import "LGLocker.h"

@interface AppDelegate ()
@property (assign, nonatomic) BOOL gotPreviewLockerInfo;
@property (assign, nonatomic) BOOL gotExerciseLockerInfo;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self login];
    return YES;
}
- (void)login{
    Authentication *auth = [[Authentication alloc]init];
    __weak typeof(self) weakSelf = self;
    [auth loginWithSystemID:101 titleName:@"学科教学云" success:^{
        [weakSelf setLockInfoWithCompletion:^(NSError *error) {
            if (error) {
                NSLog(@"获取锁控信息失败!");
            }else{
                [weakSelf enterRoot];
            }
        }];
    }];
}
- (void)logout{
    [[LGLocker shareInstance] freeLockPointWithWithSysID:@"510" Completion:nil];
    [[LGLocker shareInstance] freeLockPointWithWithSysID:@"630" Completion:nil];
    [[LGLocker shareInstance] stopTimerRefreshLockPoint];
    Authentication *auth = [[Authentication alloc]init];
    [auth logOut];
    [self login];
}
- (void)setLockInfoWithCompletion:(void (^)(NSError *error))completion;{
    self.gotPreviewLockerInfo = NO;
    self.gotExerciseLockerInfo = NO;
    __block BOOL errorOccured = NO;
    __weak typeof(self) weakSelf = self;
     LGUserInfoModel *cpbaseUser = [[LGUserInfoModel alloc] init];
    [[LGLocker shareInstance] setNewLockPointWithDomain:@"http://192.168.3.155:10102" sysID:@"510" pointID:cpbaseUser.UserID completion:^(NSError *error) {
        if (error) {
            if (!errorOccured) {
                errorOccured = YES;
                if (completion) {
                    completion(error);
                }
            }
        } else {
            weakSelf.gotExerciseLockerInfo = YES;
            if (weakSelf.gotAllBaseInfo) {
                if (completion) {
                    completion(nil);
                }
            }
        }
    }];
    [[LGLocker shareInstance] setNewLockPointWithDomain:@"http://192.168.3.155:10102" sysID:@"630" pointID:cpbaseUser.UserID completion:^(NSError *error) {
        if (error) {
            if (!errorOccured) {
                errorOccured = YES;
                if (completion) {
                    completion(error);
                }
            }
        } else {
            weakSelf.gotPreviewLockerInfo = YES;
            if (weakSelf.gotAllBaseInfo) {
                if (completion) {
                    completion(nil);
                }
            }
        }
    }];
}
- (void)enterRoot{
    [[LGLocker shareInstance] startTimerRefreshLockPoint];
     self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
}
- (BOOL)gotAllBaseInfo {
    return (self.gotPreviewLockerInfo &&
            self.gotExerciseLockerInfo);
}




- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
