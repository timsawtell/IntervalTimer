//
//  _Timer.h
//
//  $Id$
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Timer.h instead.
//


#import <Foundation/Foundation.h>
#import "ModelObject.h"



@protocol _Timer

@end

extern NSString * const kModelPropertyTimerName;
extern NSString * const kModelPropertyTimerRestInterval;
extern NSString * const kModelPropertyTimerStartTime;
extern NSString * const kModelPropertyTimerWorkInterval;


extern NSString * const kModelDictionaryTimerName;
extern NSString * const kModelDictionaryTimerRestInterval;
extern NSString * const kModelDictionaryTimerStartTime;
extern NSString * const kModelDictionaryTimerWorkInterval;


@interface _Timer : ModelObject <NSCoding>

{
	NSString* name;
	NSNumber* restInterval;
	NSDate* startTime;
	NSNumber* workInterval;
	
	
}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSNumber* restInterval;@property int32_t restIntervalValue;
@property (nonatomic, strong) NSDate* startTime;
@property (nonatomic, strong) NSNumber* workInterval;@property int32_t workIntervalValue;



@end
