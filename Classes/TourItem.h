//
//  TourItem.h
//  Stalkerazzi
//
//  Created by Chris Beeson on 14/02/2010.
//  Copyright 2010 Organic Constructs. All rights reserved.
//

#import <Foundation/Foundation.h>

enum tourItemDelayType{
	tourItemDelayTypeWaitForScreenTap,
	tourItemDelayTypeWaitForDuration,
};


@interface TourItem : NSObject {
	
	id _delegate;

	CGRect _POIRect; 
	NSString * _text;
	int _delayType;
	double _delay;
	float _horzOffset;
}

@property (nonatomic,assign) CGRect POIRect; 
@property (nonatomic,retain) NSString * text;
@property (nonatomic,assign) int delayType;
@property (nonatomic,assign) double delay;
@property (nonatomic,assign) float horzOffset;

-(id)initWithInterestFrame:(CGRect)POIRect text:(NSString *)text delayType:(int)type;
-(id)initWithInterestFrame:(CGRect)POIRect horzOffset:(float)horzOffset text:(NSString *)text delayType:(int)type;
-(id)initWithInterestFrame:(CGRect)POIRect text:(NSString *)text delayType:(int)type delay:(double)delay;
-(id)initWithInterestFrame:(CGRect)POIRect horzOffset:(float)horzOffset text:(NSString *)text delayType:(int)type delay:(double)delay;

@end
