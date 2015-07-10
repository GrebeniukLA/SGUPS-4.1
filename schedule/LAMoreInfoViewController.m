//
//  LAMoreInfoViewController.m
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAMoreInfoViewController.h"

@interface LAMoreInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation LAMoreInfoViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.moreInfoTextView setText:self.moreInfo];
    [self.titleLabel setText:self.nameSection];
}

- (IBAction)actionBack:(id)sender {
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    [self.navigationController popViewControllerAnimated:NO];
    [UIView commitAnimations];
}




@end
