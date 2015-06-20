//
//  CHEpisode.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-15.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHSession.h"
#import "CHCueing.h"
#import "CHParticipant.h"

@interface CHEpisode : NSObject

@property (strong, nonatomic) NSString *episodeId;
@property (readonly, strong, nonatomic) CHSession *session;
@property (strong, nonatomic) NSSet *cues;
@property (readonly, strong, nonatomic) NSMutableSet *currentlyPlayingCues;
@property (readonly, nonatomic) BOOL isLoaded;
@property (readonly, nonatomic) BOOL hasStarted;
@property (readonly) uint64_t startTime;
@property (strong, nonatomic) CHParticipant *participant;


- (id)initWithId:(NSString *)episodeId withSession:(CHSession *)session andCues:(NSSet *)cues error:(NSError **)error;
- (NSSet *)cuesOfMediaType: (CHMediaType)mediaType;
- (void) loadForParticipant:(CHParticipant *)participant withCallback:(void (^)())callback error:(NSError **)error;
- (void) start;

@end
