//
//  TourItem.m
//  Stalkerazzi
//
//  Created by Chris Beeson on 14/02/2010.
//  Copyright 2010 Organic Constructs. All rights reserved.
//

#import "TourItem.h"


@implementation TourItem

@synthesize POIRect = _POIRect , text = _text, delayType = _delayType, delay = _delay, horzOffset = _horzOffset;;

-(id)initWithInterestFrame:(CGRect)POIRect horzOffset:(float)horzOffset text:(NSString *)text delayType:(int)type delay:(double)delay
{
		self = [super init];
		if (self != nil) 
		{
			_POIRect = POIRect;
			_text = text;
			_delayType = type;
			_delay = delay;               //Delay is only used for tourItemDelayTypeWaitForDuration
			_horzOffset = horzOffset;
		}
		return self;
}

-(id)initWithInterestFrame:(CGRect)POIRect text:(NSString *)text delayType:(int)type delay:(double)delay
{
	return [self initWithInterestFrame:POIRect 
							horzOffset:0.0 
								  text:text 
							 delayType:type 
								 delay:delay];
}

-(id)initWithInterestFrame:(CGRect)POIRect text:(NSString *)text delayType:(int)type
{
	return [self initWithInterestFrame:POIRect 
							horzOffset:0.0 
								  text:text 
							 delayType:type 
								 delay:0.0];
}

-(id)initWithInterestFrame:(CGRect)POIRect horzOffset:(float)horzOffset  text:(NSString *)text delayType:(int)type
{
	return [self initWithInterestFrame:POIRect 
							horzOffset:horzOffset 
								  text:text 
							 delayType:type 
								 delay:0.0];
}

@end
