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
        
        _audio = [[AEAudioUnitFilePlayer alloc] initAudioUnitFilePlayerWithAudioController:audioController error:nil];
        
        _audio.loop = false;
        _audio.volume = 1.0;
        _audio.completionBlock = completionBlock;
        //set duration...
        [_audio loadAudioFileFromUrl:asset.sourceFile];
        [audioController addChannels:[NSArray arrayWithObject:_audio]];
    }
    return self;
}

- (void) play {
    //if(_audio.channelIsPlaying == false){
        [_audio play];
    //}
}

- (void) pause {
    //if(_audio.channelIsPlaying == true){
        [_audio stop];
    //}
}

@end
