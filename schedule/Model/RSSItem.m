//
//  LARssItem.m
//  RssReader
//
//  Created by Leonid Grebenyuk on 28/07/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "RSSItem.h"


@implementation RSSItem




#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _itemDescription = [aDecoder decodeObjectForKey:@"itemDescription"];
        _content = [aDecoder decodeObjectForKey:@"content"];
        _link = [aDecoder decodeObjectForKey:@"link"];
        _commentsLink = [aDecoder decodeObjectForKey:@"commentsLink"];
        _commentsFeed = [aDecoder decodeObjectForKey:@"commentsFeed"];
        _commentsCount = [aDecoder decodeObjectForKey:@"commentsCount"];
        _pubDate = [aDecoder decodeObjectForKey:@"pubDate"];
        _author = [aDecoder decodeObjectForKey:@"author"];
        _guid = [aDecoder decodeObjectForKey:@"guid"];
        _imageLink = [aDecoder decodeObjectForKey:@"imageLink"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.itemDescription forKey:@"itemDescription"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.link forKey:@"link"];
    [aCoder encodeObject:self.commentsLink forKey:@"commentsLink"];
    [aCoder encodeObject:self.commentsFeed forKey:@"commentsFeed"];
    [aCoder encodeObject:self.commentsCount forKey:@"commentsCount"];
    [aCoder encodeObject:self.pubDate forKey:@"pubDate"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.guid forKey:@"guid"];
    [aCoder encodeObject:self.imageLink forKey:@"imageLink"];
}

#pragma mark -

- (BOOL)isEqual:(RSSItem *)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.link.absoluteString isEqualToString:object.link.absoluteString];
}

- (NSUInteger)hash
{
    return [self.link hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %@>", [self class], self.itemDescription ];
}
@end
