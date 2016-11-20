//
//  Model.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "Model.h"
#import "Model1.h"
#import "NetWorkTools.h"

#define KUserName @"yuhongpeng_wanzhao.com"
#define KPassword @"#iYVb12u"
#define KCompanyId @"8"


@implementation Model

// 字典转模型
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

// 对于嵌套数据拦截处理

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"xxx"]) {
        NSArray *dictArray = (NSArray *)value;
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in tempArray) {
            Model1 *model1 = [Model1 model1WithDict:dict];
            [tempArray addObject:model1];
        }
        
        // 复制给MOdel1的模型
        self.model1Array = tempArray.copy;
        return;
    }
    
    // 继续转模型
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }




- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, size = %ld", self.name, self.size];
}



+ (void)getApplyProcedureFinishedBlock:(finishedBlock)finishedBlock {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"companyId"] = KCompanyId;
    parameters[@"pageNo"] = @(1);
    parameters[@"pageSize"] = @(20);
    parameters[@"category"] = nil;
    
    // 模拟网络加载慢时的情况 (延时2s)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NetWorkTools shareNetWorkTool] getWorkFlowApplyWithParameters:parameters successHandle:^(NSURLSessionDataTask *task, id responseObject) {
            
            // 判断是否为字典
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dictArray = (NSDictionary *)responseObject;
                NSArray *categoriesArray = dictArray[@"categorys"];
                
                NSMutableArray<Model *> *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in categoriesArray) {
                    Model *model = [self modelWithDict:dict];
                    [tempArray addObject:model];
                }
                
                if (finishedBlock) {
                    finishedBlock(tempArray.copy);
                }
            }
            
        } failureHandle:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    });
}


#pragma mark -
#pragma mark 懒加载

- (NSMutableArray *)cacheArray {
    if (!_cacheArray) {
        _cacheArray = [NSMutableArray array];
    }
    return _cacheArray;
}

@end
