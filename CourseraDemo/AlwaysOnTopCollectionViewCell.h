//
//  AlwaysOnTopCollectionViewCell.h
//  NextCodeReview
//
//  Created by 臧其龙 on 15/12/8.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopCellDelegate <NSObject>

- (void)backButtonDidClick:(UIButton *)button;

- (void)playButtonDidClick:(UIButton *)button;

@end

@interface AlwaysOnTopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseShortNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet UIView *youtubePlayerView;
@property (nonatomic, weak) id<TopCellDelegate> delegate;
@end
