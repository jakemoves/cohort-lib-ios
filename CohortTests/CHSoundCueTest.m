//
//  CHSoundCueTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-10.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CHSoundCue.h"

@interface CHSoundCueTest : XCTestCase

@end

@implementation CHSoundCueTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItInitsWithAValidMediaAsset {
    AEAudioController *audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription] inputEnabled:NO];
    audioController.preferredBufferDuration = 0.005;
    audioController.useMeasurementMode = YES;
    [audioController start:NULL];
    
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithAudioController:audioController andAsset:asset withCompletionBlock:^void{}];
    XCTAssertNotNil(cue.audio);
    XCTAssertEqual(cue.audio.volume, 1.0);
}

- (void)testThatItPlaysTheSound {
    AEAudioController *audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription] inputEnabled:NO];
    audioController.preferredBufferDuration = 0.005;
    audioController.useMeasurementMode = YES;
    [audioController start:NULL];
    
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithAudioController:audioController andAsset:asset withCompletionBlock:^void{}];
    [cue play];
    XCTAssertEqual(cue.audio.playing, true);
}

- (void)testThatItFinishesPlayingTheSound {
    XCTestExpectation *expectation = [self expectationWithDescription:@"sound cue no longer playing"];
    AEAudioController *audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription] inputEnabled:NO];
    audioController.preferredBufferDuration = 0.005;
    audioController.useMeasurementMode = YES;
    [audioController start:NULL];
    
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithAudioController:audioController andAsset:asset withCompletionBlock:^void{ NSLog(@"sound cue finished playing"); }];
    [cue play];
    
    NSTimeInterval timeTilEndOfCue = cue.audio.duration + 10.0;
    
    [self waitForExpectationsWithTimeout:timeTilEndOfCue handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
        NSLog(@"Checking expectation...");
        if(cue.audio.playing == false){
            [audioController removeChannels:audioController.channels];
            [audioController stop];
            [expectation fulfill];
        }
    }];
}

- (void)DISABLED_testThatItFiresTheCompletionCallback {
    XCTestExpectation *expectation = [self expectationWithDescription:@"sound cue completion callback fired"];
    AEAudioController *audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription] inputEnabled:NO];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithAudioController:audioController
                                                         andAsset:asset withCompletionBlock:^void{
                                                             NSLog(@"sound cue finished playing");
    }];
    [cue play];
    
    NSTimeInterval timeTilEndOfCue = cue.audio.duration + 10.0;
    
    [self waitForExpectationsWithTimeout:timeTilEndOfCue handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}
@end
