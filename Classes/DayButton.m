//
//  DayButton.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DayButton.h"


@implementation DayButton
@synthesize delegate;

- (id)initWithText:(NSString *)text withFrame:(CGRect)buttonFrame {
	self = [DayButton buttonWithType:UIButtonTypeCustom];
	
	self.titleLabel.textAlignment = UITextAlignmentRight;
	[self setTitle:text forState:UIControlStateNormal];
	self.backgroundColor = [UIColor blackColor];
	self.frame = buttonFrame;
	
	[self addTarget:delegate action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
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
