//
//  CHTrigger.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHTrigger.h"

@implementation CHTrigger

-(id)initWithValue:(double)value andType:(CHTriggerType)type error:(NSError **)error {
    if (self = [super init]) {
        // custom initialization
        
        // init value
        if(value < 0.0){
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger with a negative value"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:2 userInfo:tempDic];
            
        } else {
            _value = [NSNumber numberWithDouble:value];
        }
        
        // init type
        if(type != CHMediaTypeUnknown){
            _type = type;
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger because type is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:1 userInfo:tempDic];
        }
        
        if(!_value || !_type){
            self = nil;
        }
    }
    
    return self;
}
@end
