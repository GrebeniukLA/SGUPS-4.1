//
//  LARssParser.h
//  RssReader
//
//  Created by Leonid Grebenyuk on 28/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSItem.h"
/**
 `RSSParser` it's used for parsing RSS news.
 */
@interface RSSParser : NSObject <NSXMLParserDelegate> {
    RSSItem *currentItem;
    NSMutableArray *items;
    NSMutableString *tmpString;
    void (^block)(NSArray *feedItems);
    void (^failblock)(NSError *error);
}

+ (void)parseRSSFeedForRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSArray *feedItems))success
                       failure:(void (^)(NSError *error))failure;

- (void)parseRSSFeedForRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSArray *feedItems))success
                       failure:(void (^)(NSError *error))failure;

@end
