//
//  RootViewController.h
//  TourGuide
//
//  Created by Chris Beeson on 15/02/2010.
//  Copyright Organic Constructs 2010. All rights reserved.
//

#import "UITutorialController.h"
#import "TourItem.h"

@interface RootViewController : UIViewController {
		
	UITutorialController *tour;
	
	IBOutlet UIActivityIndicatorView *activity;
	IBOutlet UILabel *label;
	IBOutlet UIButton *button;
	IBOutlet UISlider *slider;
}

@end
