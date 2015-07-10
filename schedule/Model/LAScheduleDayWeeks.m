//
//  LAScheduleDayWeeks.m
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 04/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LAScheduleDayWeeks.h"
#import "LALesson.h"



@implementation LAScheduleDayWeeks

+ (NSArray *)scheduleDayWeeksFromArray:(NSArray *)array forWeek: (NSInteger) numberWeek {
    
    NSMutableArray *monday = [NSMutableArray array];
    NSMutableArray *tuesday = [NSMutableArray array];
    NSMutableArray *wednesday = [NSMutableArray array];
    NSMutableArray *thursay = [NSMutableArray array];
    NSMutableArray *friday = [NSMutableArray array];
    NSMutableArray *saturday = [NSMutableArray array];
    
    for (LALesson* group in array) {
        
        if (group.numberWeek == numberWeek) {
            
            if (group.dayOfWeek ==1)    [monday addObject:group];
            if (group.dayOfWeek ==2)    [tuesday addObject:group];
            if (group.dayOfWeek ==3)    [wednesday addObject:group];
            if (group.dayOfWeek ==4)    [thursay addObject:group];
            if (group.dayOfWeek ==5)    [friday addObject:group];
            if (group.dayOfWeek ==6)    [saturday addObject:group];
        }
        
    }
    
    NSArray *week = [NSMutableArray arrayWithObjects:monday, tuesday, wednesday, thursay, friday, saturday, nil];
    
    
    return week;
}

+ (NSArray *)scheduleDayWeeksFromArray:(NSArray *)array {
    NSMutableArray *monday = [NSMutableArray array];
    NSMutableArray *tuesday = [NSMutableArray array];
    NSMutableArray *wednesday = [NSMutableArray array];
    NSMutableArray *thursay = [NSMutableArray array];
    NSMutableArray *friday = [NSMutableArray array];
    NSMutableArray *saturday = [NSMutableArray array];
    
    for (LALesson* group in array) {
        

            
            if (group.dayOfWeek ==1)    [monday addObject:group];
            if (group.dayOfWeek ==2)    [tuesday addObject:group];
            if (group.dayOfWeek ==3)    [wednesday addObject:group];
            if (group.dayOfWeek ==4)    [thursay addObject:group];
            if (group.dayOfWeek ==5)    [friday addObject:group];
            if (group.dayOfWeek ==6)    [saturday addObject:group];

        
    }
    
    NSArray *week = [NSMutableArray arrayWithObjects:monday, tuesday, wednesday, thursay, friday, saturday, nil];
    
    
    return week;
}

@end
