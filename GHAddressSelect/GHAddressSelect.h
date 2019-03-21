//
//  GHAddressSelect.h
//  GHAddressSelectDemo
//
//  Created by zhaozhiwei on 2019/3/21.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GHAddressSelectBlock)(NSArray *array);
@interface GHAddressSelect : UIView

+ (instancetype)creatAddressSelectHeight: (CGFloat)height seletedBlock: (GHAddressSelectBlock)seletedBlock;
@property (nonatomic , assign) CGFloat height;
- (void)show;

@end

NS_ASSUME_NONNULL_END
