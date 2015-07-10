//
//  LATest.m
//  RssReader
//
//  Created by Leonid Grebenyuk on 29/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LARssData.h"

@implementation LARssData

-(id) initWithArray: (NSArray *) array andTitle: (NSString*) title{
    if ((self = [super init])) {
        _array = array;
        _title = title;
    }
    return self;
}



#pragma mark NSCoding

#define kArrayKey       @"Array"
#define kTitleKey       @"Title"


- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_array forKey:kArrayKey];
    [encoder encodeObject:_title forKey:kTitleKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSArray *array = [decoder decodeObjectForKey:kArrayKey];
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    return [self initWithArray:array andTitle:title];
}
    

@end
