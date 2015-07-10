//
//  LADetailViewController.h
//  RssReader
//
//  Created by Leonid Grebenyuk on 28/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSItem.h"

#import <Social/Social.h>

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>




@interface LADetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (assign,nonatomic) RSSItem *item;

@end
