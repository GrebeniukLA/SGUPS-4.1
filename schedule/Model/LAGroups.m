//
//  LAGroups.m
//  schedule
//
//  Created by Leonid Grebenyuk on 06/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAGroups.h"

@implementation LAGroups


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _fileGroup = [aDecoder decodeObjectForKey:@"fileGroup"];
        _nameGroup = [aDecoder decodeObjectForKey:@"nameGroup"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fileGroup forKey:@"fileGroup"];
    [aCoder encodeObject:self.nameGroup forKey:@"nameGroup"];
    
}

@end
