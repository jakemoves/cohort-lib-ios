//
//  CHSoundCue.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-11.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSoundCue.h"

@implementation CHSoundCue

@synthesize targetTags = _targetTags;
@synthesize mediaType = _mediaType;
@synthesize mediaTypeAsString = _mediaTypeAsString;
@synthesize triggers = _triggers;
@synthesize isLoaded = _isLoaded;
@synthesize isRunning = _isRunning;
@synthesize duration = _duration;
@synthesize completionBlock = _completionBlock;

- (id)initWithSession: (CHSession *)session andAsset:(CHSoundAsset *)asset withTriggers:(NSArray *)triggers withTags:(NSSet *)tags withCompletionBlock:(CHVoidBlock)completionBlock {
    if (self = [super init]) {
        // custom initialization
        
        // TODO add error handling as per CHEpisode
        _session = session;
        _asset = asset;
        _mediaType = CHMediaTypeSound;
        _mediaTypeAsString = CHMediaTypeStringSound;
        _isLoaded = false;
        _isRunning = false;
        _completionBlock = completionBlock;
        
        if(tags){
            _targetTags = [NSSet setWithSet:tags];
        } else {
            _targetTags = [[NSSet alloc] init];
        }
        
        if(triggers){
            _triggers = triggers;
        } else {
            _triggers = [[NSArray alloc] init];
        }
        
        _audio = [[AEAudioUnitFilePlayer alloc] initAudioUnitFilePlayerWithAudioController:_session.audioController error:nil];
        
        _audio.loop = false;
        _audio.volume = 1.0;
    }
    return self;
}

- (void)load {
    [_audio loadAudioFileFromUrl:_asset.sourceFile];
    [_session.audioController addChannels:[NSArray arrayWithObject:_audio]];
    _duration = _audio.duration;
    
    if(_triggers && _triggers.count > 0){
        for(CHTrigger *trigger in _triggers){
            // arm the trigger
            __weak id weakSelf = self;
            [trigger arm:^{
                [weakSelf fire];
            }];
        }
    } else {
        // TODO add error handling as per CHEpisode
    }
    
    _isLoaded = true;
}

- (void)fire {
    if(_completionBlock){
        _audio.completionBlock = _completionBlock;
    }
    
    [self play];
}

- (void)play {
    _isRunning = true;
    [_audio play];
}

// not tested yet!
- (void)pause {
    _isRunning = false;
    [_audio stop];
}

@end
