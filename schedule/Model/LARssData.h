//
//  LATest.h
//  RssReader
//
//  Created by Leonid Grebenyuk on 29/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 `LARssData` contain RSS data.
 */
@interface LARssData : NSObject <NSCoding>

/**
 It's url link of RSS. Also it's used for title of the group news in tableView.
 */
@property (nonatomic, strong) NSString *title;

/**
 This array used for collect RSSItems
  @see RSSItem.h
 */
@property (nonatomic, strong) NSArray *array;


/**
 Initializes an `LARssData` object with array of RSSItems and url link of RSS.
 
 This is the designated initializer.
 
 @param array Array of RSSItems.
 
 @param title Title of the group news.
 
 @return The newly-initialized LARssData

 */
-(id) initWithArray: (NSArray *) array andTitle: (NSString*) title;

@end
