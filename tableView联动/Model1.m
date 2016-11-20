
//
//  Model1.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "Model1.h"
#import "NetWorkTools.h"

#define KUserName @"yuhongpeng_wanzhao.com"
#define KPassword @"#iYVb12u"
#define KCompanyId @"8"
#define KNETWORKERROR @"网络错误"

@implementation Model1

+ (instancetype)model1WithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }


+ (void)getApplyProcedureInfoWithCategoryName:(NSString *)categoryName FinishedBlock:(finishedBlock)finishedBlock failuerBlock:(failuerBlock)failuerBlock {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"companyId"] = KCompanyId;
    parameters[@"pageNo"] = @(1);
    parameters[@"pageSize"] = @(20);
    parameters[@"category"] = categoryName;
    [[NetWorkTools shareNetWorkTool] getWorkFlowApplyWithParameters:parameters successHandle:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictArray = (NSDictionary *)responseObject;
            NSArray *infoArray = dictArray[@"datas"];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in infoArray) {
                Model1 *model1 = [self model1WithDict:dic];
                [tempArray addObject:model1];
            }
            
            if (finishedBlock) {
                finishedBlock(tempArray.copy);
            }
        }
    } failureHandle:^(NSURLSessionDataTask *task, NSError *error) {
        if (failuerBlock) {
            failuerBlock(KNETWORKERROR);
        }
    }];
}

@end

