//
//  CHSoundCue.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-11.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHSoundAsset.h"
#import "CHSession.h"
#import "CHCueing.h"
#import "TheAmazingAudioEngine.h"
#import "AEAudioUnitFilePlayer.h"

@interface CHSoundCue : NSObject <CHCueing>

@property (strong, nonatomic) CHSession *session;
@property (strong, nonatomic) CHSoundAsset *asset;
@property (strong, nonatomic) AEAudioUnitFilePlayer *audio;

- (id)initWithSession: (CHSession *)session andAsset:(CHSoundAsset *)asset;

@end
