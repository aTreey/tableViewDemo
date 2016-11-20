//
//  NetWorkTools.h
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^successHandle)(NSURLSessionDataTask *task, id responseObject);
typedef void(^failureHandle)(NSURLSessionDataTask *task, NSError *error);

@interface NetWorkTools : AFHTTPSessionManager

+ (instancetype) shareNetWorkTool;

- (void)getWorkFlowApplyWithParameters:(NSDictionary *)parameters successHandle:(successHandle)successHandle failureHandle:(failureHandle)failureHandle;

- (void)getWorkFlowApplyWithURL:(NSString *)URL Parameters:(NSDictionary *)parameters successHandle:(successHandle)successHandle failureHandle:(failureHandle)failureHandle;

@end
