//
//  ToastTool.h
//  GHPasswordManager-OC
//
//  Created by zhaozhiwei on 2019/3/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ToastTool : NSObject

/**
 *  单例
 *
 *  @return 返回该对象
 */
+ (instancetype)share;



#pragma mark -  MBProgressHUD相关

/**
 *  加载显示菊花
 *
 *  @param title         显示的title
 *  @param inView        菊花所放置的view
 *  @param isPenetration 菊花所放置的view是否可穿透, YES:可穿透，NO:不可穿透
 */
-(void)showHUDWithTitle:(NSString *)title
                 inView:(UIView *)inView
          isPenetration:(BOOL)isPenetration;

/**
 *  加载显示菊花[默认不可穿透]
 *
 *  @param title         显示的title
 *  @param inView        菊花所放置的view
 */
-(void)showHUDWithTitle:(NSString *)title
                 inView:(UIView *)inView;

/**
 *  隐藏菊花
 */
-(void)hide;

/**
 *  延迟隐藏菊花
 *
 *  @param delay 延迟时间
 */
- (void)hideAfterDelay:(NSTimeInterval)delay;



#pragma mark -  Toast相关

+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView delay: (NSTimeInterval)delay;

/** 显示Toast+message */
+ (void)makeToast:(NSString *)message targetView:(UIView *)targetView;
/** 隐藏Toast */
+ (void)hideToast:(UIView *)targetView;
/** 指示器Toast */
+ (void)makeToastActivity:(UIView *)targetView;
/** 隐藏指示器Toast */
+ (void)hideToastActivity:(UIView *)targetView;

@end

NS_ASSUME_NONNULL_END
