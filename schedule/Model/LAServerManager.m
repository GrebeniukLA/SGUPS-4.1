//
//  LAServerManager.m
//  rssnavigation
//
//  Created by Leonid Grebenyuk on 01/09/14.
//  Copyright (c) 2014 lada. All rights reserved.
//



#import "LAServerManager.h"
#import "AFNetworking.h"
#import "LAConstants.h"

#import "GroupBuilder.h"


#import "NSUserDefaults+NSUserDefaultsExtensions.h"

@interface LAServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;


@end

@implementation LAServerManager



+ (LAServerManager*) sharedManager {
    
    static LAServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LAServerManager alloc] init];
    });
    
    return manager;
}








-(void) getDataFromLesson: (NSString*) string {
    

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sgups.net/1/%@.json", string]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
   
        
        NSError *error = nil;
        NSArray *groups = [GroupBuilder groupsFromJSON:responseObject error:&error];
        
        
        [Settings saveCustomObject:groups key:string];
        
        NSDictionary* dictionary = @{kLessonJSONDataNotification: groups};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLessonJSONDataNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
    [operation start];
    
}

-(void) getDataFromNews {
    
    NSString *string = @"http://experimentgame.ucoz.com/news1.json";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSArray *array = [GroupBuilder newsFromJSON:responseObject error:&error];

        
        
        [Settings saveCustomObject:array key:kNewsJSONDataNotification];

        NSDictionary* dictionary = @{kNewsJSONDataNotification: array};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewsJSONDataNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
    [operation start];
    
}



-(void) getDataFromGroupJSON {
    
    NSString *string = @"http://sgups.net/1/Groups.json";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSArray *array = [GroupBuilder groupsArrayFromJSON:responseObject error:&error];
        
        [Settings saveCustomObject:array key:kGroupJSONDataNotification];
        
        NSDictionary* dictionary = @{kGroupJSONDataNotification: array};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kGroupJSONDataNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
    [operation start];
    
    
}

-(void) getDataFromSection {
    NSString *string = @"http://experimentgame.ucoz.com/section.json";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSArray *array = [GroupBuilder sectionArrayFromJSON:responseObject error:&error];
        
        [Settings saveCustomObject:array key:kSectionJSONDataNotification];
        
        NSDictionary* dictionary = @{kSectionJSONDataNotification: array};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kSectionJSONDataNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
    [operation start];
    
}

-(void) getDataFromSectionLesson:(NSString *)string {
    
    
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSError *error = nil;
        NSArray *groups = [GroupBuilder sectionLessonFromJSON:responseObject error:&error];
        
        
        [Settings saveCustomObject:groups key:string];
        
        NSDictionary* dictionary = @{string: groups};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:string
                                                            object:nil
                                                          userInfo:dictionary];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
    [operation start];
    
}

-(void) getDataFromTeachersJSON {
    
    NSString *string = @"http://sgups.net/1/Teachers.json";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSArray *array = [GroupBuilder teachersArrayFromJSON:responseObject error:&error];
        
        [Settings saveCustomObject:array key:kTeacherJSONDataNotification];
        
        NSDictionary* dictionary = @{kTeacherJSONDataNotification: array};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTeacherJSONDataNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
    [operation start];
    
    
}

@end
