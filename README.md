# LGLocker
锁控控制

## 集成:

```
pod 'LGLocker'
```

## 使用

1、检测当前点控是否可用

应用场景：
	登录成功后调用,并且只有当检测当前点控有结果时才可进入主界面
	
```objective-c
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
```
2、开启定时维持当前点控

应用场景：
	检测点控有效之后调用
	
```objective-c
- (void)enterRoot{
    [[LGLocker shareInstance] startTimerRefreshLockPoint];
 // 进入主界面
     self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
}

```

3、解除当前点控

应用场景：
	登出时调用，并关闭定时维持点控功能
	
```objective-c
- (void)logout{
    [[LGLocker shareInstance] freeLockPointWithWithSysID:@“510” Completion:nil];
    [[LGLocker shareInstance] stopTimerRefreshLockPoint];
    Authentication *auth = [[Authentication alloc]init];
    [auth logOut];
    [self login];
}
```

4、显示点控无效视图

应用场景：
	当点控超限时，禁止系统被使用
	
```objective-c
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LGLocker shareInstance] showLockViewOnView:self.view sysID:@"510"];
}
```