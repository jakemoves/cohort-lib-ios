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
        _audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription]];
        _sseClient = [[EventSource alloc] init];
    }
    
    return self;
}

- (void)listenForCuesWithURL:(NSURL *)url
       withCompletionHandler:(void (^)(BOOL success, NSError *error))handler {
    _sseClient = [EventSource eventSourceWithURL:url];
    
    [_sseClient onOpen:^(Event *event) {
        NSLog(@"SSE: onOpen, %@", event);
        handler(true, nil);
    }];
    
    [_sseClient onError:^(Event *event) {
        NSLog(@"SSE: onError, %@", event);
        handler(false, event.error);
    }];
    
    [_sseClient addEventListener:@"message" handler:^(Event *event) {
        NSLog(@"SSE: %@, %@", event.event, event.data);
    }];
}



@end
