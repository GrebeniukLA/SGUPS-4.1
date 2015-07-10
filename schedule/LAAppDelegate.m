//
//  LAAppDelegate.m
//  schedule
//
//  Created by Leonid Grebenyuk on 29/09/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAAppDelegate.h"
#import <VKSdk.h>

@implementation LAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	[VKSdk processOpenURL:url fromApplication:sourceApplication];
	return YES;
}
							


@end
