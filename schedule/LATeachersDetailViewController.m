//
//  LATeachersDetailViewController.m
//  schedule
//
//  Created by Dev on 30/1/15.
//  Copyright (c) 2015 stu. All rights reserved.
//

#import "LATeachersDetailViewController.h"
#import "LATeacherDetailTableViewCell.h"
#import "LAJSONParser.h"
#import "LATask.h"
#import "LATeacherDetailTableViewCell.h"
#import "LATeacherSentCommentViewController.h"

@interface LATeachersDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLable;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* arrayTasks;
@property (weak, nonatomic) IBOutlet UILabel *numberLikes;

@end

@implementation LATeachersDetailViewController
- (void)commentRequestGo {
    self.callingRequestComments.debugTiming = YES;
    self.callingRequestComments.requestTimeout = 10;
    [self.callingRequestComments executeWithResultBlock: ^(VKResponse *response) {
        
        NSMutableArray* mArray= [NSMutableArray arrayWithArray:self.arrayTasks] ;
        [mArray addObjectsFromArray:[LAJSONParser taskFromstring:response.responseString]];
        self.arrayTasks = mArray;
        
        [self.tableView reloadData];
        
    } errorBlock: ^(NSError *error) {
        NSLog(@"Error: %@", error);
        self.callingRequestComments = nil;
    }];
}

- (void)wallReqestGo {
    self.callingRequestWall.debugTiming = YES;
    self.callingRequestWall.requestTimeout = 10;
    [self.callingRequestWall executeWithResultBlock: ^(VKResponse *response) {
        
        //	    self.callingRequestWall = nil;
        
        self.arrayTasks = [LAJSONParser taskFromstring:response.responseString];
        LATask * parseObj=self.arrayTasks[0];
        NSNumber *count = [parseObj.likes objectForKey:@"count"];
        self.numberLikes.text = [NSString stringWithFormat:@"%@",count];
        [self.numberLikes setHidden:NO];
        [self.tableView reloadData];
        [self commentRequestGo];
    } errorBlock: ^(NSError *error) {
        NSLog(@"Error: %@", error);
        self.callingRequestWall = nil;
    }];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.numberLikes setHidden:YES];
    SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    self.teacherNameLable.text = self.teacher.nameTeacher;
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self wallReqestGo];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LATeacherSentCommentViewController"]) {
        LATeacherSentCommentViewController * controller = [segue destinationViewController];
        controller.teacher = self.teacher;
    }
}


#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LATeacherDetailTableViewCell *cell = [[LATeacherDetailTableViewCell alloc] init];
    LATask * parseObj=self.arrayTasks[indexPath.row];
    
    cell.textLabel.text = parseObj.text;
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height += 1;
    
    return height;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayTasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* identifier = @"LATeacherDetailTableViewCell";
    
    LATeacherDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LATeacherDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    LATask * parseObj=self.arrayTasks[indexPath.row];
    
    cell.textLabel.text = parseObj.text;
    
    
    return cell;
    
}

static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"LATeacherSentCommentViewController";
static NSArray  * SCOPE = nil;

#pragma mark VK
- (void)startWorking {
    
    NSLog(@"%@", [[VKSdk getAccessToken] userId]);
    [self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:self];
}

- (void)addLikesVK{
    
    NSLog(@"%@", [[VKSdk getAccessToken] userId]);
    
    VKRequest *postReq = [VKRequest requestWithMethod:@"likes.add" andParameters:@{@"owner_id" : @(-62102396),
                                                                                   @"item_id" : @(self.teacher.numberVK),
                                                                                   @"type" : @"post"
                                                                                   } andHttpMethod:@"POST" classOfModel:[VKUsersArray class]];
    postReq.attempts = 10;
    
    [postReq executeWithResultBlock:^(VKResponse * response) {
        
        NSNumber *count = [response.json objectForKey:@"likes"];
        self.numberLikes.text = [NSString stringWithFormat:@"%@",count];
        
    } errorBlock:^(NSError * error) {
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        }
        else {
            NSLog(@"VK error: %@", error);
        }
    }];
    
}


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [VKSdk authorize:SCOPE revokeAccess:YES];
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    [self startWorking];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token {
    [self startWorking];
}
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addComment:(id)sender {
    [VKSdk initializeWithDelegate:self andAppId:@"4744608"];
    if ([VKSdk wakeUpSession])
    {
        [self startWorking];
    } else {
        [VKSdk authorize:SCOPE revokeAccess:YES forceOAuth:YES];
    }
}
- (IBAction)addLike:(id)sender {
    [VKSdk initializeWithDelegate:self andAppId:@"4744608"];
    if ([VKSdk wakeUpSession])
    {
        [self addLikesVK];
    } else {
        [VKSdk authorize:SCOPE revokeAccess:YES forceOAuth:YES];
    }
}

@end
