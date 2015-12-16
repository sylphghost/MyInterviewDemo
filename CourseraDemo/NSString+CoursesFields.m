//
//  NSString+CoursesFields.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "NSString+CoursesFields.h"

@implementation NSString (CoursesFields)

+ (NSString *)courseFieldsWithArray:(NSArray *)fieldArray
{
   // courses?fields=language,shortDescription
    NSString *courseField = @"courses?fields=";
    for (int i = 0; i < fieldArray.count; i++) {
        NSString *field = fieldArray[i];
        if (i < fieldArray.count-1) {
            courseField = [NSString stringWithFormat:@"%@%@,",courseField, field];
        }else{
            courseField = [NSString stringWithFormat:@"%@%@",courseField, field];
        }
    }
    
    return courseField;
}

@end
