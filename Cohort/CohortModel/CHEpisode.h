//
//  CHEpisode.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-15.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHSession.h"
#import "CHCueable.h"
#import "CHParticipant.h"
#import "CHTrigger.h"

@interface CHEpisode : NSObject <CHCueable>

@property (strong, nonatomic) NSString *episodeId;
@property (readonly, strong, nonatomic) CHSession *session;
@property (strong, nonatomic) NSSet *cues;
@property (readonly) uint64_t startTime;
@property (strong, nonatomic) CHParticipant *participant;

- (id)initWithId:(NSString *)episodeId withSession:(CHSession *)session andCues:(NSSet *)cues withTriggers:(NSArray *)triggers withCompletionBlock:(CHVoidBlock)completionBlock error:(NSError **)error;
- (NSSet *)cuesOfMediaType: (CHMediaType)mediaType;
- (NSSet *)cuesCurrentlyRunning;
- (void) loadForParticipant:(CHParticipant *)participant withCallback:(void (^)())callback error:(NSError **)error;

@end
