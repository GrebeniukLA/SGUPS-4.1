//
//  LANewsTableViewController.m
//  schedule
//
//  Created by Leonid Grebenyuk on 29/09/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LASectionViewController.h"
#import "LASectionLessonViewController.h"
#import "LAMoreInfoViewController.h"

#import "LAServerManager.h"

#import "LAConstants.h"

#import "LASection.h"
#import "LAMainNewsTableViewCell.h"

#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIImageView+AFNetworking.h"
#import "NSUserDefaults+NSUserDefaultsExtensions.h"
#import "UIView+UITableViewCell.h"
#import "LAMoreInfoButto.h"



#import "LARssData.h"
#import "LARssDoc.h"
#import "LARssDatabase.h"
#import "RSSParser.h"
#import "RSSItem.h"


@interface LASectionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray *array;



@property (nonatomic,retain) UIRefreshControl *refreshControl;
@end

@implementation LASectionViewController




-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)internetConnected {
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:kSectionJSONDataNotification object:nil];
    
    
    [self loadJson];
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reLoadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    [self setTitle:@"Loading..."];
    
    
}

-(void) reLoadData {
    [[LAServerManager sharedManager] getDataFromSection];
}

-(void) loadJson{
    if ([Settings loadCustomObjectWithKey:kSectionJSONDataNotification]) {
        NSArray *array= [Settings loadCustomObjectWithKey:kSectionJSONDataNotification];
        self.array =array;
        [self.tableView reloadData];
        return;
    }
    
    [[LAServerManager sharedManager] getDataFromSection];
    
}


-(void) dataReceived:(NSNotification*) notification {
    [self.refreshControl endRefreshing];
    self.array =[notification.userInfo objectForKey:kSectionJSONDataNotification];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Факультативы";
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"LAMainNewsTableViewCell";
    
    LAMainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LAMainNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
     LASection* groups = self.array[indexPath.row];
    
    cell.titleLabel.text =groups.nameGroup;
    
    if (![groups.moreInfo isEqual:@""]) {
        [cell.detailButton setHidden:NO];
        cell.detailButton.moreInfo = groups.moreInfo;
        cell.detailButton.nameSection = groups.nameGroup;
    } else {
        [cell.detailButton setHidden:YES];
    }
    
    
    return cell;
    
}




#pragma mark -  UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyboard = self.storyboard;
    LASectionLessonViewController * detailController = [storyboard instantiateViewControllerWithIdentifier: @"LASectionLessonViewController"];
    
    [detailController setSection:[self.array objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailController animated:YES];
    
}

#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionReload:(id)sender {
        [[LAServerManager sharedManager] getDataFromSection];
}

- (IBAction)moreInfoAction:(LAMoreInfoButto*)sender
{
    
    UIStoryboard * storyboard = self.storyboard;
    LAMoreInfoViewController * NextController = [storyboard instantiateViewControllerWithIdentifier: @"LAMoreInfoViewController"];
    
    NextController.moreInfo = sender.moreInfo;
    NextController.nameSection = sender.nameSection;
    
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController: NextController animated: NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
}

@end
