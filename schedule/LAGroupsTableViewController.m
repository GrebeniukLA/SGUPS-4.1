//
//  LANewsTableViewController.m
//  schedule
//
//  Created by Leonid Grebenyuk on 29/09/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAGroupsTableViewController.h"
#import "LALessonsTableViewController.h"

#import "LAServerManager.h"

#import "LAConstants.h"

#import "LAGroups.h"
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


@interface LAGroupsTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSArray *array;
@property (strong,nonatomic) NSString *myGroup;




@property (nonatomic,retain) UIRefreshControl *refreshControl;
@end

@implementation LAGroupsTableViewController




-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)internetConnected {
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.myGroup = [Settings objectForKey:@"myGroup"];

    [self.tableView reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myGroup = [Settings objectForKey:@"myGroup"];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:kGroupJSONDataNotification object:nil];
    
    
    [self loadJson];
    
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reLoadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    
    
    [self setTitle:@"Loading..."];
    
    
}

-(void) reLoadData {
    
    [[LAServerManager sharedManager] getDataFromGroupJSON];
    
}

-(void) loadJson{
    if ([Settings loadCustomObjectWithKey:kGroupJSONDataNotification]) {
        NSArray *array= [Settings loadCustomObjectWithKey:kGroupJSONDataNotification];
        self.array =array;
        [self.tableView reloadData];
        return;
    }
    
    [[LAServerManager sharedManager] getDataFromGroupJSON];
    
}


-(void) dataReceived:(NSNotification*) notification {
    [self.refreshControl endRefreshing];
    self.array =[notification.userInfo objectForKey:kGroupJSONDataNotification];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.myGroup? 2:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.myGroup) {
        return self.array.count;
    }
    return section==1? self.array.count: 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.myGroup) {
        return @"Группы";
    }
    return section==1? @"Группы": @"Моя Группа";
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString* identifier = @"LAMainNewsTableViewCell";
    
    LAMainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LAMainNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    if (!self.myGroup) {
        cell.titleLabel.text =[self dataFor:indexPath];
        return cell;
    }
    
    if (indexPath.section==1) {
        cell.titleLabel.text =[self dataFor:indexPath];
    } else {
        cell.titleLabel.text =self.myGroup;
    }
    
    return cell;
    
}


-(NSString*) dataFor:(NSIndexPath *)indexPath {
    
    LAGroups* groups = self.array[indexPath.row];
    
    return groups.nameGroup;
    
}

#pragma mark -  UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyboard = self.storyboard;
    LALessonsTableViewController * detailController = [storyboard instantiateViewControllerWithIdentifier: @"LALessonsTableViewController"];
    if (!self.myGroup) {
        [detailController setGroup:[self.array objectAtIndex:indexPath.row]];
    } else {
        if (indexPath.section==0) {
            [detailController setGroup:[Settings loadCustomObjectWithKey:@"favouriteGroup"]];
            detailController.myGroup = YES;
        } else {
            [detailController setGroup:[self.array objectAtIndex:indexPath.row]];
        }
        
        
    }
    
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
    
    self.array = [self generateSectionsFromArray:[Settings loadCustomObjectWithKey:kGroupJSONDataNotification] withFilter:searchText];
    
    //  NSLog(@"textDidChange %@", self.schoolsArray);
    [self.tableView reloadData];
    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    
    //   NSLog(@"clicked");
}

- (NSArray*) generateSectionsFromArray:(NSArray*) array withFilter:(NSString*) filterString {
    
    NSMutableArray* tempArray = [NSMutableArray array];
    
    
    
    for (int i=0; i < array.count; i++) {
        
        LAGroups *group = array[i];
        if ([filterString length] > 0 && [group.nameGroup rangeOfString:filterString options:NSCaseInsensitiveSearch].location == NSNotFound) {
            
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
        [[LAServerManager sharedManager] getDataFromGroupJSON];
    
}


@end
