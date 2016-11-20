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
#import <MJRefresh.h>


#define KHARDWARE_WIDTH [UIScreen mainScreen].bounds.size.width
#define KHARDWARE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KHARDWARE_SCARE [UIScreen mainScreen].scale

#define KUserName @"yuhongpeng_wanzhao.com"
#define KPassword @"#iYVb12u"
#define KCompanyId @"127"
#define KuserId

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) UITableView *rightTableView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableArray *infoArray;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation ViewController

static NSString *const leftIdentifier = @"left_cell";
static NSString *const rightIdentifier = @"right_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpRefresh];
    self.currentPage = 1;
    UIViewController *Vc = self.navigationController.childViewControllers.firstObject;
    
    if ([Vc isKindOfClass:[ViewController class]]) {
        
//        [self loadNetWorkData];
    } else {
        
        [self loadAppliedData];
    }
    
}



- (void)setUpUI {
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
}


- (void)setUpRefresh {
    
    // 添加上拉刷新控件
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置一开始不显示
    self.rightTableView.mj_footer.hidden = YES;
}


- (void)loadMoreData {
    
    Model *category = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"pageNo"] = @(self.currentPage++);
    parameters[@"pageSize"] = @(20);
    parameters[@"category"] = category.name;
    
    [[NetWorkTools shareNetWorkTool] getAppliedWorkFlowWithParameters:parameters successHandle:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            NSArray *dictArray = responseObject[@"datas"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in dictArray) {
                Model1 *model = [Model1 model1WithDict:dic];
                [tempArray addObject:model];
            }
            [self.infoArray addObjectsFromArray:tempArray.copy];
        }
        [self.rightTableView reloadData];
        
        [self checkFooterState];
        
    } failureHandle:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

- (void)checkFooterState {
    Model *category = self.categories[self.leftTableView.indexPathForSelectedRow.row];
    self.rightTableView.mj_footer.hidden = (self.infoArray.count == 0);
    if (self.infoArray.count == category.size) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.rightTableView.mj_footer endRefreshing];
    }
}

#pragma mark -
#pragma mark 加载网络数据

- (void)loadNetWorkData {
    
    __weak typeof(self) weakSelf = self;
    [Model getApplyProcedureFinishedBlock:^(NSArray *array) {
        weakSelf.categories = array;
        [_leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }];
}



- (void)loadAppliedData {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"pageNo"] = @(self.currentPage);
    parameters[@"pageSize"] = @(20);
    parameters[@"category"] = @"";
    
    [[NetWorkTools shareNetWorkTool] getAppliedWorkFlowWithParameters:parameters successHandle:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            NSArray *dictArray = responseObject[@"categorys"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in dictArray) {
                Model *model = [Model modelWithDict:dic];
                [tempArray addObject:model];
            }
            self.categories = tempArray.copy;
        }
        
        [self.leftTableView reloadData];
        
        [self.leftTableView selectRowAtIndexPath:0 animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failureHandle:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}



#pragma mark -
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.categories.count;
    } else {
        
        // 设置当没有数据的时候隐藏
        self.rightTableView.mj_footer.hidden = (self.infoArray.count == 0);
        return self.infoArray.count;
//        return [self.categories[self.leftTableView.indexPathForSelectedRow.row] cacheArray].count;
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
        Model1 *model1 = _infoArray[indexPath.row];
        cell.infoModel = model1;
//        Model *model = self.categories[self.leftTableView.indexPathForSelectedRow.row];
//        cell.infoModel = model.cacheArray[indexPath.row];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.infoArray = nil;
    [self.rightTableView reloadData];
    if (tableView == _leftTableView) {
        Model *category = _categories[indexPath.row];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"pageNo"] = @(1);
        parameters[@"pageSize"] = @(20);
        parameters[@"category"] = category.name;
        [[NetWorkTools shareNetWorkTool] getAppliedWorkFlowWithParameters:parameters successHandle:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"success"] boolValue]) {
                NSArray *dictArray = responseObject[@"datas"];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dic in dictArray) {
                    Model1 *model = [Model1 model1WithDict:dic];
                    [tempArray addObject:model];
                }
                self.infoArray = tempArray.copy;
                
            }
            [self.rightTableView reloadData];
        } failureHandle:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error = %@", error);
        }];
        
//        if (category.cacheArray.count) {
//            [_rightTableView reloadData];
//            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
//            [_rightTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
//        } else {
//            // 讲数组清空,解决点击cell时显示的还是上一个cell的数据
//            self.infoArray = nil;
//            [_rightTableView reloadData];
//            [Model1 getApplyProcedureInfoWithCategoryName:category.name FinishedBlock:^(NSArray *array) {
//                self.infoArray = array;
//                NSLog(@"category = %@", _infoArray);
//                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
//                [_rightTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//            } failuerBlock:^(NSString *message) {
//                NSLog(@"message = %@", message);
//            }];
//        }
    }
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

- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

@end
