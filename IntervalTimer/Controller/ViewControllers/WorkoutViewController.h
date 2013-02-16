//
//  WorkoutViewController.h
//  IntervalTimer
//
//  Created by Tim Sawtell on 14/02/13.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    LastIntervalTypeWork,
    LastIntervalTypeRest
} LastIntervalType;

@interface WorkoutViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *timeBgView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
@property (weak, nonatomic) IBOutlet UITextField *workTextField;
@property (weak, nonatomic) IBOutlet UITextField *restTextField;
@property (weak, nonatomic) IBOutlet UILabel *runningTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutStatusLabel;
@property (weak, nonatomic) IBOutlet UISwitch *playSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwitch;

@end
