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
    NSError *error = nil;
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:&error];
    CHVoidBlock voidBlock;
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTriggers:nil withTags:nil withCompletionBlock:voidBlock];
    XCTAssertTrue([cue conformsToProtocol:@protocol(CHCueable)]);
    XCTAssertNotNil(cue.audio);
    XCTAssertEqual(cue.audio.volume, 1.0);
}

- (void)testThatItLoadsTheSoundCue {
    NSError *error = nil;
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:&error];
    CHVoidBlock voidBlock;
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTriggers:nil withTags:nil withCompletionBlock:voidBlock];
    [cue load];
    XCTAssertTrue(cue.isLoaded);
}

- (void)testThatItPlaysTheSoundCue {
    NSError *error = nil;
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:&error];
    CHVoidBlock voidBlock;
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTriggers:nil withTags:nil withCompletionBlock:voidBlock];
    [cue load];
    [cue fire];
    XCTAssertEqual(cue.audio.channelIsPlaying, true);
}


- (void)testThatItFiresTheCompletionCallback {
    NSError *error = nil;
    __weak XCTestExpectation *expectation = [self expectationForNotification:@"sound cue finished playing" object:nil handler:nil];
    //http://stackoverflow.com/questions/27555499/xctestexpectation-how-to-avoid-calling-the-fulfill-method-after-the-wait-contex
    
    CHSession *session = [[CHSession alloc] init];

    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:&error];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTriggers:nil withTags:nil withCompletionBlock:^void(){
        NSLog(@"sound cue finished playing");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sound cue finished playing" object:nil];
    }];
    
    [cue load];
    [cue fire];
    
    NSTimeInterval timeTilEndOfCue = cue.audio.duration + 3.0;
    
    [self waitForExpectationsWithTimeout:timeTilEndOfCue handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}
@end
