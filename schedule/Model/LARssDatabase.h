//
//  LAMainDatabase.h
//  RssReader
//
//  Created by Leonid Grebenyuk on 30/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 `LARssDatabase` used for work with files.
 */
@interface LARssDatabase : NSObject
///Load docs.
+ (NSMutableArray *)loadDocs;
///Invent new path for place where docs will be saved.
+ (NSString *)nextDocPath;

@end
