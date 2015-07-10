//
//  GroupBuilder.h
//  BrowseMeetup
//
//  Created by Simon on 31/8/13.
//  Copyright (c) 2013 TAMIM Ziad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuilder : NSObject

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)newsFromJSON:(NSData *)objectNotation error:(NSError **)error;

+ (NSArray *)groupsArrayFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)sectionArrayFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)sectionLessonFromJSON:(NSData *)objectNotation error:(NSError **)error;

+ (NSArray *)teachersArrayFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end