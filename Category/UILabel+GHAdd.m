//
//  UILabel+Category.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/1/26.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "UILabel+GHAdd.h"
#import <objc/runtime.h>

@interface UILabel()

@property (nonatomic , copy) GHLabelClickBlock clickBlock;
@property (nonatomic , assign) GHLabelStatus status;

@end

static NSString *GHClickBlockKey = @"GHClickBlockKey";
static NSString *GHTextNormalColorKey = @"GHTextNormalColorKey";
static NSString *GHTextSeletedColorKey = @"GHTextSeletedColorKey";
static NSString *GHLabelSeletedKey = @"GHLabelSeletedKey";

@implementation UILabel (GHAdd)

- (void)setSeleted:(BOOL)seleted {
    NSNumber *seletedNum = [NSNumber numberWithBool:seleted];
    objc_setAssociatedObject(self, &GHLabelSeletedKey, seletedNum, OBJC_ASSOCIATION_RETAIN);
    if (seleted) {
        self.textColor = self.textSeletedColor;
    } else {
        self.textColor = self.textNormalColor;;
    }
}

- (BOOL)seleted {
    NSNumber *seletedNum = objc_getAssociatedObject(self, &GHLabelSeletedKey);
    return seletedNum.boolValue;
}

- (void)setTextSeletedColor:(UIColor *)textSeletedColor {
    objc_setAssociatedObject(self, &GHTextSeletedColorKey, textSeletedColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)textSeletedColor {
    return objc_getAssociatedObject(self, &GHTextSeletedColorKey);
}

- (void)setTextNormalColor:(UIColor *)textNormalColor {
    objc_setAssociatedObject(self, &GHTextNormalColorKey, textNormalColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)textNormalColor {
    return objc_getAssociatedObject(self, &GHClickBlockKey);
}

- (void)setClickBlock:(GHLabelClickBlock)clickBlock {
    objc_setAssociatedObject(self, &GHClickBlockKey, clickBlock, OBJC_ASSOCIATION_RETAIN);
}

- (GHLabelClickBlock)clickBlock {
    return objc_getAssociatedObject(self, &GHClickBlockKey);
}

+ (instancetype)gh_creatLabelWithFrame:(CGRect)frame
                                  text:(NSString *)text
                             textColor:(UIColor *)textColor
                                  font:(UIFont *)font
                         textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = textColor;
    label.font = font;
    label.text = text;
    label.textAlignment = textAlignment;
    label.seleted = NO;
    return label;
}

- (void)gh_addGestureRecognizerWithTarget:(id)target
                                   action:(GHLabelClickBlock)action {
    
    if (action == nil) {
        return;
    }
    self.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = target;
    self.clickBlock = action;
  
    [self addGestureRecognizer:tap];

}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    if (self.clickBlock) {
        self.clickBlock();
    }
}
@end
