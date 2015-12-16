//
//  UIStoryboard+LoadDetailViewController.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "UIStoryboard+LoadDetailViewController.h"

static NSString * const kCourseDetailViewControllerID = @"kCourseDetailViewControllerID";

@implementation UIStoryboard (LoadDetailViewController)

+ (CourseDetailViewController *)loadCourseDetailViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:kCourseDetailViewControllerID];
}

@end
