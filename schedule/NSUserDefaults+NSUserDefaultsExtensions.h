//
//  NSUserDefaults+NSUserDefaultsExtensions.h
//  schedule
//
//  Created by Leonid Grebenyuk on 03/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (NSUserDefaultsExtensions)
- (void)saveCustomObject:(id<NSCoding>)object
                     key:(NSString *)key;
- (id)loadCustomObjectWithKey:(NSString *)key;



@end
