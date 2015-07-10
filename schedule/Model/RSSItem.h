//
//  LARssItem.h
//  RssReader
//
//  Created by Leonid Grebenyuk on 28/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 `RSSItem` it's item of RSS news.
 */
@interface RSSItem : NSObject <NSCoding>

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *itemDescription;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSURL *link;
@property (strong,nonatomic) NSURL *commentsLink;
@property (strong,nonatomic) NSURL *commentsFeed;
@property (strong,nonatomic) NSNumber *commentsCount;
@property (strong,nonatomic) NSDate *pubDate;
@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString *guid;
@property (strong,nonatomic) NSString *imageLink;


@end
