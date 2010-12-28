//
//  DDCalendarViewController.h
//  DDCalendarView
//
//  Created by Damian Dawber on 27/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayButton.h"

@interface DDCalendarViewController : UIViewController <DayButtonDelegate> {
	UIView *bgView;
	float cellWidth;
	float cellHeight;
	int calendarWidth;
	int calendarHeight;
	UIFont *calendarFont;
	UILabel *monthLabel;
}

- (void)drawDaysForMonth:(int)month forYear:(int)year;

@end
