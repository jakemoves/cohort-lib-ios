//
//  CHSoundCue.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-11.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSoundCue.h"

@implementation CHSoundCue

@synthesize targetGroup = _targetGroup;
@synthesize mediaType = _mediaType;
@synthesize duration = _duration;
@synthesize isLoaded = _isLoaded;

- (id)initWithSession: (CHSession *)session andAsset:(CHSoundAsset *)asset {
    if (self = [super init]) {
        // custom initialization
        
        _session = session;
        _asset = asset;
        _mediaType = CHMediaTypeSound;
        _isLoaded = false;
        
        _audio = [[AEAudioUnitFilePlayer alloc] initAudioUnitFilePlayerWithAudioController:_session.audioController error:nil];
        
        _audio.loop = false;
        _audio.volume = 1.0;
    }
    return self;
}

- (void)load:(void (^)())callback {
    [_audio loadAudioFileFromUrl:_asset.sourceFile];
    [_session.audioController addChannels:[NSArray arrayWithObject:_audio]];
    _duration = _audio.duration;
    _isLoaded = true;
    if(callback){
        callback();
    }
}

- (void)fire:(void (^)())callback withCompletionHandler:(void (^)())completionHandler {
    _audio.completionBlock = completionHandler;
    [self play:callback];
}

- (void)play:(void (^)())callback {
    [_audio play];
    if(callback){
        callback();
    }
}

// not tested yet!
- (void)pause:(void (^)())callback {
    [_audio stop];
    if(callback){
        callback();
    }
}

@end
