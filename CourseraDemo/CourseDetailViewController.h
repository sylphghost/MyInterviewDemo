//
//  CourseDetailViewController.h
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"

@interface CourseDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *courseDetailCollectionView;
@property (nonatomic, strong) CourseDetailModel *model;

@end
