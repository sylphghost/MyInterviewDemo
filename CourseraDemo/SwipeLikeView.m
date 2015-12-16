//
//  SwipeLikeView.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "SwipeLikeView.h"

@implementation SwipeLikeView

- (void)awakeFromNib
{
    _heartButton.adjustsImageWhenHighlighted = NO;
}

- (IBAction)heartButtonDidClick:(id)sender
{
    if (!_heartButton.isSelected) {
        [self startHeartAnimationWithSelected:YES];
    }else
    {
        [self startHeartAnimationWithSelected:NO];
    }
    
    _heartButton.selected = !_heartButton.isSelected;
}

- (void)startHeartAnimationWithSelected:(BOOL)selected
{
    if (selected) {
        [UIView animateWithDuration:0.25 animations:^{
            _heartButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
           // _heartButton.selected = NO;
            _heartButton.transform = CGAffineTransformIdentity;
            //[_heartButton setBackgroundImage:[UIImage imageNamed:@"red_like"] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(swipeViewDidSubScribe:)]) {
                [self.delegate swipeViewDidSubScribe:YES];
            }
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            _heartButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
           // _heartButton.selected = YES;
            _heartButton.transform = CGAffineTransformIdentity;
         //   [_heartButton setBackgroundImage:[UIImage imageNamed:@"gray_like"] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(swipeViewDidSubScribe:)]) {
                [self.delegate swipeViewDidSubScribe:NO];
            }
        }];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
