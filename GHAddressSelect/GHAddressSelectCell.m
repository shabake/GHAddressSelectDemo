//
//  GHAddressSelectCell.m
//  GHAddressSelectDemo
//
//  Created by zhaozhiwei on 2019/3/21.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHAddressSelectCell.h"
#import "UIColor+Category.h"
#import "GHAddressSelectModel.h"

@interface GHAddressSelectCell()
@property (nonatomic , strong) UILabel *title;
@end

@implementation GHAddressSelectCell

- (void)setAddressSelectModel:(GHAddressSelectModel *)addressSelectModel {
    _addressSelectModel = addressSelectModel;
    self.title.text = addressSelectModel.name;
    
    if (addressSelectModel.selected) {
        self.title.textColor = [UIColor colorWithHexString:@"#F08327"];
    } else {
        self.title.textColor = [UIColor colorWithHexString:@"#333333"];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configuration];
        [self.contentView addSubview:self.title];
    }
    return self;
}

- (void)configuration {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height);
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
@end
