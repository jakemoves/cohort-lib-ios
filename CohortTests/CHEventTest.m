//
//  CHEventTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CHEvent.h"

@interface CHEventTest : XCTestCase

@end

@implementation CHEventTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItInits {
    CHEvent *event = [[CHEvent alloc] init];
    XCTAssertNotNil(event);
}

@end
