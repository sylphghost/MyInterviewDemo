//
//  InstrouctorModel+Request.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "InstrouctorModel+Request.h"


@implementation InstrouctorModel (Request)

+ (void)fetchInstrouctorListWithCompletionBlock:(SuccessBlock)successBlock
                               WithFailureBlock:(FailureBlock)failureBlock
{
    NSString *instrouctorURL = @"instructors?fields=photo150";
    [[CourseHttpClient sharedHttpClient] GET:instrouctorURL parameters:nil
                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                         successBlock(task, responseObject);
                                     }
                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         failureBlock(task, error);
                                     }];
    
}

@end
