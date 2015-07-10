//
//  LA.h
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 02/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LALesson : NSObject <NSCoding>


@property  (nonatomic) NSInteger numberWeek;
@property (nonatomic) NSInteger dayOfWeek;
@property (nonatomic) NSInteger numberLesson;
@property (strong, nonatomic) NSString *lesson;
@property (strong, nonatomic) NSString *audience;
@property (strong, nonatomic) NSString *teacher;

@end
