//
//  TwoViewController.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/20.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "TwoViewController.h"
#import "NetWorkTools.h"
#import "Model.h"
#import "Model1.h"

@interface TwoViewController ()

@property (strong, nonatomic) NSArray *leftArray;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    id obj = self.navigationController.childViewControllers.firstObject;
    
    if ([obj isKindOfClass:[TwoViewController class]]) {
        
        [self loadNetWorkData];
        
    } else {
        NSLog(@"其他控制器");
    }
    
    [self loadNetWorkData];
}


- (void)loadNetWorkData {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"pageNo"] = @(1);
    parameters[@"pageSize"] = @(20);
    parameters[@"category"] = @"";
    
    [[NetWorkTools shareNetWorkTool] getAppliedWorkFlowWithParameters:parameters successHandle:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            NSLog(@"responseObject = %@", responseObject);
            NSArray *dictArray = responseObject[@"categorys"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in dictArray) {
                Model *model = [Model modelWithDict:dict];
                [tempArray addObject:model];
            }
            self.leftArray = tempArray.copy;
        }
    } failureHandle:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
