//
//  RootViewController.m
//  TourGuide
//
//  Created by Chris Beeson on 15/02/2010.
//  Copyright Organic Constructs 2010. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidAppear:(BOOL)animated {

	NSMutableArray *tourItems = [[NSMutableArray alloc] init];
	
	[tourItems addObject:[[TourItem alloc] initWithInterestFrame:activity.frame 
															text:@"This is an activity Indicator"
													   delayType:tourItemDelayTypeWaitForScreenTap 
														   delay:0.0]];
	
	[tourItems addObject:[[TourItem alloc] initWithInterestFrame:label.frame
													  horzOffset:0.0
															text:@"A label"
													   delayType:tourItemDelayTypeWaitForScreenTap 
														   delay:0.0]];
	
	
	[tourItems addObject:[[TourItem alloc] initWithInterestFrame:button.frame
													  horzOffset:0.0
															text:@"A button"
													   delayType:tourItemDelayTypeWaitForScreenTap 
														   delay:0.0]];
	
	
	[tourItems addObject:[[TourItem alloc] initWithInterestFrame:slider.frame
													  horzOffset:0.0
															text:@"And a slider"
													   delayType:tourItemDelayTypeWaitForScreenTap 
														   delay:0.0]];
	
 	tour = [[UITutorialController alloc] initWithTourItems:tourItems delegate:self view:self.view];
 
	NSMutableDictionary *messages = [[NSMutableDictionary alloc] init];
	
	[messages setObject:@"Tap screen to continue" forKey:@"0"];
	[messages setObject:@"Shake to stop tour" forKey:@"1"];
	[messages setObject:@"We're all done" forKey:@"3"];
	
	[tour setMessages:messages];
	[messages release];
	[tourItems release];
	
	[tour performSelector:@selector(beginTour) withObject:nil afterDelay:1.0];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{ 
    [super touchesBegan:touches withEvent:event];
	[[NSNotificationCenter defaultCenter]  postNotificationName:@"TourViewScreenTap" object:self]; 
}


- (void)dealloc {
	[tour release];
    [super dealloc];
}


@end

