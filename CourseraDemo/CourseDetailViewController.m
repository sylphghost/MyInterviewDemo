//
//  CourseDetailViewController.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CSStickyHeaderFlowLayout.h"
#import "AlwaysOnTopCollectionViewCell.h"
#import "UIImageView+YYWebImage.h"
#import "NSString+YoutubeURL.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "BasicCourseInfoCollectionViewCell.h"
#import "InstructorCollectionViewCell.h"
#import "AboutCourseCollectionViewCell.h"
#import "NSAttributedString+HTMLHeight.h"

static NSString * const kStickyHeaderID = @"stickyHeader";
static NSString * const kWorkLoadCellID = @"kWorkLoadCellID";
static NSString * const kInstructorID = @"kInstructorID";
static NSString * const kAboutCourseID = @"kAboutCourseID";

static CGFloat const kMasterAvatarHeight = 246;
static CGFloat const kMasterMinumAvatarHeight = 124;

@interface CourseDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TopCellDelegate>
{
    AlwaysOnTopCollectionViewCell *alwaysOnTopCell;
    CGFloat htmlHeight;
}

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [_courseDetailCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AlwaysOnTopCollectionViewCell class]) bundle:nil]
                  forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                         withReuseIdentifier:kStickyHeaderID];
    
    [self reloadLayout];
    
    htmlHeight = [NSAttributedString getHTMLHeightWithWidth:CGRectGetWidth(self.view.bounds) - 20 withString:_model.aboutTheCourse];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup layout

- (void)reloadLayout {
    
    CSStickyHeaderFlowLayout *layout = (id)_courseDetailCollectionView.collectionViewLayout;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, kMasterAvatarHeight);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, kMasterMinumAvatarHeight);
        layout.parallaxHeaderAlwaysOnTop = YES;
        layout.disableStickyHeaders = YES;
        layout.isOpenLeftModel = YES;
    }
}

#pragma mark - CollectionView Delegate && DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    
    if (section == 1) {
        return _model.instrucatorArray.count;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BasicCourseInfoCollectionViewCell *cell = (BasicCourseInfoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kWorkLoadCellID forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.categoryLabel.text = @"Language:";
            cell.contentLabel.text = _model.language;
        }
        if (indexPath.row == 1) {
            cell.categoryLabel.text = @"Workload:";
            cell.contentLabel.text = _model.estimatedClassWorkload;
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        InstructorCollectionViewCell *instructorCell = [collectionView dequeueReusableCellWithReuseIdentifier:kInstructorID forIndexPath:indexPath];
        [instructorCell configureInstructorCellWithInstructorModel:_model.instrucatorArray[indexPath.row]];
        
        return instructorCell;
    }
    
    AboutCourseCollectionViewCell *aboutCell = [collectionView dequeueReusableCellWithReuseIdentifier:kAboutCourseID forIndexPath:indexPath];
    [aboutCell configureAboutCourseCellWithHTMLString:_model.aboutTheCourse];
    return aboutCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        alwaysOnTopCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                             withReuseIdentifier:kStickyHeaderID
                                                                    forIndexPath:indexPath];
        alwaysOnTopCell.delegate = self;
        alwaysOnTopCell.courseShortNameLabel.text = _model.shortName;
        if (_model.universityArray.firstObject) {
            UniversityModel *university = _model.universityArray.firstObject;
            alwaysOnTopCell.universityNameLabel.text = university.shortName;
        }
        [alwaysOnTopCell.courseImageView yy_setImageWithURL:[NSURL URLWithString:_model.largeIcon] placeholder:nil];
        
        return alwaysOnTopCell;
    }
    
    return nil;
    
}

#pragma mark - FlowLayout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(CGRectGetWidth(self.view.bounds) - 20, 44);
    }
    
    if (indexPath.section == 1) {
        return CGSizeMake(100, 150);
    }
    
    return CGSizeMake(CGRectGetWidth(self.view.bounds) - 20, htmlHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollRatio =  scrollView.contentOffset.y/(kMasterAvatarHeight - kMasterMinumAvatarHeight);
    alwaysOnTopCell.blurView.alpha = scrollRatio;
}

#pragma mark - Status Bar 

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - TopCell Delegate

- (void)playButtonDidClick:(UIButton *)button
{
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"xZpuzS1jJns"];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];

}


- (void)backButtonDidClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
