//
//  DDCalendarView.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DDCalendarView.h"
#import "DayButton.h"

@implementation DDCalendarView

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName {
	if ((self = [super initWithFrame:frame])) {
		//Initialise vars
        calendarFontName = fontName;
		calendarWidth = frame.size.width;
		calendarHeight = frame.size.height;
		cellWidth = frame.size.width / 7.0f;
		cellHeight = frame.size.height / 8.0f;
		
		//View properties
		self.backgroundColor = [UIColor darkGrayColor];
		
		//Set up the calendar header
		UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[prevBtn setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
		prevBtn.frame = CGRectMake(0, 0, cellWidth, cellHeight);
		
		UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[nextBtn setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
		nextBtn.frame = CGRectMake(calendarWidth - cellWidth, 0, cellWidth, cellHeight);
		
		CGRect monthLabelFrame = CGRectMake(cellWidth, 0, calendarWidth - 2*cellWidth, cellHeight);
		monthLabel = [[UILabel alloc] initWithFrame:monthLabelFrame];
		monthLabel.text = @"December";
		monthLabel.font = [UIFont fontWithName:calendarFontName size:18];
		monthLabel.textAlignment = UITextAlignmentCenter;
		monthLabel.backgroundColor = [UIColor clearColor];
		
		//Add the calendar header to view		
		[self addSubview: prevBtn];
		[self addSubview: nextBtn];
		[self addSubview: monthLabel];
		
		//Add the day labels to the view
		char *days[7] = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
		for(int i = 0; i < 7; i++) {
			CGRect dayLabelFrame = CGRectMake(i*cellWidth, cellHeight, cellWidth, cellHeight);
			UILabel *dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
			dayLabel.text = [NSString stringWithFormat:@"%s", days[i]];
			dayLabel.textAlignment = UITextAlignmentCenter;
			dayLabel.backgroundColor = [UIColor clearColor];
			
			[self addSubview:dayLabel];
			[dayLabel release];
		}
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
