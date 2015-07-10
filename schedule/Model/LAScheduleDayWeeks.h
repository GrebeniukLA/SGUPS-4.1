//
//  LAScheduleDayWeeks.h
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 04/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAScheduleDayWeeks : NSObject

+ (NSArray *)scheduleDayWeeksFromArray:(NSArray *)array forWeek: (NSInteger) numberWeek;

+ (NSArray *)scheduleDayWeeksFromArray:(NSArray *)array;

@end
