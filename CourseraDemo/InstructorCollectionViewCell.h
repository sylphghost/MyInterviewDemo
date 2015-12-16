//
//  InstructorCollectionViewCell.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstrouctorModel.h"

@interface InstructorCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *instructorImageView;
@property (weak, nonatomic) IBOutlet UILabel *instructorNameLabel;

- (void)configureInstructorCellWithInstructorModel:(InstrouctorModel *)model;

@end
