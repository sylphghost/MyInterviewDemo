//
//  AboutCourseCollectionViewCell.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutCourseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextView *aboutCourseTextView;

- (void)configureAboutCourseCellWithHTMLString:(NSString *)htmlString;

@end
