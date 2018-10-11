//
//  ViewController.m
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "ViewController.h"
#import <LGAuthentication/LGAuthentication.h>
#import "LGLocker.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LGLocker shareInstance] showLockViewOnView:self.view sysID:@"510"];
}
- (IBAction)logout:(id)sender {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] logout];
}



@end
