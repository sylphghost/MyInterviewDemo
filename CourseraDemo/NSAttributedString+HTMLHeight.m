//
//  NSAttributedString+HTMLHeight.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "NSAttributedString+HTMLHeight.h"

@implementation NSAttributedString (HTMLHeight)

+ (CGFloat)getHTMLHeightWithWidth:(CGFloat)width withString:(NSString *)htmlString
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}

@end
