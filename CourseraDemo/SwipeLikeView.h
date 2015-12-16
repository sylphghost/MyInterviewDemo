//
//  SwipeLikeView.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeLikeViewDelegate <NSObject>

- (void)swipeViewDidSubScribe:(BOOL)isSubscribe;

@end

@interface SwipeLikeView : UIView
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (nonatomic, weak) id<SwipeLikeViewDelegate> delegate;

@end
