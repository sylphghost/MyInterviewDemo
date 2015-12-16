//
//  CourseDetailModel+Request.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseDetailModel.h"
#import "CourseHttpClient.h"

@interface CourseDetailModel (Request)

+ (void)fetchCourseListWithCompletionBlock:(SuccessBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock;

+ (void)searchCourseWithKeyWord:(NSArray *)keywordArray WithCompletionBlock:(SuccessBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock;

@end
