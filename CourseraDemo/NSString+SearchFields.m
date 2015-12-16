//
//  NSString+SearchFields.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "NSString+SearchFields.h"

@implementation NSString (SearchFields)

+ (NSString *)searchCourseFieldsWithArray:(NSArray *)fieldArray
{
    //courses?q=search&query=malware+underground
    NSString *searchField = @"courses?q=search&query=";
    for (int i = 0; i < fieldArray.count; i++) {
        NSString *field = fieldArray[i];
        if (i < fieldArray.count-1) {
            searchField = [NSString stringWithFormat:@"%@%@+",searchField, field];
        }else{
            searchField = [NSString stringWithFormat:@"%@%@",searchField, field];
        }
    }
    
    return searchField;

}

@end
