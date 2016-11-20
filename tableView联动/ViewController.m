//
//  ViewController.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "ViewController.h"
#import "LeftCell.h"
#import "RightCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "Model.h"
#import "Model1.h"
#import "NetWorkTools.h"


#define KHARDWARE_WIDTH [UIScreen mainScreen].bounds.size.width
#define KHARDWARE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KHARDWARE_SCARE [UIScreen mainScreen].scale

#define KUserName @"yuhongpeng_wanzhao.com"
#define KPassword @"#iYVb12u"
#define KCompanyId @"8"
#define KuserId

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) UITableView *rightTableView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *infoArray;

@end

@implementation ViewController

static NSString *const leftIdentifier = @"left_cell";
static NSString *const rightIdentifier = @"right_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadNetWorkData];
}



- (void)setUpUI {
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
}


#pragma mark -
#pragma mark 加载网络数据 

- (void)loadNetWorkData {
    
    __weak typeof(self) weakSelf = self;
    [Model getApplyProcedureFinishedBlock:^(NSArray *array) {
        weakSelf.categories = array;
        [_leftTableView reloadData];
    }];
}



#pragma mark -
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.categories.count;
    } else {
        return self.infoArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        Model *leftModel = _categories[indexPath.row];
        LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier];
        cell.lefModel = leftModel;
        return cell;
    } else {
        RightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIdentifier];
        Model1 *infoModel = self.infoArray[indexPath.row];
        cell.infoModel = infoModel;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTableView) {
        Model *category = _categories[indexPath.row];
        
        [Model1 getApplyProcedureInfoWithCategoryName:category.name FinishedBlock:^(NSArray *array) {
            if (!array.count) {
                NSLog(@"网络错误");
            }
            self.infoArray = array;
            NSLog(@"category = %@", _infoArray);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [_rightTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        } failuerBlock:^(NSString *message) {
            NSLog(@"message = %@", message);
        }];
    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark -
#pragma mark Getter 方法 
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        CGRect frame = CGRectMake(0, 0, 100 * (KHARDWARE_WIDTH /320.0f), KHARDWARE_HEIGHT);
        UITableView *leftTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.leftTableView = leftTableView;
        [leftTableView setDelegate:self];
        [leftTableView setDataSource:self];
        [leftTableView setTableFooterView:[[UIView alloc] init]];
        [leftTableView setBackgroundColor:[UIColor lightGrayColor]];
        [leftTableView registerClass:[LeftCell class] forCellReuseIdentifier:leftIdentifier];
    }
    return  _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        CGRect frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 0, KHARDWARE_WIDTH - self.leftTableView.frame.size.width, KHARDWARE_HEIGHT);
        UITableView *rightTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.rightTableView = rightTableView;
        rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        [rightTableView setDelegate:self];
        [rightTableView setDataSource:self];
        [rightTableView setBackgroundColor:[UIColor whiteColor]];
        [rightTableView setTableFooterView:[[UIView alloc] init]];
        [rightTableView registerClass:[RightCell class] forCellReuseIdentifier:rightIdentifier];
    }
    return  _rightTableView;
}


#pragma mark -
#pragma mark 懒加载

- (NSArray *)categories {
    if (!_categories) {
        _categories = [NSArray array];
    }
    return _categories;
}

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSArray array];
    }
    return _infoArray;
}

@end
