//
//  LALessonsTableViewController.h
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 02/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAGroups.h"



@interface LALessonsTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) LAGroups * group;
@property (nonatomic) BOOL myGroup;


@end
