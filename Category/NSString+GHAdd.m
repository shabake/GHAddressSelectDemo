//
//  NSString+GHAdd.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/8.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "NSString+GHAdd.h"

@implementation NSString (GHAdd)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

+ (NSString *)arc4randomStringWithCount: (NSInteger)range minCount: (NSInteger)minCount {
    NSMutableString *str = [NSMutableString string];
    
    for (NSInteger index = 0; index <(arc4random() % range) + minCount ; index++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0 + arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [str appendString:string];
    }
    return str.mutableCopy;
}
@end
