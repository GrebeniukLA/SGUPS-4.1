//
//  LALessonsTableViewController.m
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 02/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LALessonsTableViewController.h"
#import "LAServerManager.h"
#import "LALessonTableViewCell.h"

#import "LAConstants.h"

#import "LALesson.h"
#import "NSUserDefaults+NSUserDefaultsExtensions.h"
#import "LAScheduleDayWeeks.h"
#import "LANumberOfWeek.h"

@interface LALessonsTableViewController ()

@property (strong,nonatomic) NSArray *timeLessons;
@property (strong,nonatomic) NSArray *daysOfWeek;
@property (strong,nonatomic) NSArray *schedule;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstWeekButton;
@property (weak, nonatomic) IBOutlet UIButton *secondWeekButton;
@property (nonatomic) NSInteger currentWeek;
@property (nonatomic) NSInteger currentDayOfWeek;
@property (nonatomic) NSInteger currentNumberLesson;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;



@property (nonatomic,strong) UIRefreshControl *refreshControl;


@end

@implementation LALessonsTableViewController



-(NSArray *) schedule {
    if (!_schedule) {
        _schedule = [NSArray array];
    }
    return _schedule;
}

-(NSInteger) currentDayOfWeek {
    
    _currentDayOfWeek = [LANumberOfWeek caclculateDayOfWeek];
    

    return _currentDayOfWeek;
}

-(NSInteger) numberOfLessons {
    NSArray* day;
    if (self.schedule.count>0) {
        day = self.schedule[0];
        return [day count]-1;
    }
    return 0;
}

-(NSInteger) currentNumberLesson {
    
    NSInteger realTimeLesson = [LANumberOfWeek caclculateNumberOfLesson];
    _currentNumberLesson = MIN(realTimeLesson, [self numberOfLessons]);
    
    return _currentNumberLesson;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.favouriteButton setSelected:self.myGroup];
    self.titelLabel.text = self.group.nameGroup;
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    self.currentWeek =[LANumberOfWeek caclculate];
    self.currentWeek == 1 ?   [self.firstWeekButton setSelected:YES] :  [self.secondWeekButton setSelected:YES];
    
    self.timeLessons = @[@"8.30 - 10.00",@"10.15 - 11.45",@"12.00 - 13.30",@"14.10 - 15.40",@"15.55 - 17.25",@"17.40 - 19.10",@"19.25 - 20.55"];
    
    self.daysOfWeek = @[@"Понедельник",@"Вторник",@"Среда",@"Четверг",@"Пятница",@"Суббота"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:kLessonJSONDataNotification object:nil];
    
    [self loadJson];
    
    
}





-(void) loadJson{
    if ([Settings loadCustomObjectWithKey:self.group.fileGroup]) {
        NSArray *array= [Settings loadCustomObjectWithKey:self.group.fileGroup];
        self.schedule = [LAScheduleDayWeeks scheduleDayWeeksFromArray:array forWeek:self.currentWeek];
        [self.tableView reloadData];
        
        if (self.currentDayOfWeek>0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentNumberLesson inSection:self.currentDayOfWeek];

            

        
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionMiddle];
                    }
        return;
    }
    
    [[LAServerManager sharedManager] getDataFromLesson:self.group.fileGroup];
    
}

-(void) dataReceived:(NSNotification*) notification {
    
    [self.refreshControl endRefreshing];
    
    NSArray* array  =[notification.userInfo objectForKey:kLessonJSONDataNotification];
    
    self.schedule = [LAScheduleDayWeeks scheduleDayWeeksFromArray:array forWeek:self.currentWeek];
    
    
    
    [self.tableView reloadData];
            if (self.currentDayOfWeek>0) {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentNumberLesson inSection:self.currentDayOfWeek];
    
    
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionMiddle];
            }
    
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
    
    LALesson* lesson = day[indexPath.row];
    
    cell.lessonLabel.text =lesson.lesson;
    cell.audienceLabel.text =lesson.audience;
    cell.teacherLabel.text =lesson.teacher;
    cell.timeLabel.text =self.timeLessons[lesson.numberLesson-1];

    [cell.picImage setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%li.png",(long)lesson.numberLesson]]];
    
    return cell;
    
}




#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)reloadAction:(id)sender {
    
    [[LAServerManager sharedManager] getDataFromLesson:self.group.fileGroup];
}

- (IBAction)firstWeekAction:(id)sender {
    self.currentWeek =1;
    [self.firstWeekButton setSelected:YES];
    [self.secondWeekButton setSelected:NO];
    [self loadJson];
}

- (IBAction)secondWeekAction:(id)sender {
    self.currentWeek =2;
    [self.firstWeekButton setSelected:NO];
    [self.secondWeekButton setSelected:YES];
    [self loadJson];
}

- (IBAction)favourite:(UIButton*)sender {
    if (sender.isSelected) {
        [sender setSelected:NO];
          [Settings setObject:nil forKey:@"myGroup"];
    }else {
        [sender setSelected:YES];
        [Settings setObject:self.group.nameGroup forKey:@"myGroup"];
        [Settings saveCustomObject:self.group key:@"favouriteGroup"];
        
    }
}


@end
