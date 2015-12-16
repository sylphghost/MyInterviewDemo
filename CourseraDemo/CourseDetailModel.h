//
//  CourseDetailModel.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"
#import "UniversityModel.h"
#import "InstrouctorModel.h"

@interface CourseDetailModel : RLMObject

@property  NSInteger courseID;
@property RLMArray<UniversityModel> *universityArray;
@property RLMArray<InstrouctorModel> *instrucatorArray;
@property  NSString *name;
@property  NSString *shortName;
@property  NSString *largeIcon;
@property  NSString *estimatedClassWorkload;
@property  NSString *language;
@property  NSString *shortDescription;
@property  NSString *video;
@property  NSString *aboutTheCourse;
@property  BOOL subscribe;
@property  NSNumber<RLMDouble> *timestamps;

@end

RLM_ARRAY_TYPE(CourseDetailModel)