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

- (void)testThatItInitsWithNoCues {
    CHSession *session = [[CHSession alloc] init];
    CHEpisode *episode = [[CHEpisode alloc] initWithSession:(CHSession *)session andCues:nil];
    XCTAssertNotNil(episode);
    XCTAssertEqual(session, episode.session);
}

-(void)testThatItInitsWithValidCues {
    
}

-(void)testThatItRejectsCueArrayWithNonCueObjects {
    
}

@end
