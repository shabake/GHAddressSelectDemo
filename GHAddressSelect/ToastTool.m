//
//  ToastTool.m
//  GHPasswordManager-OC
//
//  Created by zhaozhiwei on 2019/3/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "ToastTool.h"
#import "MBProgressHUD.h"
@interface ToastTool() {
    __weak UIView *_inView;
}
@property (nonatomic,strong) MBProgressHUD  *mBProgressHUD;

@end

@implementation ToastTool

#define kAppDelegate            ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kKeyWindow              kAppDelegate.window

#define ColorRGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)])

+ (instancetype)share{
    static dispatch_once_t t;
    static ToastTool *manager = nil;
    dispatch_once(&t, ^{
        manager = [[ToastTool alloc] init];
    });
    return manager;
}



#pragma mark -  MBProgressHUD相关

- (void)showHUDWithTitle:(NSString *)title
                  inView:(UIView *)inView
           isPenetration:(BOOL)isPenetration{
    if (_mBProgressHUD) {
        [self hide];
        _mBProgressHUD = nil;
    }
    _inView = inView;
    UIView *baseView = nil;
    if (_inView) {
        baseView = _inView;
    }
    else{
        baseView = [UIApplication sharedApplication].keyWindow;
    }
    
    _mBProgressHUD = [[MBProgressHUD alloc] initWithView:baseView];
    _mBProgressHUD.labelText = title;
    _mBProgressHUD.userInteractionEnabled = !isPenetration;
    _mBProgressHUD.removeFromSuperViewOnHide = YES;
    _mBProgressHUD.cornerRadius = 5.0;
    _mBProgressHUD.color = [UIColor colorWithWhite:0.0 alpha:0.75];
    _inView = inView;
    [baseView addSubview:_mBProgressHUD];
    [self show];
}

-(void)showHUDWithTitle:(NSString *)title
                 inView:(UIView *)inView
{
    [self showHUDWithTitle:title inView:inView isPenetration:NO];
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_mBProgressHUD];
    [_mBProgressHUD show:YES];
}
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif
-(void)hide{
    if (_inView) {
        _inView.userInteractionEnabled = YES;
    }
    dispatch_main_async_safe(^{
        [self->_mBProgressHUD hide:YES];
    });
}

- (void)hideAfterDelay:(NSTimeInterval)delay{
    [self performSelector:@selector(hide) withObject:nil afterDelay:delay];
}



#pragma mark -  Toast相关

+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView delay: (NSTimeInterval)delay {
    
    if (targetView == nil) targetView = [[UIApplication sharedApplication].windows lastObject];
    //每次显示前先隐藏
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.color = ColorRGBA(0, 0, 0, 102.0/255);
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hide:YES afterDelay:delay];
}
/* 登录页面样式*/
+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView {
    
    if (targetView == nil) targetView = [[UIApplication sharedApplication].windows lastObject];
    //每次显示前先隐藏
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.color = ColorRGBA(0, 0, 0, 102.0/255);
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.5];
}

+ (void)hideToast:(UIView *)targetView {
    [MBProgressHUD hideHUDForView:targetView animated:YES];
}

+ (void)makeToastActivity:(UIView *)targetView {
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.color = ColorRGBA(0, 0, 0, 102.0/255);
}

+ (void)hideToastActivity:(UIView *)targetView {
    [MBProgressHUD hideHUDForView:targetView animated:YES];
}

@end
