//
//  NSString+GHAdd.h
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/8.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GHAdd)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 随机生成文字

 @param range <#range description#>
 @param minCount <#minCount description#>
 @return 文字
 */
+ (NSString *)arc4randomStringWithCount: (NSInteger)range minCount: (NSInteger)minCount;

@end

NS_ASSUME_NONNULL_END
