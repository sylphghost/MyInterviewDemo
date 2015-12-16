//
//  NSString+YoutubeURL.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "NSString+YoutubeURL.h"

@implementation NSString (YoutubeURL)

+ (NSString *)getVideoURLWithVideoCode:(NSString *)videoCode
{
    return [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",videoCode];
}

@end
