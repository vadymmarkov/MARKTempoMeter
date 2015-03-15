@import Foundation;

@protocol MARKTempoMeterDelegate;

@interface MARKTempoMeter : NSObject

@property (nonatomic, weak) id <MARKTempoMeterDelegate> delegate;

@property (nonatomic, copy) void (^updateBPMHandler)(NSUInteger BPM);

+ (instancetype)sharedInstance;

- (void)handleNewBeat;

@end

@protocol MARKTempoMeterDelegate <NSObject>

- (void)tempoMeter:(MARKTempoMeter *)tempoMeter didUpdateBPM:(NSUInteger)BPM;

@end
