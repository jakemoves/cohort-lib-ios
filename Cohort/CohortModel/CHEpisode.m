//
//  CHEpisode.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-15.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHEpisode.h"

@implementation CHEpisode

- (id)initWithId:(NSString *)episodeId withSession:(CHSession *)session andCues:(NSSet *)cues error:(NSError **)error {
    if (self = [super init]) {
        // custom initialization
        
        NSMutableArray *tempCues = nil;
        
        _isLoaded = false;
        
        // not tested yet!
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
        
        // not tested yet!
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
                for(id<NSObject, CHCueing> cue in cues){
                    if([cue conformsToProtocol:@protocol(CHCueing)]){
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
