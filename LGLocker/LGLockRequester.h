//
//  LGLockerRequester.h
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGLockRequester : NSObject
+ (LGLockRequester *)shareInstance;
- (void)get:(NSString *)urlStr success:(void(^)(id response))success failure:(void (^)(NSError * error))failure;
@end
