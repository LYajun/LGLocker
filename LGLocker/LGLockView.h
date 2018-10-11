//
//  LGLockView.h
//  LGEducationCloud
//
//  Created by 刘亚军 on 2018/3/28.
//  Copyright © 2018年 lange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGLockView : UIView
/** 错误信息 */
@property (nonatomic,copy) NSString *errorMsg;

+ (instancetype)showOnView:(UIView *) superView;
@end
