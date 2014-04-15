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

/// The current selected button
@property (nonatomic, strong) UIButton *selectedButton;

/// Array containing buttons in segment
@property (nonatomic, strong) NSArray *buttonOptions;

@end

@implementation KWSegmentedControl {
	NSUInteger __selectedIndex;
}

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
		if (!self.overlay) {
			self.overlay = [[UIView alloc] initWithFrame:frame];
		}
		[self.overlay setCenter:center];
		[self.overlay setBackgroundColor:self.segmentBackgroundColor];
		self.overlay.layer.borderColor = [self.segmentBorderColor CGColor];
		self.overlay.layer.borderWidth = 1.f;
		self.overlay.layer.masksToBounds = YES;
		self.overlay.layer.cornerRadius = self.layer.cornerRadius;
		[self addSubview:self.overlay];
		
		
		for (UIButton *button in self.buttonOptions) {
			[button removeFromSuperview];
		}
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
		[self setButtonOptions:optionsArray];
		
		// setup the selected option view
		self.selectedButton = [self.buttonOptions objectAtIndex:self.selectedIndex];
		CGFloat width = CGRectGetWidth(self.overlay.frame);
		center.x = width * (self.selectedButton.tag + 1) - width / 2;
		self.overlay.center = center;
		[self.selectedButton.titleLabel setFont:self.segmentFont];
		[self.selectedButton setTitleColor:self.segmentTextColor forState:UIControlStateNormal];
	}
}

- (NSString *)titleAtIndex:(NSUInteger)index {
	if (index >= self.options.count) {
		return nil;
	}
	return [self.options objectAtIndex:index];
}

- (NSUInteger)selectedIndex {
	return __selectedIndex;
}

- (NSString *)selectedTitle {
	return [self titleAtIndex:self.selectedIndex];
}

- (void)setSelectedIndex:(NSUInteger)index {
	__selectedIndex = index;
	if (index >= self.buttonOptions.count) {
		return;
	}
	self.selectedButton = [self.buttonOptions objectAtIndex:index];
}

#pragma mark - IBAction

- (IBAction)selectOption:(UIButton *)sender {
	if (sender == self.selectedButton) {
		return;
	}
	
	NSUInteger index = sender.tag;
	CGPoint center = sender.center;
	CGFloat width = CGRectGetWidth(self.overlay.frame);
	center.x = width * (index + 1) - width / 2;
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControl:willChangeToIndex:)]) {
		[self.delegate segmentedControl:self willChangeToIndex:index];
	}
	
	[UIView animateWithDuration:.1f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.overlay.center = center;
		[sender.titleLabel setFont:self.segmentFont];
		[sender setTitleColor:self.segmentTextColor forState:UIControlStateNormal];
		
		[self.selectedButton.titleLabel setFont:self.trackFont];
		[self.selectedButton setTitleColor:self.trackTextColor forState:UIControlStateNormal];
		
	} completion:^(__unused BOOL finished) {
		if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControl:didChangeToIndex:)]) {
			[self.delegate segmentedControl:self didChangeToIndex:index];
		}
		__selectedIndex = index;
		self.selectedButton = sender;
	}];
}

- (void)setOptions:(NSArray *)options {
	_options = options;
	
	[self setupView];
}

@end
