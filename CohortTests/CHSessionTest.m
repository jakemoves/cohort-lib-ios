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
    XCTAssertNotNil(session.sseClient, @"Session sseClient is nil");
}

- (void)testThatItConnectsToSSEServer {
    // server must be running to pass
    CHSession *session = [[CHSession alloc] init];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Connected to SSE server"];
    //http://stackoverflow.com/questions/27555499/xctestexpectation-how-to-avoid-calling-the-fulfill-method-after-the-wait-contex
    
    [session listenForCuesWithURL:[[NSURL alloc] initWithString:@"http://jqrs.org/test/listen"]
            withCompletionHandler:^(BOOL success, NSError *error) {
        if(success){
            [expectation fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testThatItReportsBadHostName {
    CHSession *session = [[CHSession alloc] init];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Could not connect to SSE server"];
    
    [session listenForCuesWithURL:[[NSURL alloc] initWithString:@"http://totallyinvalidURLthatdoesntexist.cz"]
            withCompletionHandler:^(BOOL success, NSError *error) {
                if(!success){
                    if((error.code) == -1003){
                        [expectation fulfill];
                    }
                }
            }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)DISABLEDtestThatItReportsWhenServerNotRunning {
    // server should not be running to pass
    CHSession *session = [[CHSession alloc] init];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Could not connect to SSE server"];
    
    [session listenForCuesWithURL:[[NSURL alloc] initWithString:@"http://jqrs.org/test/"]
            withCompletionHandler:^(BOOL success, NSError *error) {
                if(!success){
                    NSLog(@"SSE: error %@", error);
                    if((error.code) == 2){
                        [expectation fulfill];
                    }
                }
            }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
