    //
//  DDCalendarViewController.m
//  DDCalendarView
//
//  Created by Damian Dawber on 27/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DDCalendarViewController.h"
@implementation DDCalendarViewController


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	calendarFont = [UIFont fontWithName:@"AmericanTypewriter" size:16];
	
	bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	bgView.backgroundColor = [UIColor lightGrayColor];
	
	calendarWidth = bgView.bounds.size.width;
	cellWidth = calendarWidth / 7.0f;
	cellHeight = cellWidth;
	
	UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[prevBtn setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
	prevBtn.frame = CGRectMake(0, 0, cellWidth, cellHeight);
	
	UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[nextBtn setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
	nextBtn.frame = CGRectMake(calendarWidth - cellWidth, 0, cellWidth, cellHeight);
	
	CGRect monthLabelFrame = CGRectMake(cellWidth, 0, calendarWidth - 2*cellWidth, cellHeight);
	monthLabel = [[UILabel alloc] initWithFrame:monthLabelFrame];
	monthLabel.text = @"December";
	monthLabel.font = calendarFont;
	monthLabel.textAlignment = UITextAlignmentCenter;
	monthLabel.backgroundColor = [UIColor clearColor];
	
	[bgView addSubview:prevBtn];
	[bgView addSubview:nextBtn];
	[bgView addSubview:monthLabel];
	
	char *days[7] = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
	for(int i = 0; i < 7; i++) {
		CGRect dayLabelFrame = CGRectMake(i*cellWidth, cellHeight, cellWidth, cellHeight);
		UILabel *dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
		dayLabel.text = [NSString stringWithFormat:@"%s", days[i]];
		NSLog(@"%f", i*cellWidth);
		dayLabel.textAlignment = UITextAlignmentCenter;
		[bgView addSubview:dayLabel];
		[dayLabel release];
	}
	
	NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
	NSDateComponents *dateParts = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
	
	[self drawDaysForMonth:[dateParts month] forYear:[dateParts year]];
	
	self.view = bgView;
	[bgView release];
}

- (void)drawDaysForMonth:(int)month forYear:(int)year {
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			CGRect buttonFrame = CGRectMake(j*cellWidth, (i+2)*cellHeight, cellWidth, cellHeight);
			int day = i*j;
			NSString *text = [NSString stringWithFormat:@"%d", day];
			DayButton *dayButton = [[DayButton alloc] initWithText:text withFrame:buttonFrame];
			dayButton.delegate = self;
			//dayButton.backgroundColor = [UIColor whiteColor];
			[bgView addSubview:dayButton];
			//[dayButton release];
		}
	}
}	

- (void)buttonPressed:(id)sender {
	NSLog(@"might subscribe to Brazzers");
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Cleanup methods

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
