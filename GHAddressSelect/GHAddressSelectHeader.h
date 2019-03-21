//
//  GHAddressSelectHeader.h
//  GHAddressSelectDemo
//
//  Created by zhaozhiwei on 2019/3/21.
//  Copyright © 2019年 GHome. All rights reserved.
//

#ifndef GHAddressSelectHeader_h
#define GHAddressSelectHeader_h
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// ScreenWidth & kScreenHeight
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// iPhoneX
#define iPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
//判断iPhoneX序列（iPhoneX，iPhoneXs，iPhoneXs Max）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断iPHoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)

#define kSafeAreaBottomHeight (IS_PhoneXAll ? 34 : 0)
// StatusbarH + NavigationH
#define kSafeAreaTopHeight (IS_PhoneXAll ? 88.f : 64.f)
// StatusBarHeight
#define kStatusBarHeight (IS_PhoneXAll ? 44.f : 20.f)
// NavigationBarHeigth
#define kNavBarHeight 44.f
// TabBarHeight
#define kTabBarHeight  (IS_PhoneXAll ? (49.f+34.f) : 49.f)

// KeyWindow
#define kKeyWindow [UIApplication sharedApplication].keyWindow

// Rete
#define kScreenWidthRete   kScreenWidth / 375.0 //比率
#define kScreenHeightRete  kScreenWidth / 667.0 //比率
// AutoSize
#define kAutoWithSize(r) r*kScreenWidth / 375.0
#define kFont(size) kAutoWithSize(size)

#define kAutoHeightSize(r) r*kScreenHeight / 667.0

// Margin
#define kMargin1 1

#define kMargin2 2
#define kMargin5 5
#define kMargin6 6

#define kMargin10 10

#define weakself(self)          __weak __typeof(self) weakSelf = self
#endif /* GHAddressSelectHeader_h */
