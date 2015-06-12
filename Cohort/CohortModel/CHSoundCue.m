//
//  CHSoundCue.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-11.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSoundCue.h"

@implementation CHSoundCue

- (id)initWithAudioController: (AEAudioController *)audioController andAsset:(CHSoundAsset *)asset withCompletionBlock:(void (^)()) completionBlock {
    if (self = [super init]) {
        // custom initialization
        
        _audio = [[AEAudioUnitFilePlayer alloc] init];
        
        _audio = [AEAudioUnitFilePlayer audioUnitFilePlayerWithController:audioController error:nil];
        _audio.playing = false;
        _audio.volume = 1.0;
        _audio.completionBlock = completionBlock;
        [audioController addChannels:[NSArray arrayWithObject:_audio]];
        _audio.url = asset.sourceFile;
    }
    return self;
}

- (void) play {
    if(_audio.playing == false){
        _audio.playing = true;
    }
}

- (void) pause {
    if(_audio.playing == true){
        _audio.playing = false;
    }
}

@end
