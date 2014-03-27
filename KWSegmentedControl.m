// KWSegmentedControl.m
//
// Copyright (c) 2013 Kurt Wagner <krw521@uowmail.edu.au>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "KWSegmentedControl.h"

@interface KWSegmentedControl ()

/// Overlay that appears above the segmented option
@property (nonatomic, strong) UIView *overlay;

/// Array containing buttons in segment
@property (nonatomic, strong) NSArray *segments;

@end

@implementation KWSegmentedControl

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self resetToDefaults];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self resetToDefaults];
	[self setupView];
}

- (void)didMoveToSuperview {
	[self setupView];
}

- (void)resetToDefaults {
	self.trackBackgroundColor = [UIColor lightGrayColor];
	self.trackBorderColor = [UIColor darkGrayColor];
	self.trackTextColor = [UIColor darkGrayColor];
	self.trackFont = [UIFont fontWithName:@"HelveticaNeue" size:12.f];
	
	self.segmentTextColor = [UIColor blackColor];
	self.segmentFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.f];
	self.segmentBackgroundColor = [UIColor whiteColor];
	self.segmentBorderColor = [UIColor blackColor];
}

- (void)setupView {
	self.layer.borderColor = self.trackBorderColor.CGColor;
	self.layer.borderWidth = 1.f;
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 5;
	self.backgroundColor = self.trackBackgroundColor;
	
	NSUInteger count = self.options.count;
	if (count > 0) {
		NSUInteger i = 0;
		CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)/count, CGRectGetHeight(self.bounds));
		CGPoint center = CGPointMake(frame.size.width/2, frame.size.height/2);
		
		// setup the selected overlay
		self.overlay = [[UIView alloc] initWithFrame:frame];
		[self.overlay setCenter:center];
		[self.overlay setBackgroundColor:self.segmentBackgroundColor];
		self.overlay.layer.borderColor = [self.segmentBorderColor CGColor];
		self.overlay.layer.borderWidth = 1.f;
		self.overlay.layer.masksToBounds = YES;
		self.overlay.layer.cornerRadius = self.layer.cornerRadius;
		[self addSubview:self.overlay];
		
		// setup the options
		NSMutableArray *optionsArray = [NSMutableArray arrayWithCapacity:count];
		for (NSString *title in self.options) {
    			NSAssert([title isKindOfClass:[NSString class]], @"Options must be NSString");
			
			UIButton *button = [[UIButton alloc] initWithFrame:frame];
			[button setBackgroundColor:[UIColor clearColor]];
			[button setCenter:center];
			[button setTitleColor:self.trackTextColor forState:UIControlStateNormal];
			[button setTitle:title forState:UIControlStateNormal];
			[button setTag:i++];
			[button.titleLabel setFont:self.trackFont];
			[button addTarget:self action:@selector(selectOption:) forControlEvents:UIControlEventTouchDown];
			[self addSubview:button];
			[optionsArray addObject:button];
			
			center.x += frame.size.width;
		}
		[self setSegments:optionsArray];
		[self setSelectedSegmentIndex:self.selectedSegmentIndex];
	}
}

- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment {
	if (segment > self.options.count) {
		segment = self.options.count - 1;
	}
	return [self.options objectAtIndex:segment];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
	@synchronized(self) {
		if (self.segments.count == 0) {
			_selectedSegmentIndex = selectedSegmentIndex;
			return;
		}
		
		UIButton *fromButton = [self.segments objectAtIndex:_selectedSegmentIndex];
		UIButton *toButton = [self.segments objectAtIndex:selectedSegmentIndex];
		
		if (self.overlay) {
			CGPoint center = toButton.center;
			CGFloat width = CGRectGetWidth(self.overlay.frame);
			center.x = width * (selectedSegmentIndex + 1) - width / 2;
			self.overlay.center = center;
		}
		
		[fromButton.titleLabel setFont:self.trackFont];
		[fromButton setTitleColor:self.trackTextColor forState:UIControlStateNormal];
		
		[toButton.titleLabel setFont:self.segmentFont];
		[toButton setTitleColor:self.segmentTextColor forState:UIControlStateNormal];
		
		_selectedSegmentIndex = selectedSegmentIndex;
	}
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex animated:(BOOL)animated {
	if (_selectedSegmentIndex == selectedSegmentIndex) {
		return;
	}

	if (!animated) {
		[self setSelectedSegmentIndex:selectedSegmentIndex];
		[self sendActionsForControlEvents:UIControlEventValueChanged];
		return;
	}
	
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	[UIView animateWithDuration:.1f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.selectedSegmentIndex = selectedSegmentIndex;
	} completion:^(__unused BOOL finished) {
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}];
}


#pragma mark - IBAction

- (IBAction)selectOption:(UIButton *)sender {
	[self sendActionsForControlEvents:UIControlEventTouchDown];
	[self setSelectedSegmentIndex:sender.tag animated:YES];
}

@end
