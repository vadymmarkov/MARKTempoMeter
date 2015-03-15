#import "MARKTempoMeter.h"

NSUInteger const kMARKTempoMeterMaxBeatInterval = 2;

@interface MARKTempoMeter ()

@property (nonatomic) NSDate *firstBeatTime;
@property (nonatomic) NSDate *lastBeatTime;
@property (nonatomic, assign) NSUInteger beats;

@end

@implementation MARKTempoMeter

#pragma mark - Initialization

+ (instancetype)sharedInstance;
{
    static dispatch_once_t once;
    static MARKTempoMeter *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (!self) return nil;

    [self setUpDefaults];

    return self;
}

#pragma mark - Configuration

- (void)setUpDefaults
{
    self.firstBeatTime = nil;
    self.lastBeatTime = nil;
    self.beats = 0;
}

#pragma mark - Public

- (void)handleNewBeat
{
    // Check if last handled beat was a long time ago
    if (self.firstBeatTime != nil && self.lastBeatTime != nil) {
        NSTimeInterval beatInterval = [self.lastBeatTime timeIntervalSinceDate:self.firstBeatTime];
        float seconds = (int)beatInterval % 60;
        NSLog(@"Uiui: %f", seconds);
        if (seconds > kMARKTempoMeterMaxBeatInterval) {
            [self reset];
        }
    }

    // Start beats handling
    if (self.beats == 0) {
        self.firstBeatTime = [NSDate date];
    }

    // Update BPM
    self.beats++;
    [self updateBpm];
}

#pragma mark - Private

- (void)reset
{
    [self setUpDefaults];
    [self updateBpm];
}

- (void)updateBpm
{
    if (self.beats > 1 && self.firstBeatTime != nil) {
        self.lastBeatTime = [NSDate date];
        NSTimeInterval interval = [self.lastBeatTime timeIntervalSinceDate:self.firstBeatTime];
        float minutes = interval / 60.0f;

        NSUInteger BPM = (self.beats - 1) / minutes;

        if([self.delegate respondsToSelector:@selector(tempoMeter:didUpdateBPM:)]) {
            [self.delegate tempoMeter:self didUpdateBPM:BPM];
        }

        if (self.updateBPMHandler) {
            self.updateBPMHandler(BPM);
        }
    }
}

@end
