//
//  CHSession.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-10.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheAmazingAudioEngine.h"
#import "EventSource.h"

@interface CHSession : NSObject

@property (strong, nonatomic) AEAudioController *audioController;
@property (strong, nonatomic) AEBlockScheduler *cueScheduler;
@property (strong, nonatomic) EventSource *sseClient;

- (void)listenForCuesWithURL:(NSURL *)url withCompletionHandler:(void (^)(BOOL success, NSError *error))handler;

@end
