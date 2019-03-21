//
//  UIView+Category.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/1/26.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "UIView+GHAdd.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

static NSString *GHActionKey = @"GHActionKey";
static NSString *Gh_maskLayerKey = @"Gh_maskLayerKey";
static NSString *Gh_borderPathKey = @"Gh_borderPathKey";

static NSString *GH_rectCorner = @"GH_rectCorner";


@interface UIView()

@property (nonatomic , strong) CAShapeLayer *gh_maskLayer;
@property (nonatomic , strong) UIBezierPath *gh_borderPath;

@end

@implementation UIView (GHAdd)


- (void)gh_addShadow {
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 10;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

/**
 快速构建view类方法
 
 @param frame frame
 @param color color
 */

+ (instancetype)gh_creatViewWithFrame: (CGRect)frame color: (UIColor *)color {
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

/**
 找到自己的所属view
 
 @return view
 */
- (UIView *)gh_belongsView {
    return self.superview;
}

/**
 找到自己的所属viewController
 
 @return vc
 */

- (UIViewController *)gh_belongsVc {
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController  class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
    
}
/**
 找到当前显示的viewController
 
 @return vc
 */
- (UIViewController *)gh_currentVc {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [self gh_getCurrentVc:appDelegate.window.rootViewController];
}

- (UIViewController *)gh_getCurrentVc:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        
        UINavigationController *nav = ((UITabBarController *)controller).selectedViewController;
        return [nav.viewControllers lastObject];
    } else if ([controller isKindOfClass:[UINavigationController class]]) {
        
        return [((UINavigationController *)controller).viewControllers lastObject];
    } else if ([controller isKindOfClass:[UIViewController class]]) {
        
        return controller;
    } else {
        
        return nil;
    }
}

- (void)setAction:(GHActionBlock)action {
    objc_setAssociatedObject(self, &GHActionKey, action, OBJC_ASSOCIATION_RETAIN);
}

- (GHActionBlock)action{
    return objc_getAssociatedObject(self, &GHActionKey);
}


- (void)gh_addGestureRecognizerWithTarget:(id)target
                                   action:(GHActionBlock)action{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = target;
    self.action = action;
    [self addGestureRecognizer:tap];
    
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    if (self.action) {
        self.action(self);
    }
}

- (void)setCorner: (UIRectCorner)rectCorner {
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = borderPath.CGPath;
    [self.layer setMask:maskLayer];
}



- (CGFloat)gh_width {
    
    return self.frame.size.width;
}

- (void)setGh_width:(CGFloat)gh_width {
    
    CGRect frame = self.frame;
    frame.size.width = gh_width;
    self.frame = frame;
}

- (CGFloat)gh_height {
    
    return self.frame.size.height;
}
- (void)setGh_height:(CGFloat)gh_height {
    
    CGRect frame = self.frame;
    frame.size.height = gh_height;
    self.frame = frame;
}

- (CGFloat)gh_left {return self.frame.origin.x;}
- (void)setGh_left:(CGFloat)gh_left {
    
    CGRect frame = self.frame;
    frame.origin.x = gh_left;
    self.frame = frame;
}

- (CGFloat)gh_top {return self.frame.origin.y;}
- (void)setGh_top:(CGFloat)gh_top {
    
    CGRect frame = self.frame;
    frame.origin.y = gh_top;
    self.frame = frame;
}

- (CGFloat)gh_right {return self.frame.origin.x+self.frame.size.width;}
- (void)setGh_right:(CGFloat)gh_right {
    
    CGRect frame = self.frame;
    frame.origin.x = gh_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)gh_bottom {return self.frame.origin.y+self.frame.size.height;};
- (void)setGh_bottom:(CGFloat)gh_bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = gh_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)gh_centerx {return self.center.x;}

- (void)setGh_centerx:(CGFloat)gh_centerx {
    
    self.center = CGPointMake(gh_centerx, self.center.y);
}

- (CGFloat)gh_centery {return self.center.y;}
- (void)setGh_centery:(CGFloat)gh_centery {
    
    self.center = CGPointMake(self.center.x, gh_centery);
}

- (CGPoint)gh_origin {return self.frame.origin;}
- (void)setGh_origin:(CGPoint)gh_origin {
    
    CGRect frame = self.frame;
    frame.origin = gh_origin;
    self.frame = frame;
}

- (CGSize)gh_size {return self.frame.size;}
- (void)setGh_size:(CGSize)gh_size {
    
    CGRect frame = self.frame;
    frame.size = gh_size;
    self.frame = frame;
}

@end

