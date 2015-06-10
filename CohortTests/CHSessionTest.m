//
//  CHSessionTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-10.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CHSession.h"

@interface CHSessionTest : XCTestCase

@end

@implementation CHSessionTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateSession {
    CHSession *session = [[CHSession alloc] init];
    XCTAssertNotNil(session, @"Session is nil");
    XCTAssertNotNil(session.audioController, @"Session audioController is nil");
}

@end
