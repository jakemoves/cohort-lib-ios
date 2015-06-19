//
//  CHEpisode.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-15.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHEpisode.h"

@implementation CHEpisode

- (id)initWithSession: (CHSession *)session andCues:(NSSet *)cues error:(NSError **)error {
    NSError *localError = nil;
    NSMutableArray *tempCues = [[NSMutableArray alloc] init];
    if (self = [super init]) {
        // custom initialization
        
        _session = session;
        _isLoaded = false;
        
        for(NSObject<CHCueing> *cue in cues){
            if([cue conformsToProtocol:@protocol(CHCueing)]){
                [tempCues addObject:cue];
            } else {
                NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not add cue to episode because the cue is not valid"};
                localError = [[NSError alloc] initWithDomain:@"rocks.cohort.ErrorDomain" code:1 userInfo:tempDic];
            }
        }
    }
    
    if(!localError) {
        _cues = [NSSet setWithArray:tempCues];
        return self;
    } else {
        *error = localError;
        return nil;
    }
}

-(void) load:(void (^)())callback {
    for(id<NSObject, CHCueing> cue in _cues){
        [cue load:nil];
    }
    _isLoaded = true;
    
    if(callback){
        callback();
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
