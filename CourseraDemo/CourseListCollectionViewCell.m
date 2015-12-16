//
//  CourseListTableViewCell.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseListCollectionViewCell.h"
#import "UIImageView+YYWebImage.h"
#import "UIColor+ThemeColor.h"
#import "SwipeLikeView.h"
#import "Masonry.h"
#import "ARAnimation.h"

@interface CourseListCollectionViewCell ()<SwipeLikeViewDelegate>
{
    SwipeLikeView *likeView;
}

@end

@implementation CourseListCollectionViewCell

- (void)awakeFromNib {
    _courseNameLabel.textColor = [UIColor titleLabelColor];
    _courseDescLabel.textColor = [UIColor descriptionLabelColor];
    _universityNameLabel.textColor = [UIColor descriptionLabelColor];
    _workload.textColor = [UIColor descriptionLabelColor];
    
    likeView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SwipeLikeView class]) owner:nil options:nil] lastObject];
    likeView.delegate = self;
    [self.contentView addSubview:likeView];
    [self.contentView sendSubviewToBack:likeView];
    
    [likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsZero);
    }];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleCellLonggestureAction:)];
    [self.contentView addGestureRecognizer:longGesture];
}

#pragma mark - Handle Event Action

- (void)handleCellLonggestureAction:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_isFlip) {
            
            [UIView AR_animationWithDuration:0.25 animations:^{
                self.layer.rotationY = M_PI;
            } completion:^{
                [self.contentView bringSubviewToFront:_parentView];
                self.layer.transform = CATransform3DIdentity;
            }];
            
        }else
        {
            [UIView AR_animationWithDuration:0.25 animations:^{
                self.layer.rotationY = M_PI;
            } completion:^{
                [self.contentView bringSubviewToFront:likeView];
                self.layer.transform = CATransform3DIdentity;
            }];
          
        }
        _isFlip = !_isFlip;
        if ([self.delegate respondsToSelector:@selector(cellDidFlip:withIndexPath:)]) {
            [self.delegate cellDidFlip:_isFlip withIndexPath:_currentIndex];
        }
    }

}

#pragma mark - Data bind

- (void)configureCourseListCellWithCourseDetail:(CourseDetailModel *)model
                                      withIndex:(NSIndexPath *)indexPath
                                     withFliped:(BOOL)isFlip
{
    _model = model;
    _currentIndex = indexPath;
    _isFlip = isFlip;
    if (!_isFlip) {
        [self.contentView bringSubviewToFront:_parentView];
    }else
    {
        [self.contentView bringSubviewToFront:likeView];
    }
    if (model.universityArray.firstObject) {
        UniversityModel *university = model.universityArray.firstObject;
        _universityNameLabel.text = university.shortName;
    }
    _courseNameLabel.text = model.shortName;
    _courseDescLabel.text = model.shortDescription;
    _workload.text = model.estimatedClassWorkload;
    [_iconImageView yy_setImageWithURL:[NSURL URLWithString:model.largeIcon] placeholder:nil];
    
    likeView.heartButton.selected = model.subscribe;
    
}

#pragma mark - Animation Method

- (void)startAnimationWithDelay:(CGFloat)delayTime
{
    self.transform =  CGAffineTransformMakeTranslation(0, -CGRectGetHeight([UIScreen mainScreen].bounds)*1.5);
    [UIView animateWithDuration:1. delay:delayTime usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

#pragma mark - SwipeLikeViewDelegate 

- (void)swipeViewDidSubScribe:(BOOL)isSubscribe
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    _model.subscribe = isSubscribe;
    [realm commitWriteTransaction];
}

@end
