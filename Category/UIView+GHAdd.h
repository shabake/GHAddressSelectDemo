//
//  UIView+Category.h
//  GHKit
//
//  Created by zhaozhiwei on 2019/1/26.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface UIView (GHAdd)


typedef void(^GHActionBlock)(UIView *view);

/**
 添加阴影
 */
- (void)gh_addShadow;
/**
 快速构建view类方法
 
 @param frame frame
 @param color color
 */
+ (instancetype)gh_creatViewWithFrame: (CGRect)frame color: (UIColor *)color;
/**
 找到自己的所属view
 
 @return view
 */
- (UIView *)gh_belongsView;

/**
 找到自己的所属viewController
 
 @return vc
 */
- (UIViewController *)gh_belongsVc;

/**
 找到当前显示的viewController
 
 @return vc
 */
- (UIViewController *)gh_currentVc;

/**
 给view增加点击事件
 
 @param target id类型 可以为空
 @param action 返回dactionBlock
 */

- (void)gh_addGestureRecognizerWithTarget:(id)target
                                   action:(GHActionBlock)action;

- (void)setCorner: (UIRectCorner)rectCorner;

/** view.width */
@property (nonatomic, assign) CGFloat gh_width;

/** view.height */
@property (nonatomic, assign) CGFloat gh_height;

/** view.origin.x */
@property (nonatomic, assign) CGFloat gh_left;

/** view.origin.y */
@property (nonatomic, assign) CGFloat gh_top;

/** view.origin.x + view.width */
@property (nonatomic, assign) CGFloat gh_right;

/** view.origin.y + view.height */
@property (nonatomic, assign) CGFloat gh_bottom;

/** view.center.x */
@property (nonatomic, assign) CGFloat gh_centerx;

/** view.center.y */
@property (nonatomic, assign) CGFloat gh_centery;

/** view.origin */
@property (nonatomic, assign) CGPoint gh_origin;

/** view.size */
@property (nonatomic, assign) CGSize gh_size;

@end

NS_ASSUME_NONNULL_END

