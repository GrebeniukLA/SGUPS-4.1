//
//  LAJSONParser.h
//  EGE
//
//  Created by Leonid Grebenyuk on 30/10/14.
//  Copyright (c) 2014 YouTube Developer Relations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAJSONParser : NSObject

+ (NSArray *)taskFromstring: (NSString*) string;

@end
