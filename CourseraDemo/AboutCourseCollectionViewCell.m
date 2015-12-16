//
//  AboutCourseCollectionViewCell.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "AboutCourseCollectionViewCell.h"

@implementation AboutCourseCollectionViewCell

- (void)configureAboutCourseCellWithHTMLString:(NSString *)htmlString
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _aboutCourseTextView.attributedText = attributedString;
}

@end
