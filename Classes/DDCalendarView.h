//
//  DDCalendarView.h
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDCalendarView : UIView {
	NSString *calendarFontName;
	float calendarWidth;
	float calendarHeight;
	float cellWidth;
	float cellHeight;
	UILabel *monthLabel;
}

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName;

@end
