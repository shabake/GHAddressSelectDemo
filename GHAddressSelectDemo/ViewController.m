//
//  ViewController.m
//  GHAddressSelectDemo
//
//  Created by zhaozhiwei on 2019/3/21.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHAddressSelect.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"点击空白处";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    GHAddressSelect *addressSelect = [GHAddressSelect creatAddressSelectHeight:400 seletedBlock:^(NSArray * _Nonnull array) {
        NSMutableString *string = [NSMutableString string];
        for (NSDictionary *dict in array) {
            [string appendFormat:@"%@ ",dict[@"cityName"]];
        }
        self.navigationItem.title = [NSString stringWithFormat:@"用户选择的事是:%@",string];
        NSLog(@"结果%@",array);
    }];
        
    [addressSelect show];
}

@end
