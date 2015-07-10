//
//  LASectionLessonViewController.h
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LASection.h"



@interface LASectionLessonViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) LASection * section;

@end
