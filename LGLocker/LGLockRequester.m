//
//  LGLockerRequester.m
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGLockRequester.h"
@interface LGLockRequester ()

@end
@implementation LGLockRequester
+ (LGLockRequester *)shareInstance{
    static LGLockRequester * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[LGLockRequester alloc]init];
    });
    return macro;
}
- (void)get:(NSString *)urlStr success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSURL *requestUrl = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    request.timeoutInterval = 15;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(error);
                }
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if (success) {
                    success(json);
                }
            });
        }
    }];
    [dataTask resume];
}
@end
