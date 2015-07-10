//
//  LAServerManager.h
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 01/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//
#define Settings [NSUserDefaults standardUserDefaults]
#import <Foundation/Foundation.h>

@interface LAServerManager : NSObject



+ (LAServerManager*) sharedManager;



-(void) getDataFromLesson: (NSString*) string;

-(void) getDataFromNews;

-(void) getDataFromGroupJSON;

-(void) getDataFromSection;

-(void) getDataFromTeachersJSON;


-(void) getDataFromSectionLesson: (NSString*) string;
@end
