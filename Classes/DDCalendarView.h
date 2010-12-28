//
//  DDCalendarView.h
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayButton.h"

@interface DDCalendarView : UIView <DayButtonDelegate> {
	NSString *calendarFontName;
	float calendarWidth;
	float calendarHeight;
	float cellWidth;
	float cellHeight;
	UILabel *monthLabel;
	NSMutableArray *dayButtons;
	int currentMonth;
	int currentYear;
	NSCalendar *calendar;
}

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName;
- (void)updateCalendarForMonth:(int)month forYear:(int)year;
- (void)drawDayButtons;
- (void)prevBtnPressed:(id)sender;
- (void)nextBtnPressed:(id)sender;

@end
