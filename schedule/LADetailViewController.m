//
//  LADetailViewController.m
//  RssReader
//
//  Created by Leonid Grebenyuk on 28/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LADetailViewController.h"
#import "LAWebViewViewController.h"


@interface LADetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;
@property (nonatomic,strong) UIWebView *tempWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end

@implementation LADetailViewController

#pragma mark Parse
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSString *html = [self.tempWebView stringByEvaluatingJavaScriptFromString: @"document.getElementById('bodycontent').textContent"];

    [self testParse:html];
    [self.indicator stopAnimating];

}

-(void) testParse:(NSString*) responseString{
    
    NSString *unique_start = @">";
    
    //    NSString *unique_start = @" Новости университета";
    NSRange i = [responseString rangeOfString:unique_start];
    
    
    if(i.location != NSNotFound)
    {
        NSString *weather = [responseString substringFromIndex:(i.location + unique_start.length)];
        NSString *unique_end = @"if";
        
        NSString *unique_end2 = @"Возврат к списку";
        NSRange j1 = [weather rangeOfString:unique_end];
        NSRange j2 = [weather rangeOfString:unique_end2];
        
        NSRange j = j1.location<j2.location ? j1 : j2;
        
        if (j.location != NSNotFound) {
            
            weather = [weather substringToIndex:j.location];
        }
        
        if ([self deletedataFromString:weather]) {
            weather =[self deletedataFromString:weather];
        }
        
        [self.articleWebView loadHTMLString:weather baseURL:nil];
        

    } else {
        NSLog(@"strings not found");
    }
}

-(NSString*) deletedataFromString: (NSString*) string {
    
    NSRange i = [string rangeOfString:@".2014"];
    
    if(i.location != NSNotFound) {
        NSString*  startString = [string substringToIndex:(i.location -5)];
        NSString*  endString = [string substringFromIndex:(i.location +5)];
        
        string = [startString  stringByAppendingString:endString];
        
    } else {
        return nil;
    }
    
    return string;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.indicator startAnimating];
    self.indicator.hidesWhenStopped= YES;
    
    self.titleLable.text = self.item.title;
    
    
    self.tempWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    

    [self.tempWebView loadRequest:[NSURLRequest requestWithURL:self.item.link]];
    self.tempWebView.delegate = self;
}






- (void)showActionSheet
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Send To" delegate:self cancelButtonTitle:@"Cancel"  destructiveButtonTitle:nil otherButtonTitles:@"Mail",@"SMS", @"Facebook", @"Twitter", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleAutomatic;
	[popupQuery showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Mail"]) {
        
        MFMailComposeViewController *picker=[[MFMailComposeViewController alloc]init];
        [picker setMailComposeDelegate:self];
        if ([MFMailComposeViewController canSendMail]) {
            
            [picker setSubject:@"Read this news!"];
            
            [picker setMessageBody:[self.item.link absoluteString] isHTML:YES];
            
            [picker setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:picker animated:YES completion:nil];
            
        }
    }
    
    
    if ([buttonTitle isEqualToString:@"SMS"]) {
        
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = [self.item.link absoluteString];
            controller.recipients = [NSArray arrayWithObjects: nil];
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }
    
    if ([buttonTitle isEqualToString:@"Facebook"])
    {
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
        {
            SLComposeViewController *mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
            mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
            [mySLComposerSheet setInitialText:self.item.description]; //the message you want to post
            [mySLComposerSheet addURL:self.item.link];
            
            //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
            [self presentViewController:mySLComposerSheet animated:YES completion:nil];
            
            [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Action Cancelled";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Post Successfull";
                        break;
                    default:
                        break;
                } //check if everythink worked properly. Give out a message on the state.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }];
            
        }
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Not found the account settings Facebook. Check the system Settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    if ([buttonTitle isEqualToString:@"Twitter"]) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Read this news:"]];
            
            [mySLComposerSheet addURL:self.item.link];
            
            [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        NSLog(@"Post Canceled");
                        break;
                    case SLComposeViewControllerResultDone:
                        NSLog(@"Post Sucessful");
                        break;
                        
                    default:
                        break;
                }
            }];
            
            [self presentViewController:mySLComposerSheet animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"Not found the account settings Twitter. Check the system Settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    
}


#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    
    if (result == MessageComposeResultFailed) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error"] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark action

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareAction:(id)sender {
    [self showActionSheet];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LAWebViewViewController"])
    {
        
        LAWebViewViewController *controller = [segue destinationViewController];
        controller.webLink = self.item.link;
    }
}

@end
