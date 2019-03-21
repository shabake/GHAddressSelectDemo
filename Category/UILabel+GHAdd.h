//
//  UILabel+Category.h
//  GHKit
//
//  Created by zhaozhiwei on 2019/1/26.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger,GHLabelStatus) {
    GHLabelStatusNormal,
    GHLabelStatusSeleted,
};
typedef void(^GHLabelClickBlock)(void);
@interface UILabel (GHAdd)

@property (nonatomic , copy) UIColor *textNormalColor;
@property (nonatomic , copy) UIColor *textSeletedColor;
@property (nonatomic , assign) BOOL seleted;
@property (nonatomic , copy) GHLabelClickBlock clickBlock;

/**
 快速创建label

 @param frame frame
 @param textColor textColor
 @param font font
 @param textAlignment textAlignment
 @return label
 */

+ (instancetype)gh_creatLabelWithFrame:(CGRect)frame
                                  text:(NSString *)text
                             textColor:(UIColor *)textColor
                                  font:(UIFont *)font
                         textAlignment:(NSTextAlignment)textAlignment;


- (void)gh_addGestureRecognizerWithTarget:(id)target
                                   action:(GHLabelClickBlock)action;

@end

NS_ASSUME_NONNULL_END
