//
//  InstructorCollectionViewCell.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/17.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "InstructorCollectionViewCell.h"
#import "UIImageView+YYWebImage.h"

@implementation InstructorCollectionViewCell

- (void)configureInstructorCellWithInstructorModel:(InstrouctorModel *)model
{
    [_instructorImageView yy_setImageWithURL:[NSURL URLWithString:model.photo150] placeholder:nil];
    _instructorNameLabel.text = [NSString stringWithFormat:@"%@ %@",model.firstName, model.lastName];
}

@end
