//
//  LATeacherSentCommentViewController.m
//  schedule
//
//  Created by Dev on 2/2/15.
//  Copyright (c) 2015 stu. All rights reserved.
//

#import "LATeacherSentCommentViewController.h"
#import <VKSdk.h>

@interface LATeacherSentCommentViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *textViewComment;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLable;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@end

@implementation LATeacherSentCommentViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.teacherNameLable.text = self.teacher.nameTeacher;
     [self.navBar setBackgroundImage:[UIImage imageNamed:@"fon1.jpg"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary * navBarTitleTextAttributes =
  @{ NSForegroundColorAttributeName : [UIColor whiteColor],
     NSFontAttributeName            : [UIFont systemFontOfSize:14] };
    
    [self.navBar setTitleTextAttributes:navBarTitleTextAttributes];
    self.textViewComment.text=@"";
    [self.doneButton setEnabled:NO];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textViewComment becomeFirstResponder];
}


#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)txtView
{
   self.defaultLabel.hidden = ([txtView.text length] > 0);
        [self.doneButton setEnabled:([txtView.text length] > 0)];
}


#pragma mark Action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)doneAction:(id)sender {
    [self.textViewComment resignFirstResponder];

    VKRequest *postReq = [VKRequest requestWithMethod:@"wall.addComment" andParameters:@{@"owner_id" : @(-62102396),
                                                                                                 @"post_id" : @(self.teacher.numberVK),
                                                                                                 @"text" : self.textViewComment.text
                                                                                                 
                                                                                                 } andHttpMethod:@"POST" classOfModel:[VKUsersArray class]];
    postReq.attempts = 10;
    
    [postReq executeWithResultBlock:^(VKResponse * response) {

    } errorBlock:^(NSError * error) {
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        }
        else {
//            NSLog(@"VK error: %@", error);
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
