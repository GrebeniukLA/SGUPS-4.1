//
//  LASectionLesson.h
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LASectionLesson : NSObject <NSCoding>



@property (nonatomic) NSInteger dayOfWeek;
@property (nonatomic) NSString* time;
@property (strong, nonatomic) NSString *lesson;
@property (strong, nonatomic) NSString *audience;
@property (strong, nonatomic) NSString *teacher;

@end
