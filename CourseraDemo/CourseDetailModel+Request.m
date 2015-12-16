//
//  CourseDetailModel+Request.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseDetailModel+Request.h"
#import "NSString+CoursesFields.h"
#import "NSString+SearchFields.h"

@implementation CourseDetailModel (Request)

+ (void)fetchCourseListWithCompletionBlock:(SuccessBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock
{
    NSArray *fieldArray = @[@"estimatedClassWorkload",@"shortDescription",@"largeIcon",@"aboutTheCourse",@"language",@"video"];
    NSString *linkObject = @"&includes=universities,instructors";
    NSString *courseURL = [NSString stringWithFormat:@"%@%@",[NSString courseFieldsWithArray:fieldArray], linkObject];
    
    [[CourseHttpClient sharedHttpClient] GET:courseURL parameters:nil
                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                         successBlock(task, responseObject);
    }
                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         failureBlock(task, error);
    }];
    
}

+ (void)searchCourseWithKeyWord:(NSArray *)keywordArray WithCompletionBlock:(SuccessBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock
{
    NSString *searchURL = [NSString searchCourseFieldsWithArray:keywordArray];
    
    [[CourseHttpClient sharedHttpClient] GET:searchURL parameters:nil
                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                         successBlock(task, responseObject);
                                     }
                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         failureBlock(task, error);
                                     }];
    
}

@end
