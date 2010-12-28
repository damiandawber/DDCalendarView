//
//  DDCalendarView.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DDCalendarView.h"

@implementation DDCalendarView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName delegate:(id)theDelegate {
	if ((self = [super initWithFrame:frame])) {
		self.delegate = theDelegate;
		
		//Initialise vars
        calendarFontName = fontName;
		calendarWidth = frame.size.width;
		calendarHeight = frame.size.height;
		cellWidth = frame.size.width / 7.0f;
		cellHeight = frame.size.height / 8.0f;
		
		//View properties
		UIColor *bgPatternImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"square-paper.png"]];
		self.backgroundColor = bgPatternImage;
		[bgPatternImage release];
		
		//Set up the calendar header
		UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[prevBtn setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
		prevBtn.frame = CGRectMake(0, 0, cellWidth, cellHeight);
		[prevBtn addTarget:self action:@selector(prevBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[nextBtn setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
		nextBtn.frame = CGRectMake(calendarWidth - cellWidth, 0, cellWidth, cellHeight);
		[nextBtn addTarget:self action:@selector(nextBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		CGRect monthLabelFrame = CGRectMake(cellWidth, 0, calendarWidth - 2*cellWidth, cellHeight);
		monthLabel = [[UILabel alloc] initWithFrame:monthLabelFrame];
		monthLabel.font = [UIFont fontWithName:calendarFontName size:18];
		monthLabel.textAlignment = UITextAlignmentCenter;
		monthLabel.backgroundColor = [UIColor clearColor];
		monthLabel.textColor = [UIColor blackColor];
		
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
			dayLabel.font = [UIFont fontWithName:calendarFontName size:16];
			dayLabel.textColor = [UIColor darkGrayColor];
			
			[self addSubview:dayLabel];
			[dayLabel release];
		}
		
		[self drawDayButtons];
		
		//Set the current month and year and update the calendar
		calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		
		NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
		NSDateComponents *dateParts = [calendar components:unitFlags fromDate:[NSDate date]];
		currentMonth = [dateParts month];
		currentYear = [dateParts year];
		
		[self updateCalendarForMonth:currentMonth forYear:currentYear];
		
    }
    return self;
}

- (void)drawDayButtons {
	dayButtons = [[NSMutableArray alloc] initWithCapacity:42];
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			CGRect buttonFrame = CGRectMake(j*cellWidth, (i+2)*cellHeight, cellWidth, cellHeight);
			DayButton *dayButton = [[DayButton alloc] buttonWithFrame:buttonFrame];
			dayButton.titleLabel.font = [UIFont fontWithName:calendarFontName size:14];
			dayButton.delegate = self;
			
			[dayButtons addObject:dayButton];
			[dayButton release];
			
			[self addSubview:[dayButtons lastObject]];
		}
	}
}
			 
- (void)updateCalendarForMonth:(int)month forYear:(int)year {
	char *months[12] = {"January", "Febrary", "March", "April", "May", "June",
		"July", "August", "September", "October", "November", "December"};
	monthLabel.text = [NSString stringWithFormat:@"%s %d", months[month - 1], year];
	
	//Get the first day of the month
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:month];
	[dateParts setYear:year];
	[dateParts setDay:1];
	NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
	[dateParts release];
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:dateOnFirst];
	int weekdayOfFirst = [weekdayComponents weekday];	
	
	//Map first day of month to a week starting on Monday
	//as the weekday component defaults to 1->Sun, 2->Mon...
	if(weekdayOfFirst == 1) {
		weekdayOfFirst = 7;
	} else {
		--weekdayOfFirst;
	}

	int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit 
										inUnit:NSMonthCalendarUnit 
											forDate:dateOnFirst].length;
	
	int day = 1;
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			int buttonNumber = i * 7 + j;
			
			DayButton *button = [dayButtons objectAtIndex:buttonNumber];
			
			button.enabled = NO; //Disable buttons by default
			[button setTitle:nil forState:UIControlStateNormal]; //Set title label text to nil by default
			[button setButtonDate:nil];
			
			if(buttonNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
				[button setTitle:[NSString stringWithFormat:@"%d", day] 
												forState:UIControlStateNormal];
				
				NSDateComponents *dateParts = [[NSDateComponents alloc] init];
				[dateParts setMonth:month];
				[dateParts setYear:year];
				[dateParts setDay:day];
				NSDate *buttonDate = [calendar dateFromComponents:dateParts];
				[dateParts release];
				[button setButtonDate:buttonDate];
				
				button.enabled = YES;
				++day;
			}
		}
	}
}

- (void)prevBtnPressed:(id)sender {
	if(currentMonth == 1) {
		currentMonth = 12;
		--currentYear;
	} else {
		--currentMonth;
	}
	
	[self updateCalendarForMonth:currentMonth forYear:currentYear];
	
	if ([self.delegate respondsToSelector:@selector(prevButtonPressed)]) {
		[self.delegate prevButtonPressed];
	}
}

- (void)nextBtnPressed:(id)sender {
	if(currentMonth == 12) {
		currentMonth = 1;
		++currentYear;
	} else {
		++currentMonth;
	}
	
	[self updateCalendarForMonth:currentMonth forYear:currentYear];
	
	if ([self.delegate respondsToSelector:@selector(nextButtonPressed)]) {
		[self.delegate nextButtonPressed];
	}
}

- (void)dayButtonPressed:(id)sender {
	DayButton *dayButton = (DayButton *) sender;
	[self.delegate dayButtonPressed:dayButton];
}

- (void)dealloc {
	[calendar release];
	[dayButtons release];
    [super dealloc];
}


@end
