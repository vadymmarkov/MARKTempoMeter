# MARKTempoMeter

[![Version](https://img.shields.io/cocoapods/v/MARKTempoMeter.svg?style=flat)](http://cocoadocs.org/docsets/MARKTempoMeter)
[![License](https://img.shields.io/cocoapods/l/MARKTempoMeter.svg?style=flat)](http://cocoadocs.org/docsets/MARKTempoMeter)
[![Platform](https://img.shields.io/cocoapods/p/MARKTempoMeter.svg?style=flat)](http://cocoadocs.org/docsets/MARKTempoMeter)

A simple tool to determine the BPM (beats per minute). Could be useful for any task that requires the measurement of tempo (tap controls for drum machines, metronomes, etc).

Please check Demo project for a basic example on how to use MARKTempoMeter.

## Usage

#### In your code
```objc
// To handle every new beat
- (void)buttonDidTouchUpInside:(UIButton *)button
{
    [[MARKTempoMeter sharedInstance] handleNewBeat];
}

// To receive current BPM via block
[MARKTempoMeter sharedInstance].updateBPMHandler = ^(NSUInteger BPM) {
    NSLog(@"BPM: %lu", BPM);
};

// To receive current BPM via delegate
- (void)tempoMeter:(MARKTempoMeter *)tempoMeter didUpdateBPM:(NSUInteger)BPM
{
    NSLog(@"BPM: %lu", BPM);
}
```

## Installation

**MARKTempoMeter** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

`pod 'MARKTempoMeter'`

## Author

Vadym Markov, impressionwave@gmail.com

## License

**MARKTempoMeter** is available under the MIT license. See the LICENSE file for more info.
