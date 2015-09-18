//
//  CHTrigger.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHTrigger.h"

@implementation CHTrigger

-(id)initWithValue:(double)value withAction:(CHTriggerActionType)action ofType:(CHTriggerType)type forMediaType:(CHMediaTypeString)mediaTypeAsString error:(NSError **)error {
    if (self = [super init]) {
        // custom initialization
        
        _isArmed = false;
        
        // init value
        if(value < 0.0){
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger with a negative value"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:2 userInfo:tempDic];
            
        } else {
            _value = [NSNumber numberWithDouble:value];
        }
        
        // init action
        if(!action){
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger because action is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:5 userInfo:tempDic];
        } else {
            _action = action;
        }
        
        // init type
        if(type != CHMediaTypeUnknown){
            _type = type;
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger because type is unknown"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:1 userInfo:tempDic];
        }
        
        // init mediatype
        if(mediaTypeAsString){
            if([mediaTypeAsString isEqualToString:CHMediaTypeStringUnknown]){
                NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger because mediaType is unknown"};
                *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:4 userInfo:tempDic];
            } else {
                _mediaTypeAsString = mediaTypeAsString;
            }
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create trigger because mediaType is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Trigger.ErrorDomain" code:3 userInfo:tempDic];
        }
        
        if(!_value || !_type || !_mediaTypeAsString){
            self = nil;
        }
    }
    
    return self;
}

-(void) arm:(CHVoidBlock)fireBlock {
    if(fireBlock){
        _fireBlock = fireBlock;
        
        switch (_type) {
            case CHTriggerTypeUnknown:
                break;
            case CHTriggeredAtTime:
                break;
            default:
            {
                //case CHTriggeredByServerSentEvent, CHTriggeredByUserInteraction
                NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
                nf.numberStyle = NSNumberFormatterDecimalStyle;
                NSString *value = [nf stringFromNumber:_value];
                NSString *triggerString = [NSString stringWithFormat:@"%@-%@-%@", _mediaTypeAsString, value, _action];
                NSLog(@"arming trigger for NSNotification: %@", triggerString);
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullWithNotification:) name:triggerString object:nil];
            
                break;
            }
        }
        
        _isArmed = true;
    } else {
        // TODO add error handling
    }
}

-(void) disarm {
    [self removeObservers];
    _fireBlock = nil;
    _isArmed = false;
}

// ncbt not covered by unit test
-(void) removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) pull {
    if(_isArmed){
        if(_fireBlock){
            _fireBlock();
        }
    }
}

-(void) pullWithNotification:(NSNotification *) notification {
    [self pull];
}

-(void)dealloc {
    //NSLog(@"deallocating trigger");
    [self disarm];
}

@end
