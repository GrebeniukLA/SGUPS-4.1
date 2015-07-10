//
//  LAMainDoc.h
//  RssReader
//
//  Created by Leonid Grebenyuk on 30/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LARssData;

@interface LARssDoc : NSObject

@property (nonatomic,strong) NSString *docPath;
@property (nonatomic,strong) LARssData *data;

/**
 Initializes an `LARssDoc` object with path where data of RSS news saved.
 
 This is the designated initializer.
 
 @param docPath Path where data of RSS news saved.
 
 @return The newly-initialized LARssDoc
 
 */
- (id)initWithDocPath:(NSString *)docPath;

/**
 Initializes an `LARssDoc` object with array of RSSItems and url link of RSS.
 
 This is the designated initializer.
 
 @param array Array of RSSItems.
 
 @param title Title of the group news.
 
 @return The newly-initialized LARssDoc
 
 */
-(id) initWithArray: (NSArray *) array andTitle:(NSString *)title;

///method to save to disk
- (void)saveData;
///method to delete doc
- (void)deleteDoc;

@end
