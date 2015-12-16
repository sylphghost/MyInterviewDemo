//
//  NSString+YoutubeURL.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YoutubeURL)

+ (NSString *)getVideoURLWithVideoCode:(NSString *)videoCode;

@end