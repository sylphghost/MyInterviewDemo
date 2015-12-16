//
//  HomePageViewController.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseListViewController.h"
#import "CourseDetailModel+Request.h"
#import "NSObject+YYModel.h"
#import "CourseListCollectionViewCell.h"
#import "Realm.h"
#import "SVProgressHUD.h"
#import "CourseDetailViewController.h"
#import "InstrouctorModel+Request.h"
#import "FirstLoadView.h"

static NSString * const kCourseListCellID = @"kCourseListCellID";
static NSString * const kPushToDetailPage = @"kPushToDetailPage";

static NSString * const kFirstLoad = @"kFirstLoad";

@interface CourseListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CourseListCollectionViewCellDelegate>
{
    BOOL isShowAnimation;
    BOOL isExpired;
    
    NSMutableDictionary *flipIndexDictionary;
    
    CGSize itemSize;
    
    RLMResults<CourseDetailModel *> *dataQueryResults;
    RLMRealm *writerRealm;
}

@property (weak, nonatomic) IBOutlet UICollectionView *courseListCollectionView;

@end

@implementation CourseListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isShowAnimation = YES;
    
    flipIndexDictionary = [NSMutableDictionary dictionary];
    
    CGFloat itemWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - 30)/2;
    itemSize = CGSizeMake(itemWidth, itemWidth * 5/3);
    
    dataQueryResults = [CourseDetailModel allObjects];
    if (dataQueryResults.count > 0) {
        CourseDetailModel *model = [dataQueryResults objectAtIndex:0];
        // if last fetch time more than 10 minutes, expired is yes
        if (([model.timestamps floatValue] - [[NSDate date] timeIntervalSince1970])/60 > 10) {
            isExpired  = YES;
        }else
        {
            isExpired = NO;
        }
    }
    
    writerRealm = [RLMRealm defaultRealm];
    
    [self fetchCourseData];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kFirstLoad]) {
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kFirstLoad];
        FirstLoadView *view = [[[NSBundle mainBundle] loadNibNamed:@"FirstLoadView" owner:nil options:nil] lastObject];
        view.frame = self.view.bounds;
        [self.view addSubview:view];
    }
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_courseListCollectionView reloadData];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate && DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataQueryResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCourseListCellID forIndexPath:indexPath];
    
    cell.delegate = self;
    NSNumber *flipValue = flipIndexDictionary[[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    
    BOOL isFlip = NO;
    if (!flipValue) {
        isFlip = NO;
    }else
    {
        isFlip = [flipValue boolValue];
    }
    
    [cell configureCourseListCellWithCourseDetail:[dataQueryResults objectAtIndex:indexPath.row]
                                        withIndex:indexPath withFliped:isFlip];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    static CGFloat initialDelay = 0.2f;
    static CGFloat stutter = 0.06f;
    
    if (isShowAnimation) {
        CourseListCollectionViewCell *cardCell = (CourseListCollectionViewCell *)cell;
        [cardCell startAnimationWithDelay:initialDelay + ((indexPath.row) * stutter)];
        if (indexPath.row == 3) {
            isShowAnimation = NO;
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kPushToDetailPage sender:indexPath];
}

#pragma mark - Private Method

- (void)fetchCourseData
{
    [SVProgressHUD show];
    if (dataQueryResults.count > 0 && !isExpired) {
        [_courseListCollectionView reloadData];
        [SVProgressHUD dismiss];
    }else{
        [CourseDetailModel fetchCourseListWithCompletionBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [writerRealm beginWriteTransaction];
            
            [responseObject[@"elements"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = (NSDictionary *)obj;
                CourseDetailModel *model = [CourseDetailModel yy_modelWithDictionary:dict];
                
                NSArray *universityIDArray = dict[@"links"][@"universities"];
                NSArray *instructorIDArray = dict[@"links"][@"instructors"];
                for (NSNumber *universityID in universityIDArray) {
                    
                    UniversityModel *universityModel = [[UniversityModel alloc] init];
                    universityModel.universityID = [universityID integerValue];
                    [model.universityArray addObject:universityModel];
                }
                
                for (NSNumber *instructorID in instructorIDArray) {
                    
                    InstrouctorModel *instructorModel = [[InstrouctorModel alloc] init];
                    instructorModel.instructorID = [instructorID integerValue];
                    [model.instrucatorArray addObject:instructorModel];
                }

                model.timestamps = @([[NSDate date] timeIntervalSince1970]);
                
                [CourseDetailModel createOrUpdateInRealm:writerRealm withValue:model];
            }];
            
            [responseObject[@"linked"][@"universities"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = (NSDictionary *)obj;
                UniversityModel *universityModel = [[UniversityModel alloc] init];
                universityModel.universityID = [dict[@"id"] integerValue];
                universityModel.shortName = dict[@"shortName"];
                
                [UniversityModel createOrUpdateInDefaultRealmWithValue:universityModel];
            }];
            
            [writerRealm commitWriteTransaction];
            
            dataQueryResults = [CourseDetailModel allObjects];
            [_courseListCollectionView reloadData];
            [SVProgressHUD dismiss];
        } WithFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD dismiss];
        }];
        
        [InstrouctorModel fetchInstrouctorListWithCompletionBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [writerRealm beginWriteTransaction];
            
            [responseObject[@"elements"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = (NSDictionary *)obj;
                InstrouctorModel *model = [InstrouctorModel yy_modelWithDictionary:dict];
                
                [InstrouctorModel createOrUpdateInRealm:writerRealm withValue:model];
            }];
            
            [writerRealm commitWriteTransaction];
        } WithFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }

}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    CourseDetailViewController *detailVC = (CourseDetailViewController *)segue.destinationViewController;
    detailVC.model = [dataQueryResults objectAtIndex:indexPath.row];
}

#pragma mark - CourseListCell Delegate

- (void)cellDidFlip:(BOOL)isFlip withIndexPath:(NSIndexPath *)indexPath
{
    [flipIndexDictionary setValue:@(isFlip) forKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    
//    NSNumber *flipValue = flipIndexDictionary[[NSString stringWithFormat:@"%d", (int)indexPath.row]];
//    
//    BOOL isFlipValue = NO;
//    if (!flipValue) {
//        isFlipValue = NO;
//    }else
//    {
//        isFlipValue = [flipValue boolValue];
//    }
//    return isFlipValue;
}

@end
