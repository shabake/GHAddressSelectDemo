//
//  UITableView+GHAdd.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "UITableView+GHAdd.h"
#import <objc/runtime.h>

static NSString *gh_dataArrayKey = @"gh_dataArrayKey";

@implementation UITableView (GHAdd)

- (void)setGh_dataArray:(NSArray *)gh_dataArray {
    objc_setAssociatedObject(self, &gh_dataArrayKey, gh_dataArray, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray *)gh_dataArray {
    NSArray *array = objc_getAssociatedObject(self, &gh_dataArrayKey);
    if (array == nil) {
        array = [NSArray array];
        objc_setAssociatedObject(self, &gh_dataArrayKey, array, OBJC_ASSOCIATION_RETAIN);
    }
    return array;
}

- (id)gh_objectWithArray: (NSArray *)array AtIndex:(NSUInteger)index;{
    if (array.count > index) {
        return [array objectAtIndex:index];
    } else {
        return nil;
    }
}
@end
