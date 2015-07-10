//
//  LA.m
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 02/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LALesson.h"

@implementation LALesson

#pragma mark - NSCoding





- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {

        _numberWeek = [aDecoder decodeIntegerForKey:@"numberWeek"];
        _dayOfWeek = [aDecoder decodeIntegerForKey:@"dayOfWeek"];
        _numberLesson = [aDecoder decodeIntegerForKey:@"numberLesson"];
        _lesson = [aDecoder decodeObjectForKey:@"lesson"];
        _audience = [aDecoder decodeObjectForKey:@"audience"];
        _teacher = [aDecoder decodeObjectForKey:@"teacher"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInteger:self.numberWeek forKey:@"numberWeek"];
    [aCoder encodeInteger:self.dayOfWeek forKey:@"dayOfWeek"];
    [aCoder encodeInteger:self.numberLesson forKey:@"numberLesson"];
    [aCoder encodeObject:self.lesson forKey:@"lesson"];
    [aCoder encodeObject:self.audience forKey:@"audience"];
    [aCoder encodeObject:self.teacher forKey:@"teacher"];

    
}

-(NSString *)description {
    return self.lesson;
}

@end



