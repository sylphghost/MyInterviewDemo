//
//  NSAttributedString+HTMLHeight.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (HTMLHeight)

+ (CGFloat)getHTMLHeightWithWidth:(CGFloat)width withString:(NSString *)htmlString;

@end
