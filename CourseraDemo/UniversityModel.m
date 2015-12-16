//
//  UniversityModel.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "UniversityModel.h"

@implementation UniversityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"universityID": @"id"
             };
}

+ (NSString *)primaryKey {
    return @"universityID";
}

@end
