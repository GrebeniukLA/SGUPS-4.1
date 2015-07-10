//
//  LATeachers.m
//  schedule
//
//  Created by Dev on 29/1/15.
//  Copyright (c) 2015 stu. All rights reserved.
//

#import "LATeachers.h"

@implementation LATeachers


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _numberVK = [aDecoder decodeIntegerForKey:@"numberVK"];
        _nameTeacher = [aDecoder decodeObjectForKey:@"nameTeacher"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.numberVK forKey:@"numberVK"];
    [aCoder encodeObject:self.nameTeacher forKey:@"nameTeacher"];
    
    
}

-(NSString *)description {
    return self.nameTeacher;
}

@end
