//
//  GroupBuilder.m
//  BrowseMeetup
//
//  Created by Simon on 31/8/13.
//  Copyright (c) 2013 TAMIM Ziad. All rights reserved.
//

#import "GroupBuilder.h"
#import "LATeachers.h"
#import "LALesson.h"
#import "LAMainNews.h"
#import "LAGroups.h"
#import "LASection.h"
#import "LASectionLesson.h"

@implementation GroupBuilder
+ (NSArray *)sectionLessonFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary *groupDic in parsedObject) {
        LASectionLesson *group = [[LASectionLesson alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [groups addObject:group];
    }
    
    return groups;
}

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    

    
    for (NSDictionary *groupDic in parsedObject) {
        LALesson *group = [[LALesson alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [groups addObject:group];
    }
    
    return groups;
}

+ (NSArray *)newsFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary *groupDic in parsedObject) {
        LAMainNews *group = [[LAMainNews alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [array addObject:group];
    }
    
    return array;
    
}

+ (NSArray *)groupsArrayFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary *groupDic in parsedObject) {
        LAGroups *group = [[LAGroups alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [array addObject:group];
    }
    
    return array;
    
}

+ (NSArray *)sectionArrayFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary *groupDic in parsedObject) {
        LASection *group = [[LASection alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [array addObject:group];
    }
    
    return array;
    
}

+ (NSArray *)teachersArrayFromJSON:(NSData *)objectNotation error:(NSError **)error {
    
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary *groupDic in parsedObject) {
       LATeachers  *group = [[LATeachers alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [array addObject:group];
    }
    
    return array;
    
}


@end

