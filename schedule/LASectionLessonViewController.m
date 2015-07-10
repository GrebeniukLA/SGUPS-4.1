//
//  LASectionLessonViewController.m
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//
#import "LALessonsTableViewController.h"
#import "LAServerManager.h"
#import "LALessonTableViewCell.h"

#import "LAConstants.h"

#import "LASectionLesson.h"
#import "NSUserDefaults+NSUserDefaultsExtensions.h"
#import "LAScheduleDayWeeks.h"

#import "LASectionLessonViewController.h"
#import "LANumberOfWeek.h"

@interface LASectionLessonViewController ()

@property (strong,nonatomic) NSArray *daysOfWeek;
@property (strong,nonatomic) NSArray *schedule;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (nonatomic) NSInteger currentDayOfWeek;

@property (nonatomic,strong) UIRefreshControl *refreshControl;


@end

@implementation LASectionLessonViewController


-(NSInteger) currentDayOfWeek {
    
    _currentDayOfWeek = [LANumberOfWeek caclculateDayOfWeek];
    return _currentDayOfWeek;
}

-(NSArray *) schedule {
    if (!_schedule) {
        _schedule = [NSArray array];
    }
    return _schedule;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titelLabel.text = self.section.nameGroup;
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    self.daysOfWeek = @[@"Понедельник",@"Вторник",@"Среда",@"Четверг",@"Пятница",@"Суббота"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:self.section.fileGroup object:nil];

    [self loadJson];
    
    
}

-(void) loadJson{
    if ([Settings loadCustomObjectWithKey:self.section.fileGroup]) {
        NSArray *array= [Settings loadCustomObjectWithKey:self.section.fileGroup];
        self.schedule = [LAScheduleDayWeeks scheduleDayWeeksFromArray:array];
        [self.tableView reloadData];
        return;
    }
    
    [[LAServerManager sharedManager] getDataFromSectionLesson:self.section.fileGroup];
    
}

-(void) dataReceived:(NSNotification*) notification {
    
    [self.refreshControl endRefreshing];
    NSArray* array  =[notification.userInfo objectForKey:self.section.fileGroup];
    self.schedule = [LAScheduleDayWeeks scheduleDayWeeksFromArray:array];
    [self.tableView reloadData];
    
}



#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray* day;
    if (self.schedule.count>0) {
        day = self.schedule[section];
        return [day count];
    }
    
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * str = self.daysOfWeek[section];
    NSString * strNow  = [NSString stringWithFormat:@"%@ (сегодня)", self.daysOfWeek[section]];
    return section==self.currentDayOfWeek ? strNow: str;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* identifier = @"LALessonTableViewCell";
    
    LALessonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LALessonTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    NSArray* day = self.schedule[indexPath.section];
    
    LASectionLesson * lesson = day[indexPath.row];
    
    cell.lessonLabel.text =lesson.lesson;
    cell.audienceLabel.text =lesson.audience;
    cell.teacherLabel.text =lesson.teacher;
    cell.timeLabel.text =lesson.time;
    
    return cell;
    
}



#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)reloadAction:(id)sender {
    
    [[LAServerManager sharedManager] getDataFromSectionLesson:self.section.fileGroup];
}

@end
