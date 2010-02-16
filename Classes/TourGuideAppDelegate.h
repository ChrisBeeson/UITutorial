//
//  TourGuideAppDelegate.h
//  TourGuide
//
//  Created by Chris Beeson on 15/02/2010.
//  Copyright Organic Constructs 2010. All rights reserved.
//

@interface TourGuideAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

