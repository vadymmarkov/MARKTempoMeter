#import "ViewController.h"
#import "MARKTempoMeter.h"
#import "UIColor+Demo.h"

static CGFloat const kViewControllerLabelWidth = 200.0;
static CGFloat const kViewControllerButtonWidth = 200.0;
static CGFloat const kViewControllerButtonHeight = 150.0;

@interface ViewController () <MARKTempoMeterDelegate>

@property (nonatomic) UILabel *label;
@property (nonatomic) UIButton *button;

@property (nonatomic, assign) NSUInteger beatsPerMinute;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Additional setup after loading the view
    self.title = @"BPM Demo";
    self.view.backgroundColor = [UIColor backgroundColor];

    self.beatsPerMinute = 0;

    __weak typeof(self) weakSelf = self;
    [MARKTempoMeter sharedInstance].updateBPMHandler = ^(NSUInteger BPM) {
        weakSelf.beatsPerMinute = BPM;
        [weakSelf updateText];
    };

    [self setUpViewComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat labelX = (CGRectGetWidth(self.view.frame) - kViewControllerLabelWidth) / 2;
    self.label.frame = CGRectMake(labelX, 110.0, kViewControllerLabelWidth, 20.0);

    CGFloat buttonX = (CGRectGetWidth(self.view.frame) - kViewControllerButtonWidth) / 2;
    self.button.frame = CGRectMake(buttonX, CGRectGetMaxY(self.label.frame) + 20.0, kViewControllerButtonWidth, kViewControllerButtonHeight);
}

#pragma mark - Actions

- (void)buttonDidTouchUpInside:(UIButton *)button
{
    [[MARKTempoMeter sharedInstance] handleNewBeat];
}

#pragma mark - UI

- (void)setUpViewComponents
{
    // Text label
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.backgroundColor = [UIColor backgroundColor];
    self.label.numberOfLines = 1;
    self.label.textColor = [UIColor secondaryTextColor];
    self.label.textAlignment = NSTextAlignmentCenter;

    // Init button
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.backgroundColor = [UIColor secondaryColor];
    self.button.tintColor = [UIColor whiteColor];
    self.button.titleLabel.font = [UIFont systemFontOfSize:42];
    [self.button setTitle:@"TAP" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

    [self updateText];

    [self.view addSubview:self.label];
    [self.view addSubview:self.button];
}

- (void)updateText
{
    NSLog(@"BPM: %lu", self.beatsPerMinute);
    self.label.text = [NSString stringWithFormat:@"%lu",
                       self.beatsPerMinute];
}

#pragma mark - MARKTempoMeterDelegate

- (void)tempoMeter:(MARKTempoMeter *)tempoMeter didUpdateBPM:(NSUInteger)BPM
{
    // Silence
    // In the current example we use blocks instead
}

@end
