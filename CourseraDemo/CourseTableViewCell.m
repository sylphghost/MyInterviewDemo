//
//  CourseTableViewCell.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseTableViewCell.h"
#import "UIImageView+YYWebImage.h"
#import "UniversityModel.h"

@implementation CourseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCourseTableViewCellWithCourseDetailModel:(CourseDetailModel *)model
                                                withIndex:(NSIndexPath *)indexPath
{
    _model = model;
    _cellIndex = indexPath;
    _courseNameLabel.text = model.shortName;
    if (model.universityArray.firstObject) {
        UniversityModel *university = model.universityArray.firstObject;
        _courseUniversityLabel.text = university.shortName;
    }
    
    _subScribleButton.selected = model.subscribe;
     [_courseImageView yy_setImageWithURL:[NSURL URLWithString:model.largeIcon] placeholder:nil];
}

- (IBAction)subscribleButtonDidClick:(BOOL)isSubscribe
{
    if (!_subScribleButton.isSelected) {
        [self startHeartAnimationWithSelected:YES];
    }else
    {
        [self startHeartAnimationWithSelected:NO];
    }
    
    _subScribleButton.selected = !_subScribleButton.isSelected;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    _model.subscribe = isSubscribe;
    [realm commitWriteTransaction];
}

- (void)startHeartAnimationWithSelected:(BOOL)selected
{
    if (selected) {
        [UIView animateWithDuration:0.25 animations:^{
            _subScribleButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            // _heartButton.selected = NO;
            _subScribleButton.transform = CGAffineTransformIdentity;
            //[_heartButton setBackgroundImage:[UIImage imageNamed:@"red_like"] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(subscribleButtonDidClick:withIndex:)]) {
                [self.delegate subscribleButtonDidClick:YES withIndex:_cellIndex];
            }
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            _subScribleButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            // _heartButton.selected = YES;
            _subScribleButton.transform = CGAffineTransformIdentity;
            //   [_heartButton setBackgroundImage:[UIImage imageNamed:@"gray_like"] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(subscribleButtonDidClick:withIndex:)]) {
                [self.delegate subscribleButtonDidClick:NO withIndex:_cellIndex];
            }
        }];
    }
    
    
}

@end
