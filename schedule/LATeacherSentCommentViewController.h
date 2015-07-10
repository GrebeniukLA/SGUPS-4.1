//
//  LATeacherSentCommentViewController.h
//  schedule
//
//  Created by Dev on 2/2/15.
//  Copyright (c) 2015 stu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LATeachers.h"

@interface LATeacherSentCommentViewController : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) LATeachers * teacher;
@end
