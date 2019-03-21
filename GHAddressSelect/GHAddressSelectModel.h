//
//  GHAddressSelectModel.h
//  GHAddressSelectDemo
//
//  Created by zhaozhiwei on 2019/3/21.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHAddressSelectModel : NSObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *code;
@property (nonatomic , assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
