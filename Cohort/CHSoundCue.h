//
//  CHSoundCue.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-11.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheAmazingAudioEngine.h"
#import "libs/AEAudioUnitFilePlayer.h"
#import "CHCueable.h"
#import "CHSession.h"
#import "CHSoundAsset.h"
#import "CHTrigger.h"

@interface CHSoundCue : NSObject <CHCueable>

@property (strong, nonatomic) CHSession *session;
@property (strong, nonatomic) CHSoundAsset *asset;
@property (strong, nonatomic) AEAudioUnitFilePlayer *audio;

- (id)initWithSession: (CHSession *)session andAsset:(CHSoundAsset *)asset withTriggers:(NSArray *)triggers withTags:(NSSet *)tags withCompletionBlock:(CHVoidBlock)completionBlock;

@end
