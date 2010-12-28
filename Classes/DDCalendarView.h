//
//  DDCalendarView.h
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayButton.h"

@protocol DDCalendarViewDelegate <NSObject>
- (void)dayButtonPressed:(DayButton *)button;

@optional
- (void)prevButtonPressed;
- (void)nextButtonPressed;

@end

@interface DDCalendarView : UIView <DayButtonDelegate> {
	id <DDCalendarViewDelegate> delegate;
	NSString *calendarFontName;
	UILabel *monthLabel;
	NSMutableArray *dayButtons;
	NSCalendar *calendar;
	float calendarWidth;
	float calendarHeight;
	float cellWidth;
	float cellHeight;
	int currentMonth;
	int currentYear;
}

@property(nonatomic, assign) id <DDCalendarViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName delegate:(id)theDelegate;
- (void)updateCalendarForMonth:(int)month forYear:(int)year;
- (void)drawDayButtons;
- (void)prevBtnPressed:(id)sender;
- (void)nextBtnPressed:(id)sender;

@end
