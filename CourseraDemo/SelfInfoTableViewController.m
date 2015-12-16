//
//  SelfInfoTableViewController.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/16.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "SelfInfoTableViewController.h"
#import "CourseTableViewCell.h"
#import "Realm.h"
#import "CourseDetailModel.h"
#import "UIStoryboard+LoadDetailViewController.h"

static NSString * const kCourseTableViewCell = @"kCourseTableViewCell";
static NSString * const kSelfInfoCellID = @"kSelfInfoCellID";

@interface SelfInfoTableViewController ()<CourseTableViewCellDelegate>
{
    RLMResults<CourseDetailModel *> *dataQueryResults;
}

@end

@implementation SelfInfoTableViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CourseTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCourseTableViewCell];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dataQueryResults = [CourseDetailModel objectsWhere:@"subscribe = YES"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    dataQueryResults = [CourseDetailModel objectsWhere:@"subscribe = YES"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [dataQueryResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *selfInfoCell = [tableView dequeueReusableCellWithIdentifier:kSelfInfoCellID];
        return selfInfoCell;
    }
    
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCourseTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell configureCourseTableViewCellWithCourseDetailModel:dataQueryResults[indexPath.row] withIndex:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *detail = [UIStoryboard loadCourseDetailViewController];
    detail.model = dataQueryResults[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - CourseCellTableView Delegate

- (void)subscribleButtonDidClick:(BOOL)subscrible withIndex:(NSIndexPath *)indexPath
{
    if (!subscrible) {
        [self.tableView beginUpdates];
        dataQueryResults = [CourseDetailModel objectsWhere:@"subscribe = YES"];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
