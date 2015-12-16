//
//  InstrouctorModel.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "Realm.h"
#import <Foundation/Foundation.h>

@interface InstrouctorModel : RLMObject

@property  NSInteger instructorID;
@property  NSString *photo150;
@property NSString *firstName;
@property NSString *lastName;

@end

RLM_ARRAY_TYPE(InstrouctorModel)
