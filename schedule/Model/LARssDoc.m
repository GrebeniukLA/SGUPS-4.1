//
//  LAMainDoc.m
//  RssReader
//
//  Created by Leonid Grebenyuk on 30/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "LARssDoc.h"
#import "LARssData.h"
#import "LARssDatabase.h"

#define kDataKey        @"RSSData"
#define kDataFile       @"RssData.plist"

@implementation LARssDoc



- (id)initWithDocPath:(NSString *)docPath {
    if ((self = [super init])) {
        _docPath = docPath;
    }
    return self;
}


-(id) initWithArray: (NSArray *) array andTitle:(NSString *)title{
    if ((self = [super init])) {
        _data = [[LARssData alloc] initWithArray:array andTitle:title];

    }
    return self;
}


///function to create document path
- (BOOL)createDataPath {
    
    if (_docPath == nil) {
        self.docPath = [LARssDatabase nextDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}

///Override data property to load from disk
- (LARssData *)data {
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath] ;
    if (codedData == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey] ;
    [unarchiver finishDecoding];

    return _data;
    
}

///method to save to disk

- (void)saveData {
    
    if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];

}


///method to delete doc
- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

@end
