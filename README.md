# KWSegmentedControl

Simple and customisable segmentation controls.

## Requirements

- Objective-C ARC
- iOS 7 or above (<7 untested)

## Installation
### Cocoapods

    pod 'KWSegmentedControl'

###Manual

You can manually install the library by copying the `KWSegmentedControl.h` and `KWSegmentedControl.m` into your project.

## Example

    - (void)viewDidLoad {
        [super viewDidLoad];
        KWSegmentedControl *control = [[KWSegmentedControl alloc] initWithFrame:frame];
        control.options = @[@“Segment One", @"Segment Two"];
        control.delegate = self;
        [self.view addSubview:control];
    }

    #pragma mark - KWSegmentedControlDelegate

    - (void)segmentedControl:(KWSegmentedControl *)segmentedControl willChangeToIndex:(NSUInteger)index {
        NSString *title = [segmentedControl titleAtIndex:index];
        NSLog(@“Selected segment %@“, title);
    }

## License

The MIT License (MIT)

Copyright (c) 2014 Kurt Wagner

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

