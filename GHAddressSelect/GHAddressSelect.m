//
//  GHAddressSelect.m
//  GHAddressSelectDemo
//
//  Created by zhaozhiwei on 2019/3/21.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHAddressSelect.h"
#import "GHAddressSelectHeader.h"
#import "NSArray+GHAdd.h"
#import "UIView+GHAdd.h"
#import "UIColor+Category.h"
#import "UITableView+GHAdd.h"
#import "GHAddressSelectCell.h"
#import "NSString+GHAdd.h"
#import "GHHTTPManager.h"
#import "MJExtension.h"
#import "GHAddressSelectModel.h"
#import "ToastTool.h"

@interface GHAddressSelect()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIScrollView *bottomScrollView;
@property (nonatomic , strong) UIScrollView *topScrollView;
@property (nonatomic , strong) UIControl *contentView;
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIButton *choseFirst;
@property (nonatomic , strong) NSMutableArray *tableViews;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) NSMutableArray *titles;
@property (nonatomic , assign) NSInteger currentIndex;
@property (nonatomic , strong) NSMutableArray *cityes;
@property (nonatomic , copy) NSString *cityCode;;
@property (nonatomic , copy) NSString *districtCode;;
@property (nonatomic , assign) BOOL isTap;
@property (nonatomic , strong) UIView *bottomLine;
@property (nonatomic , copy) GHAddressSelectBlock seletedBlock;;
@property (nonatomic , strong) UIButton *close;

@end
@implementation GHAddressSelect


+ (instancetype)creatAddressSelectHeight: (CGFloat)height seletedBlock: (GHAddressSelectBlock)seletedBlock {
    GHAddressSelect *addressSelect = [[GHAddressSelect alloc]initWithFrame:CGRectZero];
    addressSelect.height = height;
    addressSelect.seletedBlock = seletedBlock;
    [addressSelect setupDefault];
    [addressSelect loadDataWithTag:addressSelect.currentIndex code:0];
    return addressSelect;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.currentIndex = 0;
        self.isTap = NO;
    }
    return self;
}

- (void)setupDefault {
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
    self.layer.opacity = 0.0;
    /** 容器 */
    [self addSubview:self.contentView];
    /** 配送至 */
    [self.contentView addSubview:self.title];
    
    [self.contentView addSubview:self.close];

    /** 线 */
    [self.contentView addSubview:self.line];
    /** 顶部滚动 */
    [self.contentView addSubview:self.line];
    /** 底部滚动 */
    [self.contentView addSubview:self.bottomScrollView];
    [self.contentView addSubview:self.bottomLine];
    
    [self setupUITitlesWithString:nil];
}

#pragma mark - 所有区域请求数据
- (void)loadDataWithTag: (NSInteger)tag code: (NSString *)code {
    UITableView *tableView = [self.tableViews by_ObjectAtIndex:tag];
    
    weakself(self);
    NSString *url = @"";
    
    if (tag == 0) {
        url = @"https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getAllCitys";
    } else if (tag == 1) {
        url = @"https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHeNanCitys";
    } else if (tag == 2) {
        url = @"https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHeNanCountys";
    } else if (tag== 3) {
        url = @"https://www.easy-mock.com/mock/5c9309f3f5571b2492aaa105/GHome_copy/getHenanOthers";
    }
    [[GHHTTPManager sharedManager] requstDataWithUrl:url parametes:nil finishedBlock:^(NSDictionary *responseObject, NSError *error) {
        
        [ToastTool makeToast:@"加载成功" targetView:weakSelf.contentView];

        NSDictionary *data = responseObject[@"data"];
        NSArray *list = data[@"list"];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dict in list) {
            GHAddressSelectModel *addressSelectModel = [GHAddressSelectModel mj_objectWithKeyValues:dict];
            [dataArray addObject:addressSelectModel];
        }

        tableView.gh_dataArray = dataArray;
        if (dataArray.count == 0) {
            NSMutableArray *dataArray = [NSMutableArray array];
            for (UITableView *tableView in self.tableViews) {
                for (GHAddressSelectModel *object in tableView.gh_dataArray) {
                    if (object.selected) {
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];

                        dict[@"cityName"] = object.name;
                        dict[@"code"] = object.code;
                        [dataArray addObject:dict];
                    }
                }
            }
            if (self.seletedBlock) {
                self.seletedBlock(dataArray.copy);
            }
            [weakSelf dismiss];
        }
        [tableView reloadData];

        [UIScrollView animateWithDuration:0.25 animations:^{
            weakSelf.bottomScrollView.contentOffset = CGPointMake(kScreenWidth * tag, 0);
        } completion:^(BOOL finished) {
            for (UITableView *tab in weakSelf.tableViews) {
                tab.userInteractionEnabled = YES;
            }
        }];
    }];
}

#pragma mark - 创建标题和table

- (void)setupUITitlesWithString: (NSString *)string {
    
    /** 创建标题 */
    UILabel *title = [[UILabel alloc]init];
    title.text = string.length ? string: @"请选择";
    title.frame = CGRectMake(kMargin10 + 60 * self.titles.count, CGRectGetMaxY(self.line.frame), 0, 44);
    title.font = [UIFont systemFontOfSize:kFont(14)];
    title.textAlignment = NSTextAlignmentLeft;
    title.userInteractionEnabled = YES;
    title.tag = self.titles.count;
    /** 添加手势 */
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTap:)];
    [title addGestureRecognizer:tap];
    
    [self.titles addObject:title];
    
    for (NSInteger index = 0 ;index < self.titles.count; index++) {
        UILabel *lab = [self.titles by_ObjectAtIndex:index];
        if (index == self.titles.count - 1) {
            lab.text = @"请选择";
        } else if (index == self.currentIndex) {
            lab.text = string;
        }
    }
    
    [self.contentView addSubview:title];
    
    /** 创建tableView */
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake((self.titles.count -1 )* kScreenWidth, 0, kScreenWidth, self.bottomScrollView.gh_height);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.tag = self.titles.count - 1;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.bottomScrollView addSubview:tableView];
    [self.tableViews insertObject:tableView atIndex:tableView.tag];
    self.bottomScrollView.contentSize = CGSizeMake(self.titles.count * kScreenWidth, 0);
    self.topScrollView.contentSize = CGSizeMake(self.titles.count * kScreenWidth, 0);
    
    [self layoutIfNeededView];
}

- (void)layoutIfNeededView {

    for (NSInteger index = 0; index < self.titles.count; index++) {
        UILabel *label = [self.titles by_ObjectAtIndex:index];
        UILabel *first = nil;

        CGSize titleSize = [label.text sizeWithFont:[UIFont systemFontOfSize:kFont(14)] maxSize:CGSizeMake(MAXFLOAT, 44)];

        first = [self.titles by_ObjectAtIndex:index - 1];
        label.frame = CGRectMake(CGRectGetMaxX(first.frame) + kMargin10 * 2 , CGRectGetMaxY(self.line.frame), titleSize.width, 44);
        if (self.titles.count - 1 == index ) {
            label.textColor = [UIColor colorWithHexString:@"#F08327"];
        }
    }
    UILabel *lastLabel = self.titles.lastObject;

    [UIView animateWithDuration:0.25 animations:^{
        self.bottomLine.frame = CGRectMake(lastLabel.gh_left, CGRectGetMaxY(lastLabel.frame) - 3, lastLabel.gh_width, 3);
    }];
    if (self.tableViews.count > self.titles.count) {
        NSMutableArray *actionArray = [self.tableViews subarrayWithRange:NSMakeRange(0 , self.titles.count)].mutableCopy;
        self.tableViews = actionArray;
    }
}
#pragma mark - 手势响应
- (void)respondToTap:(UITapGestureRecognizer *)ges {
    if (self.bottomScrollView.tracking && self.bottomScrollView.dragging && self.bottomScrollView.decelerating) {
        return;
    }
    self.currentIndex = ges.view.tag;
    self.isTap = YES;
    for (UILabel *lable in self.titles) {
        lable.textColor = [UIColor blackColor];
    }
    UILabel *lable = [self.titles by_ObjectAtIndex: self.currentIndex];
    lable.textColor = [UIColor colorWithHexString:@"#F08327"];
    self.bottomLine.gh_width = lable.gh_width;
    [UIScrollView animateWithDuration:0.25 animations:^{
        self.bottomScrollView.contentOffset = CGPointMake(kScreenWidth * ges.view.tag, 0);
        self.bottomLine.gh_left = lable.gh_left;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.bottomScrollView) {
        int page = (int)scrollView.contentOffset.x/kScreenWidth +0.5;
        self.currentIndex = page;
        
        BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (scrollToScrollStop) {
            for (UILabel *lable in self.titles) {
                lable.textColor = [UIColor blackColor];
            }
            UILabel *lable = [self.titles by_ObjectAtIndex: self.currentIndex];
            lable.textColor = [UIColor colorWithHexString:@"#F08327"];
            [UIScrollView animateWithDuration:0.25  animations:^{
                self.bottomLine.gh_left = lable.gh_left;
                self.bottomLine.gh_width = lable.gh_width;
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.bottomScrollView) {
        int page = (int)scrollView.contentOffset.x/kScreenWidth +0.5;
        self.currentIndex = page;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UITableView *table = [self.tableViews by_ObjectAtIndex:self.currentIndex];
    return table.gh_dataArray.count;;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableView *table = [self.tableViews by_ObjectAtIndex:self.currentIndex];
    GHAddressSelectModel *addressSelectModel = [table.gh_dataArray by_ObjectAtIndex:indexPath.row];
    NSString *cellIdentifier = [NSString stringWithFormat:@"GHAddressSelectCell%ld%ld",(long)self.currentIndex,(long)indexPath.row];
    GHAddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GHAddressSelectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.addressSelectModel = addressSelectModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.bottomScrollView.tracking && self.bottomScrollView.dragging && self.bottomScrollView.decelerating) {
        return;
    }
    
    UITableView *table = [self.tableViews by_ObjectAtIndex:self.currentIndex];
    self.currentIndex = table.tag;
    GHAddressSelectModel *addressSelectModel = [table.gh_dataArray by_ObjectAtIndex:indexPath.row];

    addressSelectModel.selected = !addressSelectModel.selected;
    for (GHAddressSelectModel *object in table.gh_dataArray) {
        object.selected = NO;
    }
    addressSelectModel.selected = !addressSelectModel.selected;
    [table reloadData];
    for (UILabel *lable in self.titles) {
        lable.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    NSMutableArray *newArray = [self.titles subarrayWithRange:NSMakeRange(0, self.currentIndex + 1)].mutableCopy;
    for (UILabel *object in self.titles) {
        [object removeFromSuperview];
    }
    
    [self.titles removeAllObjects];
    
    for (UILabel *object in newArray) {
        [self.titles addObject:object];
        [self.contentView addSubview:object];
    }
    
    weakself(self);
    for (UITableView *tab in self.tableViews) {
        tab.userInteractionEnabled = NO;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf setupUITitlesWithString:addressSelectModel.name];
        weakSelf.currentIndex++;
        [weakSelf loadDataWithTag:weakSelf.currentIndex code:addressSelectModel.code];
    });
}

- (void)clickButton: (UIButton *)button {
    [self dismiss];
}

- (void)show {
    
    [kKeyWindow addSubview:self];
    [self setCenter:kKeyWindow.center];
    [kKeyWindow bringSubviewToFront:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];
        self.contentView.frame = CGRectMake(0, kScreenHeight - self.height - kSafeAreaBottomHeight, kScreenWidth, self.height +kSafeAreaBottomHeight );
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.height);
    } completion:^(BOOL finished) {
        [self.layer setOpacity:0.0];
        [self removeFromSuperview];
        
    }];
}

#pragma mark - get
- (UIButton *)close {
    if (_close == nil) {
        _close = [[UIButton alloc]init];
        _close.frame = CGRectMake(kScreenWidth - kAutoWithSize(22) - 20, kAutoWithSize(10), kAutoWithSize(22), kAutoWithSize(22));
        [_close setImage:[UIImage imageNamed:@"close@2x"] forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _close;
}

- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)cityes {
    if (_cityes == nil) {
        _cityes = [NSMutableArray array];
    }
    return _cityes;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)tableViews {
    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (UIButton *)choseFirst {
    if (_choseFirst == nil) {
        _choseFirst = [[UIButton alloc]initWithFrame:CGRectMake(kMargin10, self.line.gh_top + 0.5, 60, 40)];
        _choseFirst.titleLabel.font = [UIFont systemFontOfSize:kFont(16)];
        [_choseFirst setTitle:@"请选择" forState:UIControlStateNormal];
        _choseFirst.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_choseFirst setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _choseFirst;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#F08327"];
    }
    return _bottomLine;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, self.title.gh_height +self.title.gh_top + kAutoWithSize(10) , kScreenWidth, 0.5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    }
    return _line;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, kAutoWithSize(10), kScreenWidth, kAutoWithSize(22))];
        _title.text = @"配送至";
        _title.font = [UIFont boldSystemFontOfSize:kFont(16)];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _title;
}

- (UIControl *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIControl alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, self.height)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIScrollView *)topScrollView {
    if (_topScrollView == nil) {
        _topScrollView = [[UIScrollView alloc]init];
        _topScrollView.bounces = NO;
        _topScrollView.pagingEnabled = YES;
        _topScrollView.backgroundColor = [UIColor orangeColor];
        _topScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.line.frame), kScreenWidth, 49);
    }
    return _topScrollView;
}

- (UIScrollView *)bottomScrollView {
    if (_bottomScrollView == nil) {
        _bottomScrollView = [[UIScrollView alloc]init];
        _bottomScrollView.bounces = NO;
        _bottomScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), kScreenWidth, self.height - CGRectGetMaxY(self.topScrollView.frame));
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.delegate = self;
        _bottomScrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _bottomScrollView;
}

@end
