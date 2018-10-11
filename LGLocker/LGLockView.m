//
//  LGLockView.m
//  LGEducationCloud
//
//  Created by 刘亚军 on 2018/3/28.
//  Copyright © 2018年 lange. All rights reserved.
//

#import "LGLockView.h"
#import <Masonry/Masonry.h>


@interface LGLockView ()
@property (nonatomic,strong) UIImageView *tipImage;
@property (nonatomic,strong) UILabel *tipLab;
@end
@implementation LGLockView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tipImage];
        [self.tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
        }];
        [self addSubview:self.tipLab];
        [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self);
            make.top.equalTo(self.tipImage.mas_bottom).offset(18);
        }];
    }
    return self;
}
+ (instancetype)showOnView:(UIView *)superView{
    LGLockView *lockView = [[LGLockView alloc] initWithFrame:CGRectZero];
    [superView addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    return lockView;
}
- (NSBundle *)lg_dictionaryBundle{
    static NSBundle *dictionaryBundle = nil;
    if (!dictionaryBundle) {
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Frameworks/LGLocker.framework/LGLocker.bundle"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
            bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LGLocker.bundle"];
        }
        dictionaryBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return dictionaryBundle;
}
- (UIImage *)lg_imageName:(NSString *)name{
    return [UIImage imageNamed:[[[self lg_dictionaryBundle] resourcePath] stringByAppendingPathComponent:name]];
}
- (void)setErrorMsg:(NSString *)errorMsg{
    _errorMsg = errorMsg;
    self.tipLab.text = errorMsg;
}
- (UIImageView *)tipImage{
    if (!_tipImage) {
        _tipImage = [[UIImageView alloc] initWithImage:[self lg_imageName:@"lg_statusView_empty"]];
    }
    return _tipImage;
}
- (UILabel *)tipLab{
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] init];
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.font = [UIFont systemFontOfSize:14];
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.textColor = [UIColor lightGrayColor];
        _tipLab.text = @"加密锁异常";
    }
    return _tipLab;
}
@end
