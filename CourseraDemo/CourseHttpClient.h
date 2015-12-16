//
//  CourseHttpClient.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface CourseHttpClient : AFHTTPSessionManager

+ (instancetype)sharedHttpClient;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure;

@end
