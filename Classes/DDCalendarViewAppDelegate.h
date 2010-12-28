//
//  DDCalendarViewAppDelegate.h
//  DDCalendarView
//
//  Created by Damian Dawber on 27/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDCalendarViewController;

@interface DDCalendarViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	DDCalendarViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

