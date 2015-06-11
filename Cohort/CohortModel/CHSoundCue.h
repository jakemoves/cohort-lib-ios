//
//  CHSoundCue.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-11.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHCue.h"
#import "CHSoundAsset.h"
#import "TheAmazingAudioEngine.h"
#import "AEAudioUnitFilePlayer.h"

@interface CHSoundCue : CHCue

@property (strong, nonatomic) AEAudioUnitFilePlayer *audio;

- (id)initWithAudioController: (AEAudioController *)audioController andAsset:(CHSoundAsset *)asset withCompletionBlock:(void (^)())completionBlock;
- (void) play;
- (void) pause;

@end
