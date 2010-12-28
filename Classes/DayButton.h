//
//  DayButton.h
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DayButtonDelegate
- (void)buttonPressed:(id)sender;
@end

@interface DayButton : UIButton {
	id <DayButtonDelegate> delegate;
}

@property (nonatomic, assign) id delegate;

- (id)initWithText:(NSString *)text withFrame:(CGRect)buttonFrame;

@end
