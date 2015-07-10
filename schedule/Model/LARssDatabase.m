//
//  LAMainDatabase.m
//  RssReader
//
//  Created by Leonid Grebenyuk on 30/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LARssDatabase.h"

#import "LARssDoc.h"

@implementation LARssDatabase

#define kNameKey        @"rss"

+ (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}
+ (NSMutableArray *)loadDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [LARssDatabase getPrivateDocsDir];

    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create ScaryBugDoc for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        if ([file.pathExtension compare:kNameKey options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            LARssDoc *doc = [[LARssDoc alloc] initWithDocPath:fullPath];
            [retval addObject:doc];
        }
    }
    
    return retval;
    
}

+ (NSString *)nextDocPath {
    
    // Get private docs dir
    NSString *documentsDirectory = [LARssDatabase getPrivateDocsDir];
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Search for an available name
    int maxNumber = 0;
    for (NSString *file in files) {
        if ([file.pathExtension compare:kNameKey options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.%@", maxNumber+1,kNameKey];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
    
}
@end
