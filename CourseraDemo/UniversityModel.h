//
//  UniversityModel.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "Realm.h"
#import <Foundation/Foundation.h>

@interface UniversityModel : RLMObject

@property  NSInteger universityID;
@property  NSString *shortName;

@end

RLM_ARRAY_TYPE(UniversityModel)