//
//  CHEpisode.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-15.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHEpisode.h"

@implementation CHEpisode

- (id)initWithSession: (CHSession *)session andCues:(NSDictionary *)cues error:(NSError **)error {
    NSError *localError = nil;
    if (self = [super init]) {
        // custom initialization
        
        _session = session;
        NSMutableArray *tempCues = [[NSMutableArray alloc] init];
        
        for(NSObject *cue in cues){
            if([cue conformsToProtocol:@protocol(CHCueing)]){
                [tempCues addObject:cue];
            } else {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedDescriptionKey, @"Malformed cue: %@", cue, nil];
                if(error){
                    localError = [NSError errorWithDomain:@"Cohort" code:1 userInfo:userInfo];
                    *error = localError;
                }
            }
        }
        _cues = [NSSet setWithArray:tempCues];
    }
    // if error, pass it and return nil, else return self
    if(!localError) {
        return self;
    } else {
        return nil;
    }
}

-(void) load:(void (^)())callback {
    // enumerate _cues, call load() on each
    for(id<CHCueing> cue in _cues){
        [cue load:nil];
    }
}

- (NSSet *)cuesOfType: (CHMediaType)mediaType {
    NSSet *cueSubset = [_cues objectsPassingTest:^BOOL(id<CHCueing> obj, BOOL *stop) {
        CHMediaType cueType = (CHMediaType)obj.mediaType;
        if(cueType == mediaType){
            return YES;
        } else {
            return NO;
        }
    }];
    return cueSubset;
}

@end
