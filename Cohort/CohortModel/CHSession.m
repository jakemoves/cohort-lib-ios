//
//  CHSession.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-10.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSession.h"

@implementation CHSession

- (id)init {
    if (self = [super init]) {
        // custom initialization
        
        // start up audio functionality
        _audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription]];
        _audioController.preferredBufferDuration = 0.005;
        _audioController.useMeasurementMode = YES;
        [_audioController start:NULL];
        
        _scheduler = [[AEBlockScheduler alloc] initWithAudioController:_audioController];
        [_audioController addTimingReceiver:_scheduler];
        
        _sseClient = [[EventSource alloc] init];
    }
    
    return self;
}

- (void)listenForCuesWithURL:(NSURL *)url
       withCompletionHandler:(void (^)(BOOL success, NSError *error))handler {
    _sseClient = [EventSource eventSourceWithURL:url];
    
    [_sseClient onOpen:^(Event *event) {
        //NSLog(@"SSE: onOpen, %@", event);
        handler(true, nil);
    }];
    
    [_sseClient onError:^(Event *event) {
        //NSLog(@"SSE: onError, %@", event);
        handler(false, event.error);
    }];
    
    [_sseClient addEventListener:@"cohortMessage" handler:^(Event *event) {
        NSLog(@"SSE: %@, %@", event.event, event.data);
        NSError *error = nil;
        
        NSDictionary *sseEventData = [NSJSONSerialization JSONObjectWithData:[event.data dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if(!error){
            if([sseEventData objectForKey:@"action"]){
                NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSNumber alloc] initWithLongLong:[AEBlockScheduler now]], @"receivedAt", nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:[sseEventData objectForKey:@"action"] object:nil userInfo:userInfo];
            }
        } else {
            // TODO add error handling
        }
    }];
}

- (void)dealloc{
    [_sseClient close];
    _scheduler = nil;
    [_audioController removeChannels:[_audioController channels]];
    _audioController = nil;
}

@end
