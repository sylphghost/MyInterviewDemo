//
//  AlwaysOnTopCollectionViewCell.m
//  NextCodeReview
//
//  Created by 臧其龙 on 15/12/8.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "AlwaysOnTopCollectionViewCell.h"

@implementation AlwaysOnTopCollectionViewCell

#pragma mark - handle Event Action

- (IBAction)handleBackButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(backButtonDidClick:)]) {
        [self.delegate backButtonDidClick:sender];
    }
}

- (IBAction)handlePlayButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(playButtonDidClick:)]) {
        [self.delegate playButtonDidClick:sender];
    }
}


@end
