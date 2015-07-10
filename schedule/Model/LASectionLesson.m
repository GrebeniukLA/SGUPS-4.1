//
//  LASectionLesson.m
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LASectionLesson.h"

@implementation LASectionLesson

#pragma mark - NSCoding





- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        

        _dayOfWeek = [aDecoder decodeIntegerForKey:@"dayOfWeek"];
        _time = [aDecoder decodeObjectForKey:@"time"];
        _lesson = [aDecoder decodeObjectForKey:@"lesson"];
        _audience = [aDecoder decodeObjectForKey:@"audience"];
        _teacher = [aDecoder decodeObjectForKey:@"teacher"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    

    [aCoder encodeInteger:self.dayOfWeek forKey:@"dayOfWeek"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.lesson forKey:@"lesson"];
    [aCoder encodeObject:self.audience forKey:@"audience"];
    [aCoder encodeObject:self.teacher forKey:@"teacher"];
    
    
}

-(NSString *)description {
    return self.lesson;
}
@end
