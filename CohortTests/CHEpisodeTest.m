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

- (void)testThatItInitsWithNilCues {
    NSError *error = nil;
    CHSession *session = [[CHSession alloc] init];
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:nil error:&error];
    if(error){
        NSLog(@"%@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertFalse(episode.isLoaded);
}

- (void)testThatItInitsWithSetOfZeroCues {
    NSError *error = nil;
    CHSession *session = [[CHSession alloc] init];
    NSSet *tempCueset = [[NSSet alloc] init];
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:tempCueset error:&error];
    if(error){
        NSLog(@"%@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertFalse(episode.isLoaded);
}

-(void)testThatItInitsAndLoadsWithOneValidCue {
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:tempCueset error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertNotNil(episode.cues);
    XCTAssertTrue(episode.cues.count == 1);
    
    //NSSet *soundCues = [episode cuesOfType:CHMediaTypeSound];
    [episode load:nil];
    
    for(NSObject<CHCueing> *cue in episode.cues){
        if([cue conformsToProtocol:@protocol(CHCueing)]){
            XCTAssertTrue(cue.isLoaded);
        }
    }
    XCTAssertTrue(episode.isLoaded);
}

-(void)testThatItInitsAndLoadsWithSeveralValidCues {
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue1 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    CHSoundCue *cue2 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    CHSoundCue *cue3 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue1, cue2, cue3, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:tempCueset error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
    XCTAssertNotNil(episode.cues);
    XCTAssertTrue(episode.cues.count == 3);
    
    [episode load:nil];
    
    for(NSObject<CHCueing> *cue in episode.cues){
        if([cue conformsToProtocol:@protocol(CHCueing)]){
            XCTAssertTrue(cue.isLoaded);
        }
    }
    XCTAssertTrue(episode.isLoaded);
}

-(void)testThatItRejectsCueArrayWithNonCueObjects {
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue1 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    NSObject *cue2 = [[NSObject alloc] init];
    CHSoundCue *cue3 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue1, cue2, cue3, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:tempCueset error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    XCTAssertNil(episode);
}

-(void)testThatItReturnsCuesOfType {
    CHSession *session = [[CHSession alloc] init];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    CHSoundCue *cue1 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    CHSoundCue *cue2 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    CHSoundCue *cue3 = [[CHSoundCue alloc] initWithSession:session andAsset:asset];
    
    NSSet *tempCueset = [NSSet setWithObjects:cue1, cue2, cue3, nil];
    NSError *error = nil;
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:tempCueset error:&error];
    if(error){
        NSLog(@"Error: %@", error);
    }
    
    NSSet *soundCues = [episode cuesOfType:CHMediaTypeSound];
    XCTAssertTrue([soundCues isEqualToSet:tempCueset]);
}

@end
