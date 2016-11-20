//
//  Model.h
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^finishedBlock)(NSArray *array);

@interface Model : NSObject
@property (strong, nonatomic) NSArray *model1Array;
@property (copy,   nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger size;

/*解决点击左边 tableView 右边重复请求数据问题*/
// 1. 可用字典存储每个类别对应数据

// 2. 用可变数组存储
@property (strong, nonatomic) NSMutableArray *cacheArray;

+ (instancetype) modelWithDict:(NSDictionary *)dict;

// 返回数据给控制器
+ (void)getApplyProcedureFinishedBlock:(finishedBlock)finishedBlock;

@end
