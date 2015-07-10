//
//  LATeachersViewController.m
//  schedule
//
//  Created by Dev on 29/1/15.
//  Copyright (c) 2015 stu. All rights reserved.
//



#import "LATeachersViewController.h"

#import "LATeachersDetailViewController.h"

#import "LAServerManager.h"


#import "LAConstants.h"

#import "LATeachers.h"
#import "LAMainNewsTableViewCell.h"

#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIImageView+AFNetworking.h"
#import "NSUserDefaults+NSUserDefaultsExtensions.h"
#import "LARssData.h"
#import "LARssDoc.h"
#import "LARssDatabase.h"
#import "RSSParser.h"
#import "RSSItem.h"

@interface LATeachersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,retain) UIRefreshControl *refreshControl;

@property (strong,nonatomic) NSArray *array;

@end

@implementation LATeachersViewController


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)internetConnected {
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
    [self.tableView reloadData];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:kTeacherJSONDataNotification object:nil];
    
    
    [self loadJson];
    
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reLoadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    [self setTitle:@"Loading..."];
}

-(void) reLoadData {
    
    [[LAServerManager sharedManager] getDataFromTeachersJSON];
    
}

-(void) loadJson{
    if ([Settings loadCustomObjectWithKey:kTeacherJSONDataNotification]) {
        NSArray *array= [Settings loadCustomObjectWithKey:kTeacherJSONDataNotification];
        self.array =array;
        [self.tableView reloadData];
        return;
    }
    
    [[LAServerManager sharedManager] getDataFromTeachersJSON];
    
}


-(void) dataReceived:(NSNotification*) notification {
    [self.refreshControl endRefreshing];
    self.array =[notification.userInfo objectForKey:kTeacherJSONDataNotification];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  self.array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"Преподаватели";
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString* identifier = @"LAMainNewsTableViewCell";
    
    LAMainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LAMainNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
        cell.titleLabel.text =[self dataFor:indexPath];
        return cell;

    return cell;
    
}


-(NSString*) dataFor:(NSIndexPath *)indexPath {
    
    LATeachers * groups = self.array[indexPath.row];
    
    return groups.nameTeacher;
    
}

#pragma mark -  UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LATeachers * teacher = self.array[indexPath.row];
    
    
    VKRequest *commentRequest = [VKRequest requestWithMethod:@"wall.getComments" andParameters:@{@"owner_id" : @(-62102396),
                                                                                              @"post_id" : @(teacher.numberVK)
                                                    
                                                                                              } andHttpMethod:@"GET" classOfModel:[VKUsersArray class]];
    
    

    
    NSString *postsString = [NSString stringWithFormat:@"-62102396_%li",(long)teacher.numberVK];
    
    VKRequest *wallRequest = [VKRequest requestWithMethod:@"wall.getById" andParameters:@{@"posts" : postsString,
                                                                                              @"extended" : @(1),
                                                                                            
                                                                                              
                                                                                              } andHttpMethod:@"GET" classOfModel:[VKUsersArray class]];
    
    
    
    UIStoryboard * storyboard = self.storyboard;
    LATeachersDetailViewController * detailController = [storyboard instantiateViewControllerWithIdentifier: @"LATeachersDetailViewController"];
    [detailController setTeacher:[self.array objectAtIndex:indexPath.row]];
    
    detailController.callingRequestWall = wallRequest;
    detailController.callingRequestComments = commentRequest;
    
    [self.navigationController pushViewController:detailController animated:YES];
    
}


#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    self.array = [self generateSectionsFromArray:[Settings loadCustomObjectWithKey:kTeacherJSONDataNotification] withFilter:searchText];
    [self.tableView reloadData];
    
}


- (NSArray*) generateSectionsFromArray:(NSArray*) array withFilter:(NSString*) filterString {
    
    NSMutableArray* tempArray = [NSMutableArray array];

    for (int i=0; i < array.count; i++) {
        
        LATeachers *group = array[i];
        if ([filterString length] > 0 && [group.nameTeacher rangeOfString:filterString options:NSCaseInsensitiveSearch].location == NSNotFound) {
            
        } else {
            [tempArray addObject:group];
        }
    }
    return tempArray;
}


#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionReload:(id)sender {
    [[LAServerManager sharedManager] getDataFromTeachersJSON];
    
}
@end
