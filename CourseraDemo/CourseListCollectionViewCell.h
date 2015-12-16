//
//  CourseListTableViewCell.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"

@protocol CourseListCollectionViewCellDelegate <NSObject>

- (void)cellDidFlip:(BOOL)isFlip withIndexPath:(NSIndexPath *)indexPath;

@end

@interface CourseListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workload;
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (nonatomic, assign) BOOL isFlip;
@property (nonatomic, strong) CourseDetailModel *model;
@property (nonatomic, weak) id<CourseListCollectionViewCellDelegate> delegate;


- (void)configureCourseListCellWithCourseDetail:(CourseDetailModel *)model
                                      withIndex:(NSIndexPath *)indexPath
                                     withFliped:(BOOL)isFlip;

- (void)startAnimationWithDelay:(CGFloat)delayTime;

@end
