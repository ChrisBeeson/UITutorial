//
//  TourGuideAppDelegate.m
//  TourGuide
//
//  Created by Chris Beeson on 15/02/2010.
//  Copyright Organic Constructs 2010. All rights reserved.
//

#import "TourGuideAppDelegate.h"
#import "RootViewController.h"


@implementation TourGuideAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

