//
//  InstrouctorModel+Request.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "InstrouctorModel.h"
#import "CourseHttpClient.h"

@interface InstrouctorModel (Request)

+ (void)fetchInstrouctorListWithCompletionBlock:(SuccessBlock)successBlock
                               WithFailureBlock:(FailureBlock)failureBlock;

@end
