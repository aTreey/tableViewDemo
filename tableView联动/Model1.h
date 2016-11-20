//
//  Model1.h
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^finishedBlock)(NSArray *array);

typedef void(^failuerBlock)(NSString *message);

@interface Model1 : NSObject

@property (copy,   nonatomic) NSString *category;
@property (assign, nonatomic) NSInteger formId;
@property (assign, nonatomic) NSInteger fversion;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *runStatus;
@property (copy,   nonatomic) NSString *taskDef;

+ (instancetype)model1WithDict:(NSDictionary *)dict;

+ (void)getApplyProcedureInfoWithCategoryName:(NSString *)categoryName FinishedBlock:(finishedBlock)finishedBlock failuerBlock:(failuerBlock)failuerBlock;

@end
