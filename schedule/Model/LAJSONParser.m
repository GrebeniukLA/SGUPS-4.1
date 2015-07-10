//
//  LAJSONParser.m
//  EGE
//
//  Created by Leonid Grebenyuk on 30/10/14.
//  Copyright (c) 2014 YouTube Developer Relations. All rights reserved.
//

#import "LAJSONParser.h"
#import "LATask.h"

@implementation LAJSONParser

+ (NSArray *)taskFromstring: (NSString*) string{
    

    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    

    
    
    NSDictionary* dictsArray = [parsedData objectForKey:@"response"];
    
    NSDictionary* dictsArray2 = [dictsArray objectForKey:@"items"];
    
  //  NSDictionary* dictLikes= [dictsArray2 objectForKey:@"likes"];
    
    
 //    NSLog(@"Likes !!!! %@",dictsArray2);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary *groupDic in dictsArray2) {
        LATask *group = [[LATask alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [array addObject:group];
    }
    
    return array;
    
}


@end
