//
//  CourseTableViewCell.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"

@protocol CourseTableViewCellDelegate <NSObject>

- (void)subscribleButtonDidClick:(BOOL)subscrible withIndex:(NSIndexPath *)indexPath;

@end

@interface CourseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *subScribleButton;
@property (weak, nonatomic) IBOutlet UILabel *courseUniversityLabel;
@property (nonatomic, strong) CourseDetailModel *model;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, weak) id<CourseTableViewCellDelegate> delegate;

- (void)configureCourseTableViewCellWithCourseDetailModel:(CourseDetailModel *)model
                                                withIndex:(NSIndexPath *)indexPath;
@end
