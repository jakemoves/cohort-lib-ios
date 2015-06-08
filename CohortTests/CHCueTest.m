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
- (void)testCueWithJSON {
    CHCue *cue = [[CHCue alloc] init];
    cue.targetGroup = @"blue";
    XCTAssert([cue.targetGroup isEqualToString:@"blue"]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
