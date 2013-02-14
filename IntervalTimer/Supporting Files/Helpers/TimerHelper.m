//
//  TimerHelper.m
//  IntervalTimer
//
//  Created by Tim Sawtell on 14/02/13.
//
//

#import "TimerHelper.h"

@implementation TimerHelper

+ (NSString *)stringForTimeInterval:(NSTimeInterval)timeInterval
{
    NSInteger hours = timeInterval / kSecondsPerHour;
    NSInteger mins = (timeInterval - (hours * kSecondsPerHour)) / 60;
    NSInteger secs = (timeInterval - (hours * kSecondsPerHour)) - (mins * 60);
    NSString *h = [[NSString stringWithFormat:@"%02d", hours] substringToIndex:2];
    NSString *m = [[NSString stringWithFormat:@"%02d", mins] substringToIndex:2];
    NSString *s = [[NSString stringWithFormat:@"%02d", secs] substringToIndex:2];
    NSString *dateString = [NSString stringWithFormat:@"%@:%@:%@", h, m, s];
    return dateString;
}

@end
