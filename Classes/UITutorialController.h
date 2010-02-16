//
//  UITutorialController.h
//  Stalkerazzi
//
//  Created by Chris Beeson on 14/02/2010.
//  Copyright 2010 Organic Constructs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TourItem.h"

enum TourItemDisplaySide {
	TourItemDisplaySideLeft,
	TourItemDisplaySideRight
};

@protocol UITutorialControllerDelegate
-(void) tourDidFinish:(id)sender;
@end

@interface UITutorialController : NSObject
{
	id <UITutorialControllerDelegate> _delegate;
	
	BOOL _active;
	float _animationDelay;

	NSMutableArray *_tourItems;
	UIView *_view;
	NSArray *_arrows;
	NSMutableArray *_itemsOnDisplay;
	UIView *_viewToDispose;
	UILabel *_messageLabel;
	NSDictionary *_messages;
	
	int _currentItemIndex;
	int _side;
}

-(id)initWithTourItems:(NSArray *)tourItems delegate:(id)delegate view:(UIView *)view;
-(void) beginTour;
-(void) setMessages:(NSDictionary *)messages;

@end








