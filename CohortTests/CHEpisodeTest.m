//
//  CHEpisodeTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-14.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CHEpisode.h"
#import "CHSoundCue.h"

@interface CHEpisodeTest : XCTestCase

@end

@implementation CHEpisodeTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItDoesNotInitWithNilCueset {
    NSError *error = nil;
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    CHSession *session = [[CHSession alloc] init];
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:nil withParticipant:participant error:&error];
    if(error){
        NSLog(@"%@", error);
    }
    XCTAssertNil(episode);
    XCTAssertTrue(error.code == 1);
}

- (void)testThatItDoesNotInitWithSetOfZeroCues {
    NSError *error = nil;
    CHSession *session = [[CHSession alloc] init];
    NSSet *tempCueset = [[NSSet alloc] init];
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"%@", error);
    }
    XCTAssertNil(episode);
    XCTAssertTrue(error.code == 2);
}

- (void)testThatItDoesNotInitWithNilEpisodeId {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:nil withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:nil withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNil(episode);
    XCTAssertTrue(error.code == 4);
}

- (void)testThatItDoesNotInitWithEmptyEpisodeId {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:nil withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNil(episode);
    XCTAssertTrue(error.code == 5);
}

- (void)testThatItDoesNotInitWithNilSession {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    CHSession *session = nil;
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:nil withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNil(episode);
    XCTAssertTrue(error.code == 6);
}

-(void)testThatItInitsAndLoadsWithOneValidCue {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    NSSet *tags = [NSSet setWithObject:@"all"];
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertNotNil(episode.cues);
    XCTAssertTrue(episode.cues.count == 1);
    
    [episode load:nil];
    
    for(id<NSObject, CHCueing> cue in episode.cues){
        if([cue conformsToProtocol:@protocol(CHCueing)]){
            XCTAssertTrue(cue.isLoaded);
        }
    }
    XCTAssertTrue(episode.isLoaded);
}

-(void)testThatItInitsAndLoadsWithSeveralValidCues {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    NSSet *tags = [NSSet setWithObject:@"all"];
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue1 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    CHSoundCue *cue2 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    CHSoundCue *cue3 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue1, cue2, cue3, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertNotNil(episode.cues);
    XCTAssertTrue(episode.cues.count == 3);
    
    [episode load:nil];
    
    for(id<NSObject, CHCueing> cue in episode.cues){
        if([cue conformsToProtocol:@protocol(CHCueing)]){
            XCTAssertTrue(cue.isLoaded);
        }
    }
    XCTAssertTrue(episode.isLoaded);
}

-(void)testThatItReturnsErrorOnInitWithCueArrayContainingNonCueObjects {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    NSSet *tags = [NSSet setWithObject:@"all"];
    
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error: nil];
    CHSoundCue *cue1 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    NSObject *cue2 = [[NSObject alloc] init];
    CHSoundCue *cue3 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue1, cue2, cue3, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertTrue(error.code == 3);
    
}

-(void)testThatItReturnsCuesOfMediaType {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    NSSet *tags = [NSSet setWithObject:@"all"];
    
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue1 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    CHSoundCue *cue2 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    CHSoundCue *cue3 = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:nil];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue1, cue2, cue3, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    
    NSSet *soundCues = [episode cuesOfMediaType:CHMediaTypeSound];
    XCTAssertTrue([soundCues isEqualToSet:tempCueset]);
}

-(void)testThatItStartsWithOneTimedCueOfTimeZeroWithMatchingTag {
    __weak XCTestExpectation *expectation = [self expectationForNotification:@"sound cue finished playing" object:nil handler:nil];
    //http://stackoverflow.com/questions/27555499/xctestexpectation-how-to-avoid-calling-the-fulfill-method-after-the-wait-contex

    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    NSSet *tags = [NSSet setWithObject:@"all"];
    
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:[[CHTrigger alloc] initWithValue:0.0 andType:CHTriggeredAtTime error:nil]];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertNotNil(episode.cues);
    XCTAssertTrue(episode.cues.count == 1);
    
    [episode load:nil];
    [episode start];
    XCTAssertTrue(episode.hasStarted);
    XCTAssertTrue(episode.currentlyPlayingCues.count == 1);
    
    NSTimeInterval timeTilEndOfCue = cue.audio.duration + 3.0;
    
    [self waitForExpectationsWithTimeout:timeTilEndOfCue handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void)testThatItDoesNotPlayTimedCueOfTimeZeroWithNoMatchingTag {
    CHParticipant *participant = [[CHParticipant alloc] initWithTags:nil error:nil];
    NSSet *tags = [NSSet setWithObject:@"blue"];
    
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:nil];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset withTags:tags withTrigger:[[CHTrigger alloc] initWithValue:0.0 andType:CHTriggeredAtTime error:nil]];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithId:@"testEpisode" withSession:(CHSession *)session andCues:tempCueset withParticipant:participant error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertNotNil(episode.cues);
    XCTAssertTrue(episode.cues.count == 1);
    
    [episode load:nil];
    [episode start];
    XCTAssertTrue(episode.hasStarted);
    XCTAssertTrue(episode.currentlyPlayingCues.count == 0);
}

@end
