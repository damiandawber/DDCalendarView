    //
//  MainViewController.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "DDCalendarView.h"

@implementation MainViewController


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	UIView *appView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	calendarView = [[DDCalendarView alloc] initWithFrame:appView.bounds fontName:@"Helvetica"];
	
	self.view = appView;
	[appView release];
	
	[self.view addSubview: calendarView];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
