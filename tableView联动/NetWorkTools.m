//
//  NetWorkTools.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "NetWorkTools.h"

#define KUserName @"yuhongpeng_wanzhao.com"
#define KPassword @"#iYVb12u"
#define KCompanyId @"8"

@implementation NetWorkTools

static NSString *const baseURLStr = @"http://eims.wanzhao.com/appInterface/";
static NetWorkTools *_instance;

+ (instancetype)shareNetWorkTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLStr]];
        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    });
    return _instance;
}


- (void)getWorkFlowApplyWithParameters:(NSDictionary *)parameters successHandle:(successHandle)successHandle failureHandle:(failureHandle)failureHandle {
    
    NSString *author = [[[NSString stringWithFormat:@"%@:%@:%@", KUserName, KPassword, KCompanyId] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    NSString *str = [NSString stringWithFormat:@"%@workflow!getWorkflowApplyJsonData.action", baseURLStr];
    NSCharacterSet *allowCharacters = [NSCharacterSet characterSetWithCharactersInString:str];
    NSString *urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:allowCharacters];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Basic %@", author] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandle(task, error);
    }];
}

@end
