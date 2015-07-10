//
//  LANewsTableViewController.m
//  schedule
//
//  Created by Leonid Grebenyuk on 29/09/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LANewsTableViewController.h"
#import "LADetailViewController.h"

#import "LAServerManager.h"

#import "LAConstants.h"

#import "LAMainNews.h"
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


@interface LANewsTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray *daysOfWeek;
@property (strong,nonatomic) NSArray *newsArray;

@property (nonatomic,strong) NSMutableArray *dataNews;
@property (nonatomic,strong) NSMutableArray *titlesForSection;

@property (nonatomic,strong) UIRefreshControl *refreshControl;
@end

@implementation LANewsTableViewController

-(NSMutableArray *) dataNews {
    if (!_dataNews)  {
        _dataNews = [[NSMutableArray alloc] init];
    }
    return _dataNews;
}

-(NSMutableArray *) titlesForSection {
    if (!_titlesForSection)  {
        _titlesForSection = [[NSMutableArray alloc] init];
    }
    return _titlesForSection;
}


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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:kNewsJSONDataNotification object:nil];
    
    
    [self loadJson];
  
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(loadRss) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    

    [self setTitle:@"Loading..."];
    
 
}

-(void) loadRss{
    
      [[LAServerManager sharedManager] getDataFromNews];
    
}

-(void) loadJson{
    if ([Settings loadCustomObjectWithKey:kNewsJSONDataNotification]) {
        NSArray *array= [Settings objectForKey:kNewsJSONDataNotification];
        self.newsArray =array;
        [self loadRssOffline];
        return;
    }
    
    [[LAServerManager sharedManager] getDataFromNews];
    
}


- (void)loadRssOnLine
{
    
    [self deleteData];
    
    for (LAMainNews *mainNews in self.newsArray) {
        
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: mainNews.Link]];
        [RSSParser parseRSSFeedForRequest:req success:^(NSArray *feedItems) {
            
            [self setTitle:@"RSS"];

            [self.dataNews addObject:feedItems];
            [self.titlesForSection addObject:mainNews.Name];

            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
            
            LARssDoc *newDoc = [[LARssDoc alloc] initWithArray: feedItems andTitle:mainNews.Name];
            
            [newDoc saveData];
            
        } failure:^(NSError *error) {
//            UIAlertView *alert;
//            alert = [[UIAlertView alloc]
//                     initWithTitle:@"Error:" message:[NSString stringWithFormat:@"Error: %@",error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//            [alert show];
            
            [self.refreshControl endRefreshing];
            
        }];
        
    }
}
- (void)loadRssOffline
{
    [self setTitle:@"RSS - offline"];
    
    [self cleanArray];
    NSArray * array =[LARssDatabase loadDocs];
    
    
    for (LARssDoc* rssDoc in array) {
        
        [self.dataNews addObject:rssDoc.data.array];
        [self.titlesForSection addObject:rssDoc.data.title];
        
    }
    

    [self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
    
}

- (void) deleteData {
    
    NSArray * array =[LARssDatabase loadDocs];
    
    for (LARssDoc* rssDoc in array) {
        [rssDoc deleteDoc];
    }
    
    [self cleanArray];
    [self.tableView reloadData];
}

- (void)cleanArray {
    [self.dataNews removeAllObjects];
    [self.titlesForSection removeAllObjects];

}

-(void) dataReceived:(NSNotification*) notification {

    self.newsArray =[notification.userInfo objectForKey:kNewsJSONDataNotification];
     [self loadRssOnLine];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataNews.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *array = [[NSArray alloc] initWithArray:self.dataNews[section]];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  self.titlesForSection[section];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *array = [[NSArray alloc] initWithArray:self.dataNews[indexPath.section]];
    
    RSSItem *item = [array objectAtIndex:indexPath.row];
    
    static NSString* identifier = @"LAMainNewsTableViewCell";
    
    LAMainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LAMainNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.titleLabel.text =[item title];
    
    if (item.imageLink) {
        [cell.picImage setImageWithURL:[NSURL URLWithString:item.imageLink]
                        placeholderImage:[UIImage imageNamed:@"pic_news.png"]];
    }
    
    return cell;
    
}


-(NSString*) dataFor:(NSIndexPath *)indexPath {
    
    LAMainNews* lesson = self.newsArray[indexPath.row];

    
    return lesson.Name;
    
}

#pragma mark -  UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyboard = self.storyboard;
    LADetailViewController * detailController = [storyboard instantiateViewControllerWithIdentifier: @"LADetailViewController"];
    
    NSArray *array = [[NSArray alloc] initWithArray:self.dataNews[indexPath.section]];
    [detailController setItem:[array objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailController animated:YES];
    
    
}

#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionReload:(id)sender {
    [self loadRss];
}


@end
