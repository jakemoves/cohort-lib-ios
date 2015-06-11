//
//  CHCueTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CHCue.h"

@interface CHCueTest : XCTestCase

@end

@implementation CHCueTest

- (void)testCueExists {
    CHCue *cue = [[CHCue alloc] init];
    XCTAssertNotNil(cue);
}

- (void)testCueWithTargetGroup {
    CHCue *cue = [[CHCue alloc] init];
    cue.targetGroup = @"blue";
    XCTAssert([cue.targetGroup isEqualToString:@"blue"]);
}

- (void)testCueWithMediaType {
    CHCue *cue = [[CHCue alloc] init];
    cue.mediaType = CHMediaTypeSound;
    XCTAssert(cue.mediaType == CHMediaTypeSound);
}

- (void)testCueWithDuration {
    CHCue *cue = [[CHCue alloc] init];
    cue.duration = 5.0;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
