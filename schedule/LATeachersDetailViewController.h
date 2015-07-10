//
//  LATeachersDetailViewController.h
//  schedule
//
//  Created by Dev on 30/1/15.
//  Copyright (c) 2015 stu. All rights reserved.
//
#import <VKSdk.h>
#import <UIKit/UIKit.h>
#import "LATeachers.h"


@interface LATeachersDetailViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource, VKSdkDelegate>

@property (strong, nonatomic) LATeachers * teacher;
@property (nonatomic, strong) VKRequest * callingRequestComments;
@property (nonatomic, strong) VKRequest * callingRequestWall;

@end
