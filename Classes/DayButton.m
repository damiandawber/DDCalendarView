//
//  DayButton.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DayButton.h"


@implementation DayButton
@synthesize delegate, buttonDate;

- (id)buttonWithFrame:(CGRect)buttonFrame {
	self = [DayButton buttonWithType:UIButtonTypeCustom];
	
	self.frame = buttonFrame;
	self.titleLabel.textAlignment = UITextAlignmentRight;
	self.backgroundColor = [UIColor clearColor];
	[self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	
	[self addTarget:delegate action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	UILabel *titleLabel = [self titleLabel];
	CGRect labelFrame = titleLabel.frame;
	int framePadding = 4;
	labelFrame.origin.x = self.bounds.size.width - labelFrame.size.width - framePadding;
	labelFrame.origin.y = framePadding;
	
	[self titleLabel].frame = labelFrame;
}

- (void)dealloc {
    [super dealloc];
}


@end
