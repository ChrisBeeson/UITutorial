//
//  UITutorialController.m
//  Stalkerazzi
//
//  Created by Chris Beeson on 14/02/2010.
//  Copyright 2010 Organic Constructs. All rights reserved.
//

#import "UITutorialController.h"

@interface UITutorialController(Private)

-(void)addTint; 
-(void)hideTourItemWithIndex:(int)index;
-(void)showNextTourItem;
-(void)displayTourItem:(TourItem *)item;
-(void)displayBottomMessage:(NSString *)text;
-(void)hideBottomMessage;
-(void)displayMessage;
-(void)screenWasTapped;

@end


@implementation UITutorialController

-(id)initWithTourItems:(NSArray *)tourItems delegate:(id)delegate view:(UIView *)view
{
	self = [super init];
	
	if (self != nil) 
	{
		_delegate = [delegate retain];
		_view = [view retain];
		_tourItems = [tourItems mutableCopy];
		_itemsOnDisplay = [[NSMutableArray alloc] init];
		_active = YES;
		_animationDelay = 0.0;    //Used only for showing items
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenWasTapped) name:@"TourViewScreenTap" object:nil];
	}
	return self;
}



-(void)beginTour
{
	//	[self addTint];      <-enable it if you need too
	_active = YES;
	_currentItemIndex = -1;
	[self showNextTourItem];
}



-(void)showNextTourItem
{
	[self hideTourItemWithIndex:_currentItemIndex];
	
	_currentItemIndex +=1;
	
	//Firstly are we finished?
	
	if (_currentItemIndex > ([_tourItems count]-1)) {
		if (_delegate) {
			if ([_delegate respondsToSelector:@selector(tourDidFinish:)]) {
				[_delegate tourDidFinish:self];
			}
		}
		_currentItemIndex = -1;  //reset
		_active = NO;
		return;
	}
	
	id item = [_tourItems objectAtIndex:_currentItemIndex];
	
	if ([item isKindOfClass:[TourItem class]]) 
	{
		TourItem *tItem = item;
		[self displayTourItem:tItem];
	}
	
	[self displayMessage];
}

-(void)displayMessage
{
	if (_messages) {
		id message = [_messages objectForKey:[NSString stringWithFormat:@"%i",_currentItemIndex]];
		
		if ([message isKindOfClass:[NSString class]])
		{
			[self displayBottomMessage:(NSString *)message];
		}
	}
}


-(void) hideTourItemWithIndex:(int)index
{
	if (index == -1) {
		return;
	}
	
	_viewToDispose = [_view viewWithTag:index+900];
	
	// what a cheat!
	
	[UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDidStopSelector:@selector(hideTourItemDidFinishAnimating:)];
	
	if (_side == TourItemDisplaySideLeft)
	{
		_viewToDispose.frame = CGRectMake(0 - _viewToDispose.frame.size.width,_viewToDispose.frame.origin.y,_viewToDispose.frame.size.width,_viewToDispose.frame.size.height);
	}
	else {
		_viewToDispose.frame = CGRectMake(_view.frame.size.width,_viewToDispose.frame.origin.y,_viewToDispose.frame.size.width,_viewToDispose.frame.size.height);
	}
	
	[UIView commitAnimations];
	
	[self hideBottomMessage];
}

-(void)hideTourItemDidFinishAnimating:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[_viewToDispose removeFromSuperview];
}

-(void) displayTourItem:(TourItem *)item
{
	NSString *arrowName;
	CGFloat x, y;
	
	// First lets work out what side it needs to be on...
	
	if (item.POIRect.origin.x > (_view.frame.size.width/2)) {
		_side = TourItemDisplaySideLeft;
		arrowName = @"TourArrowLeft.png";
	} else {
		_side = TourItemDisplaySideRight;
		arrowName = @"TourArrowRight.png";
	}
	
	UIImageView *arrowView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:arrowName]];
	arrowView.tag = _currentItemIndex+900;
	
	y = item.POIRect.origin.y+(item.POIRect.size.height/2);  // Work out the vertial postion
	
	UILabel *textLabel = [[UILabel alloc] init];
	textLabel.font = [UIFont systemFontOfSize:15.0];
	textLabel.textColor = [UIColor whiteColor];
	textLabel.text = item.text;
	textLabel.backgroundColor = [UIColor clearColor];
	
	switch (_side) 
	{
		case TourItemDisplaySideLeft:
			x = item.POIRect.origin.x - arrowView.frame.size.width +5;
			textLabel.frame = CGRectMake(1, 12, arrowView.frame.size.width-50, 16);
			textLabel.textAlignment = UITextAlignmentRight;
			break;
			
		case TourItemDisplaySideRight:
			x = item.POIRect.origin.x + item.POIRect.size.width;
			textLabel.frame = CGRectMake(50, 12, arrowView.frame.size.width-50, 16);
			textLabel.textAlignment = UITextAlignmentLeft;
			//textLabel.frame =
			break;
	}
	
	y = y -(arrowView.frame.size.height/2);
	
	CGRect arrowFrame;
	
	[arrowView addSubview:textLabel];
	[textLabel release];
	
	[_view addSubview:arrowView];
	[_itemsOnDisplay addObject:arrowView];
	
	// animate in
	
	if (_side == TourItemDisplaySideLeft) 
	{
		arrowFrame = CGRectMake(0-arrowView.frame.size.width,y,arrowView.frame.size.width,arrowView.frame.size.height);
		arrowView.frame = arrowFrame;
	}
	else 
	{
		arrowFrame = CGRectMake(_view.frame.size.width+10,y,arrowView.frame.size.width,arrowView.frame.size.height);
		arrowView.frame = arrowFrame;	
	}
	
	[UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDelay:_animationDelay];
	[UIView setAnimationDuration:0.6];
	
	if (_side == TourItemDisplaySideLeft) 
	{
		arrowFrame = CGRectMake(x+item.horzOffset,y,arrowView.frame.size.width,arrowView.frame.size.height);
		arrowView.frame = arrowFrame;
	}
	else 
	{
		arrowFrame = CGRectMake(x+item.horzOffset,y,arrowView.frame.size.width,arrowView.frame.size.height);
		arrowView.frame = arrowFrame;
	}
	
	[UIView commitAnimations];
	[arrowView release];	
	
	if (item.delayType == tourItemDelayTypeWaitForDuration) 
	{
		[self performSelector:@selector(showNextTourItem) withObject:nil afterDelay:item.delay];
	}
}

-(void)displayBottomMessage:(NSString *)text
{
	if (!_messageLabel) 
	{
		_messageLabel = [[UILabel alloc] init];
		_messageLabel.font = [UIFont systemFontOfSize:14.0];
		_messageLabel.textColor = [UIColor whiteColor];
		_messageLabel.textAlignment = UITextAlignmentCenter;
		_messageLabel.backgroundColor = [UIColor clearColor];
		_messageLabel.alpha = 0.0;
		
		_messageLabel.frame = CGRectMake(0, _view.frame.size.height-30, _view.frame.size.width, 30);
		[_view addSubview:_messageLabel];
	}
	
	_messageLabel.text = text;
	
	[UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDelay:1.0];
	[UIView setAnimationDuration:1.0];
	
	_messageLabel.alpha = 0.9;
	
	[UIView commitAnimations];
}

-(void)hideBottomMessage
{
	if (_messageLabel.alpha>0.1) 
	{
		[UIView beginAnimations:Nil context:NULL];
		[UIView setAnimationDelay:0.2];
		[UIView setAnimationDuration:1.0];
		
		_messageLabel.alpha = 0.0;
		
		[UIView commitAnimations];
	}
}


-(void) setMessages:(NSDictionary *)messages
{
	_messages =	[messages retain];
}


-(void) screenWasTapped
{
	if (_active) {
		if ([[_tourItems objectAtIndex:_currentItemIndex] delayType] == tourItemDelayTypeWaitForScreenTap ) {
			[self showNextTourItem];
		}
	}
}

-(void)addTint
{
	UIImage *tourTint = [UIImage imageNamed:@"TourTint.png"];
	UIImageView *tint = [[UIImageView alloc] initWithImage:tourTint];
	tint.frame = _view.frame;
	tint.contentMode = UIViewContentModeScaleToFill;
	[_view addSubview:tint];   /// TODO: FADE!
	[_itemsOnDisplay addObject:tint];
	[tint release];
}

- (void)dealloc {
	[_messages release];
	[_messageLabel release];
	[_view release];
	[_tourItems release];
	[_itemsOnDisplay release];
    [super dealloc];
}

@end
