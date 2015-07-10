//
//  LANumberOfWeek.m
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LANumberOfWeek.h"

@implementation LANumberOfWeek

+(NSInteger) caclculate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *fromData =[NSDate date];
    fromData = [dateFormatter dateFromString:@"08/30/2014"];
    NSDate *toData =[self sunday];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:fromData toDate:toData options:0];
    
    int week = (int)( [components day]/7);
    
    return week % 2 ==0 ? 1 : 2 ;
}



+(NSDate*) sunday {
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit
                                                       fromDate:today];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today is Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract
                                                         toDate:today options:0];
    
    
    
    return beginningOfWeek;
}

+(NSInteger) caclculateDayOfWeek {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    
    return [components weekday]- 2;
}



+(NSInteger) caclculateNumberOfLesson {
    
    

    NSDate * dateBegin;
    NSDate * dateEnd;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    for (int i=0; i < 6; i++) {
        dateBegin = [formatter dateFromString: [self yearMonthDayForTime:i forBegin:YES]];
        dateEnd = [formatter dateFromString: [self yearMonthDayForTime:i forBegin:NO]];
        
        if ( [self date:[NSDate date] isBetweenDate:dateBegin andDate:dateEnd]) {
            return i;
        }
        
    }
    
    
    return 0;
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
    	return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
    	return NO;
    
    return YES;
}

+(NSString*) yearMonthDayForTime: (int) number forBegin: (BOOL) begin {
    

    NSArray* timeLessonsBegin = @[@"8:30",@"10:00",@"11:45",@"13:30",@"15:40",@"17:25"];
    NSArray* timeLessonsEnd = @[@"10:00",@"11:45",@"13:30",@"15:40",@"17:25",@"23:59"];
    
    NSArray* array = begin ? timeLessonsBegin : timeLessonsEnd;
    

    
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDateComponents * comp = [cal components:( NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
    
    
    NSString * string = [NSString stringWithFormat:@"%li-%li-%li %@",
                         (long)[comp year],
                         (long)[comp month],
                         (long)[comp day],
                         array[number]];
    
    return string;
    
    
}
@end
