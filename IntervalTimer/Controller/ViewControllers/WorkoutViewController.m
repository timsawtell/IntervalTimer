//
//  WorkoutViewController.m
//  IntervalTimer
//
//  Created by Tim Sawtell on 14/02/13.
//
//

#import "WorkoutViewController.h"
#import "TimerHelper.h"
#import <AudioToolbox/AudioServices.h>


@interface WorkoutViewController ()
@property (nonatomic, assign) BOOL timerRunning;
@property (nonatomic, assign) LastIntervalType lastInterval;
@property (nonatomic, assign) NSUInteger lastRestFinishedAtSecondsElapsed;
@property (nonatomic, assign) NSUInteger lastWorkFinishedAtSecondsElapsed;
@property (nonatomic, assign) SystemSoundID completedSound;
@end

@implementation WorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bgView.layer.cornerRadius = 5.0f;
    self.workTextField.layer.cornerRadius = 5.0f;
    self.restTextField.layer.cornerRadius = 5.0f;
    self.timeBgView.layer.cornerRadius = 5.0f;
    self.toggleButton.layer.cornerRadius = 5.0f;
    self.statusBgView.layer.cornerRadius = 5.0f;
    self.workTextField.inputAccessoryView = [self accessoryView];
    self.restTextField.inputAccessoryView = [self accessoryView];
    self.lastInterval = LastIntervalTypeRest;
    
    NSString *soundPath =  [[NSBundle mainBundle] pathForResource:@"alert" ofType:@"aif"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &_completedSound);
    
    [self reloadData];
}

- (void)reloadData
{
    self.workTextField.text = self.timer.workInterval.stringValue;
    self.restTextField.text = self.timer.restInterval.stringValue;
    self.soundButton.alpha = self.timer.playAlertSoundValue ? 1 : kAlphaForHighlightedButtons;
    self.vibrateButton.alpha = self.timer.vibrateValue ? 1 : kAlphaForHighlightedButtons;
    [self resetRunningTimer];
    self.runningTimeLabel.text = [TimerHelper stringForTimeInterval:0];
}

- (void)resetRunningTimer
{
    [[Model sharedModel].runningTimer invalidate];
    [Model sharedModel].runningTimer = nil;
}

- (void)endEditing
{
    [self.view endEditing:YES];
}

- (void)viewDidUnload
{
    [self setToggleButton:nil];
    [self setTimeBgView:nil];
    [self setWorkTextField:nil];
    [self setRestTextField:nil];
    [self setRunningTimeLabel:nil];
    [self setWorkoutStatusLabel:nil];
    [self setStatusBgView:nil];
    [self setSoundButton:nil];
    [self setVibrateButton:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setBgView:nil];
}

- (IBAction)toggleButtonPressed:(id)sender
{
    if (self.timerRunning) {
        [self stopTimer];
        [self.toggleButton setTitle:@"Begin" forState:UIControlStateNormal];
        self.toggleButton.backgroundColor = [UIColor colorWithHexString:@"#528112"];
    } else {
        [self startTimer];
        [self.toggleButton setTitle:@"End" forState:UIControlStateNormal];
        self.toggleButton.backgroundColor = [UIColor colorWithHexString:@"#B15E5C"];
    }
}

- (void)startTimer
{
    self.timerRunning = YES;
    self.timer.startTime = [NSDate date];
    self.workTextField.userInteractionEnabled = NO;
    self.restTextField.userInteractionEnabled = NO;
    self.workoutStatusLabel.text = @"Working";
    [Model sharedModel].runningTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                        target:self
                                                                      selector:@selector(timerTicked)
                                                                      userInfo:nil
                                                                       repeats:YES];
    
}

- (IBAction)soundToggled:(id)sender
{
    [Model sharedModel].timer.playAlertSoundValue = ![Model sharedModel].timer.playAlertSoundValue;
    if (![Model sharedModel].timer.playAlertSoundValue) {
        self.soundButton.alpha = kAlphaForHighlightedButtons;
    } else {
        self.soundButton.alpha = 1;
    }
}

- (IBAction)vibrateToggled:(id)sender
{
    [Model sharedModel].timer.vibrateValue = ![Model sharedModel].timer.vibrateValue;
    if (![Model sharedModel].timer.vibrateValue) {
        self.vibrateButton.alpha = kAlphaForHighlightedButtons;
    } else {
        self.vibrateButton.alpha = 1;
    }
}

- (void)stopTimer
{
    [self resetRunningTimer];
    self.lastWorkFinishedAtSecondsElapsed = 0;
    self.lastRestFinishedAtSecondsElapsed = 0;
    self.workTextField.userInteractionEnabled = YES;
    self.restTextField.userInteractionEnabled = YES;
    self.workoutStatusLabel.text = @"--";
    self.timerRunning = NO;
    self.lastInterval = LastIntervalTypeRest;
}

- (void)timerTicked
{
    NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:self.timer.startTime];
    self.runningTimeLabel.text = [TimerHelper stringForTimeInterval:timeDiff];
    
    NSUInteger timeDiffInt = (int)timeDiff;
    switch (self.lastInterval) {
        case LastIntervalTypeRest:
        {
            if (timeDiffInt >= self.lastRestFinishedAtSecondsElapsed + self.timer.workIntervalValue) {
                NSLog(@"timeToRest");
                self.lastInterval = LastIntervalTypeWork;
                self.lastWorkFinishedAtSecondsElapsed = timeDiffInt;
                if (self.timer.vibrateValue) {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                if (self.timer.playAlertSoundValue) {
                    AudioServicesPlaySystemSound(self.completedSound);
                }
                self.workoutStatusLabel.text = @"Resting";
            }
        }
            break;
        case LastIntervalTypeWork:
        {
            if (timeDiffInt >= self.lastWorkFinishedAtSecondsElapsed + self.timer.restIntervalValue) {
                NSLog(@"timeToWork");
                self.lastInterval = LastIntervalTypeRest;
                self.lastRestFinishedAtSecondsElapsed = timeDiffInt;
                if (self.timer.vibrateValue) {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                if (self.timer.playAlertSoundValue) {
                    AudioServicesPlaySystemSound(self.completedSound);
                }
                self.workoutStatusLabel.text = @"Working";
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.workTextField) {
        self.timer.workInterval = [[[NSNumberFormatter alloc] init] numberFromString:textField.text];
    } else {
        self.timer.restInterval = [[[NSNumberFormatter alloc] init] numberFromString:textField.text];
    }
    [self reloadData];
}

#pragma mark - helper

- (Timer *)timer
{
    return [Model sharedModel].timer;
}

- (NSTimer *)runningTimer
{
    return [Model sharedModel].runningTimer;
}

- (UIView *)accessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *btn  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endEditing)];
    toolbar.items = [NSArray arrayWithObject:btn];
    return toolbar;
}

- (void)dealloc
{
    AudioServicesRemoveSystemSoundCompletion(self.completedSound);
}

@end
