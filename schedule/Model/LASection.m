//
//  LASection.m
//  schedule
//
//  Created by Leonid Grebenyuk on 06/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LASection.h"

@implementation LASection

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _fileGroup = [aDecoder decodeObjectForKey:@"fileGroup"];
        _nameGroup = [aDecoder decodeObjectForKey:@"nameGroup"];
        _moreInfo = [aDecoder decodeObjectForKey:@"moreInfo"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fileGroup forKey:@"fileGroup"];
    [aCoder encodeObject:self.nameGroup forKey:@"nameGroup"];
    [aCoder encodeObject:self.moreInfo forKey:@"moreInfo"];
    
}
@end
