//
//  CourseDetailModel.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseDetailModel.h"

@implementation CourseDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"courseID": @"id"
             };
}

+ (NSString *)primaryKey {
    return @"courseID";
}

@end
