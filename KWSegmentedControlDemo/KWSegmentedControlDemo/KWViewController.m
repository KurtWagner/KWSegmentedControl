//
//  KWViewController.m
//  KWSegmentedControlDemo
//
//  Created by Kurt Wagner on 25/03/2014.
//  Copyright (c) 2014 Kurt Wagner. All rights reserved.
//

#import "KWViewController.h"

@interface KWViewController ()

@property (nonatomic, strong) UILabel *controlALabel;
@property (nonatomic, strong) UILabel *controlBLabel;

@end

@implementation KWViewController

- (void)viewDidLoad
{
    	[super viewDidLoad];

	CGRect frame = CGRectInset(self.view.frame, 20, 20);
	frame.size.height = 26;
	
	CGRect frameB = CGRectInset(self.view.frame, 100, 20);
	frameB.size.height = 50;

	
	CGPoint center = self.view.center;
	center.y -= 130;

	// CONTROL A

	KWSegmentedControl *controlA = [[KWSegmentedControl alloc] initWithFrame:frame];
	controlA.tag = 0;
	controlA.center = center;

	controlA.trackBackgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.f blue:0/255.f alpha:.03];
	controlA.trackBorderColor = [UIColor colorWithRed:0/255.0f green:0/255.f blue:0/255.f alpha:.1];
	controlA.segmentBorderColor = [UIColor lightGrayColor];
	
	[controlA setOptions:@[@"Segment One", @"Segment Two"]];
	
	[self.view addSubview:controlA];
	center.y += 40;
	
	self.controlALabel = [[UILabel alloc] initWithFrame:frame];
	self.controlALabel.center = center;
	[self.controlALabel setText:[controlA titleForSegmentAtIndex:controlA.selectedSegmentIndex]];
	[self.view addSubview:self.controlALabel];
	center.y += 70;
	
	
	// CONTROL B
	
	KWSegmentedControl *controlB = [[KWSegmentedControl alloc] initWithFrame:frameB];
	controlB.tag = 1;
	controlB.center = center;
	
	controlB.trackTextColor = [UIColor whiteColor];
	controlB.trackBackgroundColor = [UIColor colorWithRed:31/255.0f green:155/255.f blue:207/255.f alpha:1];
	controlB.segmentTextColor = controlB.trackBackgroundColor;
	controlB.segmentFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.f];
	controlB.trackFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30.f];
	
	[controlB setOptions:@[@"A", @"B"]];
	
	[self.view addSubview:controlB];
	center.y += 40;
	
	self.controlBLabel = [[UILabel alloc] initWithFrame:frame];
	self.controlBLabel.center = center;
	[self.controlBLabel setText:[controlB titleForSegmentAtIndex:controlB.selectedSegmentIndex]];
	[self.view addSubview:self.controlBLabel];
	center.y += 70;
	
	[controlA addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
	[controlB addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
	
}

#pragma mark - IBAction

- (void)segmentChanged:(KWSegmentedControl *)control {
	NSString * title = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
	if (control.tag == 0) {
		[self.controlALabel setText:title];
	} else if (control.tag == 1) {
		[self.controlBLabel setText:title];
	}
}

@end
