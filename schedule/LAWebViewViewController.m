//
//  LAWebViewViewController.m
//  schedule
//
//  Created by Leonid Grebenyuk on 02/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAWebViewViewController.h"

@interface LAWebViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myBrowser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation LAWebViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.indicator startAnimating];
    self.indicator.hidesWhenStopped= YES;
    [self.myBrowser loadRequest:[NSURLRequest requestWithURL:self.webLink]];
}



- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.indicator stopAnimating];
    
}

@end
