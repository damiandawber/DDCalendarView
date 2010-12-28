//
//  MainViewController.h
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCalendarView.h"

@interface MainViewController : UIViewController <DDCalendarViewDelegate> {
	DDCalendarView *calendarView;
}

@end
