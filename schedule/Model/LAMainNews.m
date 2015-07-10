//
//  MainNews.m
//  schedule
//
//  Created by Leonid Grebenyuk on 01/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAMainNews.h"

@implementation LAMainNews


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _Name = [aDecoder decodeObjectForKey:@"Name"];
        _Link = [aDecoder decodeObjectForKey:@"Link"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Name forKey:@"Name"];
    [aCoder encodeObject:self.Link forKey:@"Link"];

}


@end
