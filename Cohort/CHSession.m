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
        
        // audio functionality
        _audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription]];
        _audioController.preferredBufferDuration = 0.005;
        _audioController.useMeasurementMode = YES;
        [_audioController start:NULL];
        
        
        // video functionality
        _videoController = [[MPMoviePlayerController alloc] init];
        _videoController.fullscreen = false;
        _videoController.allowsAirPlay = false;
        _videoController.controlStyle = MPMovieControlStyleNone;
        _videoController.shouldAutoplay = false;
        _view = [[UIView alloc] init];
        
        
        // scheduling / cue timing
        _scheduler = [[AEBlockScheduler alloc] initWithAudioController:_audioController];
        [_audioController addTimingReceiver:_scheduler];
        
        _sseClient = nil;
        
        
        // networking
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"internet available" object:nil];
#ifdef DEBUG
                    NSLog(@"internet available");
#endif
                    //available
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"internet not available" object:nil];
#ifdef DEBUG
                    NSLog(@"internet not available");
#endif
                    //not available
                    break;
                default:
                    break;
            }
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
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
            } else if([sseEventData objectForKey:@"data"]){
                NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSNumber alloc] initWithLongLong:[AEBlockScheduler now]], @"receivedAt", [sseEventData objectForKey:@"data"], @"data", nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:nil userInfo:userInfo];
            } else if([sseEventData objectForKey:@"instruction"]){
                NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSNumber alloc] initWithLongLong:[AEBlockScheduler now]], @"receivedAt", [sseEventData objectForKey:@"instruction"], @"instruction", [sseEventData objectForKey:@"tag"], @"tag", nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"instruction" object:nil userInfo:userInfo];
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
