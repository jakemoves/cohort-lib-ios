//
//  CHSoundAssetTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CHSoundAsset.h"

@interface CHSoundAssetTest : XCTestCase

@property (nonatomic, strong) XCTestExpectation *tempExpectation;

@end

@implementation CHSoundAssetTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItGetsCreated {
    NSError *error = nil;
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a" error:&error];
    XCTAssertNotNil(asset);
    XCTAssertTrue(asset.mediaType == CHMediaTypeSound);
    XCTAssertTrue([asset.assetId isEqualToString:@"clicktrack"]);
}

- (void)testThatItFailsGracefully {
    NSError *error = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFileLoadError:) name:@"error" object:nil];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrak.m4a" error:&error];
    XCTAssertNil(asset);
}


- (void)DISABLEDtestThatItAlertsOnBadFilenames {
    NSError *error = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFileLoadError:) name:@"error" object:nil];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrak.m4a" error:&error];
}
- (void)onFileLoadError:(NSNotification *)notification {
    NSDictionary *errorPackage = [notification userInfo];
    XCTAssertNotNil([errorPackage objectForKey:@"error"]);
    [_tempExpectation fulfill];
}

@end
