//
//  LGTokenListener.h
//  身份验证Lib
//
//  Created by b233 on 15/12/2.
//  Copyright (c) 2015年 LGCloudPlatform. All rights reserved.
//

#import <Foundation/Foundation.h>
// 创建一个协议，用于监听token是否有效
@protocol LGTokenListenerDelegate <NSObject>
@optional
- (void)tokenDidInvalid;

@end

@interface LGTokenListener : NSObject

@property(nonatomic, weak) id<LGTokenListenerDelegate>delegate;
// return an instance
+ (LGTokenListener *)shareTokenListener;

- (void)start;
- (void)cancel;

@end
