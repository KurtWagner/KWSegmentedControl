// KWSegmentedControl.h
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

#import <UIKit/UIKit.h>

@class KWSegmentedControl;

/// Simple customizable segmented control with delegate
@interface KWSegmentedControl : UIControl

#pragma mark - Styling Options

/// Background color of the segment track (background)
@property (nonatomic, strong) UIColor *trackBackgroundColor;

/// Border color of the segment track (background)
@property (nonatomic, strong) UIColor *trackBorderColor;

/// Color of text found on the segment track (background)
@property (nonatomic, strong) UIColor *trackTextColor;

/// Font of text on the track (background)
@property (nonatomic, strong) UIFont *trackFont;

/// Color of text for selected segment (foreground)
@property (nonatomic, strong) UIColor *segmentTextColor;

/// Font for selected segment (foreground)
@property (nonatomic, strong) UIFont *segmentFont;

/// Background color for selected segment (foreground)
@property (nonatomic, strong) UIColor *segmentBackgroundColor;

/// Border color for selected segment (foreground)
@property (nonatomic, strong) UIColor *segmentBorderColor;

/// Array of titles
@property (nonatomic, strong) NSArray *options;

#pragma mark - UISegmentedControl

/// The index number identifying the selected segment (that is, the last segment touched).
@property(nonatomic) NSInteger selectedSegmentIndex;

/**
 *  Returns the title of the specified segment.
 *
 *  @param segment An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
 *
 *  @return Returns the string (title) assigned to the receiver as content. If no title has been set, it returns nil.
 */
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment;

/**
 *  Set the selected segment index value with an option to animate the transition.
 *
 *  @param selectedSegmentIndex Index of the segment to select
 *  @param animated             Flag indicating whether the transition should be animated
 */
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex animated:(BOOL)animated;

@end
