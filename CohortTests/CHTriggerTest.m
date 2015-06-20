//
//  CHTriggerTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CHTrigger.h"

@interface CHTriggerTest : XCTestCase

@end

@implementation CHTriggerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testThatItInits {
    NSError *error = nil;
    CHTrigger *trigger = [[CHTrigger alloc] initWithValue:1.0 andType:CHTriggeredAtTime error:&error];
    XCTAssertNotNil(trigger);
    XCTAssertNil(error);
    XCTAssertTrue([trigger.value floatValue] == 1.0);
    XCTAssertTrue(trigger.type == CHTriggeredAtTime);
}

-(void)testThatItDoesNotInitWithNullType {
    NSError *error = nil;
    CHTrigger *trigger = [[CHTrigger alloc] initWithValue:1.0 andType:nil error:&error];
    XCTAssertNil(trigger);
    XCTAssertNotNil(error);
    XCTAssertTrue(error.code == 1);
}

@end
