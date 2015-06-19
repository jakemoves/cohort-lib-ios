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

@interface CHEpisode : NSObject

@property (readonly, strong, nonatomic) CHSession *session;
@property (strong, nonatomic) NSSet *cues;
@property (nonatomic) BOOL isLoaded;

- (id)initWithSession: (CHSession *)session andCues:(NSSet *)cues error:(NSError **)error;
- (NSSet *)cuesOfType: (CHMediaType)mediaType;
- (void) load:(void (^)())callback;

@end
