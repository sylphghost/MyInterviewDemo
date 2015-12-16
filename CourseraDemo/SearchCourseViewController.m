//
//  SearchCourseViewController.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/15.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "SearchCourseViewController.h"
#import "CourseTableViewCell.h"
#import "UIStoryboard+LoadDetailViewController.h"

static NSString * const kCourseTableViewCell = @"kCourseTableViewCell";

@interface SearchCourseViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    RLMResults<CourseDetailModel *> *dataQueryResults;
}
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@end

@implementation SearchCourseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [_searchTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CourseTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCourseTableViewCell];
    _searchTableView.tableFooterView = [UIView new];
    _searchTableView.rowHeight = 87;
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Handler


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [dataQueryResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCourseTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.subScribleButton.hidden = YES;
    [cell configureCourseTableViewCellWithCourseDetailModel:dataQueryResults[indexPath.row] withIndex:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *detail = [UIStoryboard loadCourseDetailViewController];
    detail.model = dataQueryResults[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0) {
        dataQueryResults = [CourseDetailModel objectsWhere:@"name CONTAINS[c] %@", searchBar.text];
        [_searchTableView reloadData];
        
    }
    [searchBar resignFirstResponder];
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
