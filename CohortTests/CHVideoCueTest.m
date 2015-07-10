//
//  CHVideoCueTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-07-10.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CHVideoCue.h"

@interface CHVideoCueTest : XCTestCase

@end

@implementation CHVideoCueTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItInitsWithAValidSoundAsset {
    NSError *error = nil;
    NSError *secondaryError = nil;
 
    CHSession *session = [[CHSession alloc] init];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    CHVoidBlock voidBlock;
    CHVideoAsset *asset = [[CHVideoAsset alloc] initWithAssetId:@"testpattern" inBundle:bundle andFilename:@"testpattern-540.m4v" error:&secondaryError];
    CHVideoCue *cue = [[CHVideoCue alloc] initWithSession:session andAsset:asset withTriggers:nil withTags:nil error:&error withCompletionBlock:voidBlock];
    
    XCTAssertNotNil(asset);
    XCTAssert(error.code == 4);
}

- (void)testThatItFiresTheCompletionCallback {
}

- (void)testThatItThrowsErrorWithNilSession {
}

- (void)testThatItThrowsErrorWithNilAsset {
}

@end
