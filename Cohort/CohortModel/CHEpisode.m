//
//  CHEpisode.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-15.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHEpisode.h"

@implementation CHEpisode

@synthesize targetTags = _targetTags;
@synthesize mediaType = _mediaType;
@synthesize mediaTypeAsString = _mediaTypeAsString;
@synthesize triggers = _triggers;
@synthesize isLoaded = _isLoaded;
@synthesize isRunning = _isRunning;
@synthesize duration = _duration;
@synthesize completionBlock = _completionBlock;

- (id)initWithId:(NSString *)episodeId withSession:(CHSession *)session andCues:(NSSet *)cues withTriggers:(NSArray *)triggers withCompletionBlock:(CHVoidBlock)completionBlock error:(NSError **)error {
    if (self = [super init]) {
        // custom initialization
        
        NSMutableArray *tempCues = nil;
        
        _mediaType = CHMediaTypeEpisode;
        _mediaTypeAsString = CHMediaTypeStringEpisode;
        
        _isRunning = false;
        _isLoaded = false;
        
        _completionBlock = completionBlock;
        
        if(episodeId){
            if([episodeId isEqualToString:@""]){
                NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create episode because the episodeId is an empty string"};
                *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:5 userInfo:tempDic];
            } else {
                _episodeId = episodeId;
            }
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create episode because the episodeId is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:4 userInfo:tempDic];
        }
        
        if(session){
            _session = session;
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create episode because the session is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:6 userInfo:tempDic];
        }
        
        if(cues){
            if(cues.count == 0){
                _cues = nil;
                
                NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create episode because the cueset is empty"};
                *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:2 userInfo:tempDic];
            } else {
                // create cues set
                for(id<NSObject, CHCueable> cue in cues){
                    if([cue conformsToProtocol:@protocol(CHCueable)]){
                        if(tempCues){
                            [tempCues addObject:cue];
                        } else {
                            tempCues = [[NSMutableArray alloc] initWithObjects:cue, nil];
                        }
                    } else {
                        NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not add cue to episode because the cue is not valid"};
                        *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:3 userInfo:tempDic];
                    }
                }
            }
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create episode because the cueset is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:1 userInfo:tempDic];
        }
        
        if(triggers){
            _triggers = triggers;
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Warning: episode with no triggers will never play"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:6 userInfo:tempDic];
        }
        
        if(tempCues) {
            _cues = [NSSet setWithArray:tempCues];
            tempCues = nil;
        }
        
        if(!_episodeId || !_session || !_cues){
            self = nil;
        }
    }
    
    return self;
}

-(void) loadForParticipant:(CHParticipant *)participant error:(NSError **)error {
    
    if(participant){
        _participant = participant;
    } else {
        NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not load episode because the participant is nil"};
        *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:7 userInfo:tempDic];
        return;
    }
    
    if(_participant){
#ifdef DEBUG
        NSLog(@"loading episode");
#endif
        NSError *loadError = nil;
        [self load:&loadError];
        if(loadError){
            *error = loadError;
        }
    }
}

// CHCueable ________________________

-(void) load:(NSError **)error {
    
    if(_triggers && _triggers.count > 0){
        for(CHTrigger *trigger in _triggers){
#ifdef DEBUG
            NSLog(@"arming trigger for episode");
#endif
            __weak id weakSelf = self;
            [trigger arm:^{
                [weakSelf fire];
            }];
        }
    } else {
        NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not load episode with no triggers"};
        *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:8 userInfo:tempDic];
    }
    
    NSError *cueError = nil;
    if(_participant){
        for(id<NSObject, CHCueable> cue in _cues){
            if([cue.targetTags intersectsSet:_participant.tags]){
                [cue load:&cueError];
            }
        }
#ifdef DEBUG
        NSLog(@"loaded cues for episode");
#endif
    } else {
        NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not load episode with nil participant"};
        *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:9 userInfo:tempDic];
    }
    
    _isLoaded = true;
#ifdef DEBUG
    NSLog(@"finished loading episode");
#endif
}

-(void) fire {
    if(_isLoaded){
        [self play];
    }
}

-(void) play {
    _startTime = [AEBlockScheduler now];
    _isRunning = true;
    
    // this was a performance hack but may not be necessary anymore
    // get cues with timed triggers at 0 secs and start them playing ASAP
    NSSet *timedCues = [self cuesWithTriggersOfType:CHTriggeredAtTime];
    NSSet *immediateCues = [timedCues objectsPassingTest:^BOOL(id<CHCueable> obj, BOOL *stop) {
        if(obj.triggers.count > 0){
            for(CHTrigger *trigger in obj.triggers){
                if(((double)[trigger.value doubleValue] == 0.0) && ([obj.targetTags intersectsSet:_participant.tags])){
                    return YES;
                }
            }
            return NO;
        } else {
            return NO;
        }
    }];
    
    for(id<CHCueable> cue in immediateCues){
        // [cue.completionBlock = ^void{}];
        [cue fire];
    }
    // end hack
    
    // schedule all timed triggers
    for(id<CHCueable> cue in [self cuesWithTriggersOfType:CHTriggeredAtTime]){
        double timestamp;
        for(CHTrigger *trigger in cue.triggers){
            if(((double)[trigger.value doubleValue] != 0.0) && ([cue.targetTags intersectsSet:_participant.tags])){
                timestamp = [AEBlockScheduler timestampWithSeconds:[trigger.value longLongValue] fromTimestamp:_startTime];
#ifdef DEBUG
                NSLog(@"scheduling cue %@ for playback at %@", cue, trigger.value);
#endif
                [self scheduleForExecutionAtTime:timestamp withMainThreadBlock:^{
                    [trigger pull];
                }];
            }
        }
    }

    _isRunning = true;
}

-(void) pause {
    
}

- (NSSet *)cuesOfMediaType: (CHMediaType)mediaType {
    NSSet *cueSubset = [_cues objectsPassingTest:^BOOL(id<CHCueable> obj, BOOL *stop) {
        CHMediaType cueType = (CHMediaType)obj.mediaType;
        if(cueType == mediaType){
            return YES;
        } else {
            return NO;
        }
    }];
    return cueSubset;
}

// end CHCueable
// ______________________________________


- (NSSet *)cuesWithTriggersOfType: (CHTriggerType)triggerType {
    NSSet *cueSubset = [_cues objectsPassingTest:^BOOL(id<CHCueable> obj, BOOL *stop) {
        if(obj.triggers){
            if(obj.triggers.count > 0){
                for(CHTrigger *trigger in obj.triggers){
                    CHTriggerType cueType = (CHTriggerType)trigger.type;
                    if(cueType == triggerType){
                        return YES;
                    }
                }
                return NO;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    }];
    return cueSubset;
}

- (void)scheduleForExecutionAtTime:(uint64_t)timestamp
      withMainThreadBlock:(void (^)())cueBlock
 withCoreAudioThreadBlock:(void (^)())coreAudioBlock
{
    [_session.scheduler scheduleBlock:^(const AudioTimeStamp *time, UInt32 offset){
        // null block on core audio thread
        //NSLog(@"triggering UI cue (core audio thread)");
        coreAudioBlock();
    }
                                        atTime:timestamp
                                 timingContext:AEAudioTimingContextOutput
                                    identifier:@"my event"
                       mainThreadResponseBlock:^(const AudioTimeStamp *time, UInt32 offset) {
                           // We are now on the main thread at *time*, which is *offset* frames
                           // before the time we scheduled, *timestamp*.
                           cueBlock();
                       }
     ];
}

// convenience call when the coreAudio block is null (most cases)
- (void)scheduleForExecutionAtTime:(uint64_t)timestamp
      withMainThreadBlock:(void (^)())cueBlock
{
    [self scheduleForExecutionAtTime:timestamp withMainThreadBlock:cueBlock withCoreAudioThreadBlock:^(){}];
}

- (NSSet *)cuesCurrentlyRunning {
    NSSet *cueSubset = [_cues objectsPassingTest:^BOOL(id<CHCueable> obj, BOOL *stop) {
        if(obj.isRunning){
            return YES;
        } else {
            return NO;
        }
    }];
    return cueSubset;
}

@end
