/*
 Copyright (c) 2012 Tim Sawtell
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
 IN THE SOFTWARE.
 */

#import "Constants.h"

@implementation Constants

NSString * const kLongDateFormat = @"eee MMM dd HH:mm:ss ZZZZ yyyy";
NSString * const kTestFlightSDKKey = @"";
NSString * const kDateFormat = @"dd-MMM-yyyy";
NSString * const kRegexForEmail = @"^([a-zA-Z0-9\\+\\_\\-\\.]+)@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,4})$";
NSString * const kModelSavedDataFileName = @"IntervalTimer.dat";

CGFloat const kAlphaForHighlightedButtons = 0.3f;
CGFloat const kSizeOfCornerRounding = 3.0f;
CGFloat const kSecondsPerDay = 86400;
CGFloat const kSecondsPerHour = 3600;

@end
