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

#import "AsynchronousCommand.h"

@implementation AsynchronousCommand
@synthesize commandCompletionBlock, multiThreaded, finished, executing;

- (void) start
{
    [self setFinished: NO];
    [self main];
}

- (void) main
{
    //set the NSOperation's completionBlock which occurs at the end of main
    self.completionBlock = ^{
        if (self.commandCompletionBlock != NULL) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.commandCompletionBlock(self.error);
            });
        }
    };
    //subclass should override execute to perform the logic of the command
    [self execute];
    
    //subclass MUST call [self finish] at the appropriate time, generally in the commandCompletionBlock
}


- (BOOL)isMultiThreaded
{
    return YES;
}

- (void)cancel
{
    for (Command *cmd in self.subCommands) {
        [cmd cancel];
    }
    //in subclasses add your logic to cancel the processing in execute.
}

- (void) setFinished:(BOOL) isFinished
{
    [self setExecuting: !isFinished];
    [self willChangeValueForKey: @"isFinished"];
    finished = isFinished;
    [self didChangeValueForKey: @"isFinished"];
}

- (void) setExecuting:(BOOL) isExecuting
{
    [self willChangeValueForKey: @"isExecuting"];
    executing = isExecuting;
    [self didChangeValueForKey: @"isExecuting"];
}

- (void) finish
{
    [self setFinished: YES];
}

@end
