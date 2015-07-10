//
//  LALessonTableViewCell.h
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LALessonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonLabel;




@end
