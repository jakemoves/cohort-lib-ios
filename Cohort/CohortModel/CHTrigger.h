//
//  CHTrigger.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cohort.h"

@interface CHTrigger : NSObject

@property (readonly, nonatomic) CHTriggerType type;
@property (nonatomic) NSNumber *value;

-(id)initWithValue:(double)value andType:(CHTriggerType)type error:(NSError **)error;
// add parent of protocol cueable

// add arm() method which activates notification with @fire()
// add disarm() method which deactivates notification
// add fire() method which triggers [cueableParent fire]

@end
