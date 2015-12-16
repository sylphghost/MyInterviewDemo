//
//  UIColor+ThemeColor.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "UIColor+ThemeColor.h"
#import "UIColor+HexColor.h"

@implementation UIColor (ThemeColor)

+ (UIColor *)descriptionLabelColor
{
    return [UIColor colorWithHex:0xA6A2A2 alpha:1];
}

+ (UIColor *)titleLabelColor
{
    return [UIColor colorWithHex:0x636262 alpha:1];
}

@end
