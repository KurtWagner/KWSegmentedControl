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

/// Listen to changes in the segmented control
@protocol KWSegmentedControlDelegate <NSObject>
@optional
/**
 *  A segmented control will change to this.
 *  @param segmentedControl Segmented Control that will change
 *  @param index            Index changing to
 */
- (void)segmentedControl:(KWSegmentedControl *)segmentedControl willChangeToIndex:(NSUInteger)index;

/**
 *  A segmented control did change to this.
 *  @param segmentedControl Segmented control that did change
 *  @param index            Index did change to
 */
- (void)segmentedControl:(KWSegmentedControl *)segmentedControl didChangeToIndex:(NSUInteger)index;
@end

/// Simple customizable segmented control with delegate
@interface KWSegmentedControl : UIView

/// KWSegmentedControl
@property (nonatomic, weak) id<KWSegmentedControlDelegate> delegate;

/// Array of titles
@property (nonatomic, strong) NSArray *options;

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

/**
 *  Returns the title of the option at a given index
 *  @param index
 *  @return Title at given index
 */
- (NSString *)titleAtIndex:(NSUInteger)index;

/**
 *  Returns the selected segment's index
 *  @return selected segment's index
 */
- (NSUInteger)selectedIndex;

/**
 *  Returns the selected segment's title
 *  @return Title of selected segment
 */
- (NSString *)selectedTitle;

/**
 *  Sets the selected index
 *  @param index Index to set selected to
 */
- (void)setSelectedIndex:(NSUInteger)index;

@end
