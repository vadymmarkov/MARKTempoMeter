@import XCTest;

#import "MARKTempoMeter.h"

@interface MARKTempoMeter ()

@property (nonatomic) NSDate *firstBeatTime;
@property (nonatomic) NSDate *lastBeatTime;
@property (nonatomic, assign) NSUInteger beats;

- (void)reset;

@end

@interface MARKTempoMeterTests : XCTestCase <MARKTempoMeterDelegate>

@property (nonatomic) MARKTempoMeter *tempoMeter;
@property (nonatomic, assign) NSUInteger beatsPerMinute;

@end

@implementation MARKTempoMeterTests

#pragma mark - Helper methods

- (MARKTempoMeter *)sharedInstance
{
    return [MARKTempoMeter sharedInstance];
}

- (MARKTempoMeter *)uniqueInstance
{
    return [[MARKTempoMeter alloc] init];
}

- (void)setUp
{
    [super setUp];
    self.tempoMeter = [self uniqueInstance];
    self.beatsPerMinute = 0;
}

- (void)tearDown
{
    self.tempoMeter = nil;
    self.beatsPerMinute = 0;
    [super tearDown];
}

#pragma mark - MARKTempoMeterDelegate

- (void)tempoMeter:(MARKTempoMeter *)tempoMeter didUpdateBPM:(NSUInteger)BPM
{
    self.beatsPerMinute = BPM;
}

#pragma mark - Instance Tests

- (void)testSharedInstanceCreated
{
    XCTAssertNotNil([self sharedInstance], @"MARKTempoMeter shared instance should not be nil");
}

- (void)testUniqueInstanceCreated
{
    XCTAssertNotNil([self uniqueInstance], @"MARKTempoMeter unique instance should not be nil");
}

- (void)testWeGetSameSharedInstanceTwice
{
    MARKTempoMeter *tempoMeter = [self sharedInstance];
    XCTAssertEqual(tempoMeter, [self sharedInstance]);
}

- (void)testWeGetSeparateUniqueInstances
{
    MARKTempoMeter *tempoMeter = [self uniqueInstance];
    XCTAssertNotEqual(tempoMeter, [self uniqueInstance]);
}

- (void)testSharedInstanceSeparateFromUniqueInstance
{
    MARKTempoMeter *tempoMeter = [self sharedInstance];
    XCTAssertNotEqual(tempoMeter, [self uniqueInstance]);
}

#pragma mark - Init tests

- (void)testDefaultsAfterInit
{
    XCTAssertNil(self.tempoMeter.firstBeatTime, @"firstBeatTime should be nil after init");
    XCTAssertNil(self.tempoMeter.lastBeatTime, @"lastBeatTime should be nil after init");
    XCTAssertEqual(self.tempoMeter.beats, 0,
                   @"beats after init is %lu but it should be %i", self.tempoMeter.beats, 0);

}

#pragma mark - Functionality tests

- (void)testHandleNewBeat
{
    [self.tempoMeter handleNewBeat];
    XCTAssertNotNil(self.tempoMeter.firstBeatTime, @"firstBeatTime should not be nil after new beat");
    XCTAssertEqual(self.tempoMeter.beats, 1,
                   @"beats after new beat is %lu but it should be %i", self.tempoMeter.beats, 1);

    [self.tempoMeter handleNewBeat];
    XCTAssertNotNil(self.tempoMeter.firstBeatTime, @"firstBeatTime should not be nil after handling of new beat");
    XCTAssertNotNil(self.tempoMeter.lastBeatTime, @"lastBeatTime should not be nil after handling of new beat");
    XCTAssertEqual(self.tempoMeter.beats, 2,
                   @"beats after new beat is %lu but it should be %i", self.tempoMeter.beats, 2);
}

- (void)testHandleNewBeatWithDelegate
{
    self.tempoMeter.delegate = self;

    [self.tempoMeter handleNewBeat];
    [self.tempoMeter handleNewBeat];

    XCTAssertNotEqual(self.beatsPerMinute, 0, @"Delegate method wasn't called");
}

- (void)testHandleNewBeatWithBlockHanler
{
    __weak typeof(self) weakSelf = self;
    self.tempoMeter.updateBPMHandler = ^(NSUInteger BPM){
        weakSelf.beatsPerMinute = BPM;
    };

    [self.tempoMeter handleNewBeat];
    [self.tempoMeter handleNewBeat];

    XCTAssertNotEqual(self.beatsPerMinute, 0, @"Block handler wasn't called");
}

- (void)testReset
{
    [self.tempoMeter reset];

    XCTAssertNil(self.tempoMeter.firstBeatTime, @"firstBeatTime should be nil after reset");
    XCTAssertNil(self.tempoMeter.lastBeatTime, @"lastBeatTime should be nil after reset");
    XCTAssertEqual(self.tempoMeter.beats, 0,
                   @"beats after reset is %lu but it should be %i", self.tempoMeter.beats, 0);

}

@end
