//
//  NSUserDefaults+NSUserDefaultsExtensions.m
//  schedule
//
//  Created by Leonid Grebenyuk on 03/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "NSUserDefaults+NSUserDefaultsExtensions.h"

@implementation NSUserDefaults (NSUserDefaultsExtensions)
- (void)saveCustomObject:(id<NSCoding>)object
                     key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self setObject:encodedObject forKey:key];
    [self synchronize];
    
}

//- (id<NSCoding>)loadCustomObjectWithKey:(NSString *)key {
//    NSData *encodedObject = [self objectForKey:key];
//    id<NSCoding> object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
//    return object;
//}

- (NSArray*)loadCustomObjectWithKey:(NSString *)key {
    NSData *encodedObject = [self objectForKey:key];
    NSArray* object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

@end
