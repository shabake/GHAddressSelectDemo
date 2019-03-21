//
//  UIView+Category.h
//  XFSSalesSecretary
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/*!
 *  返回一个RGBA格式的UIColor对象
 */
#define KRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/*!
 *  返回一个RGB格式的UIColor对象
 */
#define KRGB(r, g, b) RGBA(r, g, b, 1.0f)

/*!
 *  从HEX字符串得到一个UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/*!
 *  获取字符，转换数据类型，改变部分字体颜色
 *
 *  @param string string
 *  @param start  开始位置
 *  @param length 截取长度
 *
 *  @return float
 */
+ (CGFloat)colorComponentFrom:(NSString *)string
                        start:(NSUInteger)start
                       length:(NSUInteger)length;

/*!
 *  从HEX数值得到一个UIColor对象
 */
+ (UIColor *)colorWithHex:(unsigned int)hex;

/*!
 *  从HEX数值和Alpha数值得到一个UIColor对象
 */
+ (UIColor *)colorWithHex:(unsigned int)hex
                    alpha:(float)alpha;

/*!
 *  创建一个随机UIColor对象
 */
+ (UIColor *)randomColor;

/*!
 *  从已知UIColor对象和Alpha对象得到一个UIColor对象
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;

/*!
 *  UIColor 转UIImage
 *
 *  @param color color
 *
 *  @return UIColor 转UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
