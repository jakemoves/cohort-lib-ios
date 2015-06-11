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
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
    XCTAssertNotNil(asset);
    XCTAssertTrue(asset.mediaType == CHMediaTypeSound);
    XCTAssertTrue([asset.assetId isEqualToString:@"clicktrack"]);
}

- (void)testThatItFailsGracefully {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFileLoadError:) name:@"error" object:nil];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrak.m4a"];
    XCTAssertNil(asset);
}


- (void)DISABLEDtestThatItAlertsOnBadFilenames {
    _tempExpectation = [self expectationWithDescription:@"file load error flagged"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFileLoadError:) name:@"error" object:nil];
    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrak.m4a"];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error){
            
        }
    }];
}
- (void)onFileLoadError:(NSNotification *)notification {
    NSDictionary *errorPackage = [notification userInfo];
    XCTAssertNotNil([errorPackage objectForKey:@"error"]);
    [_tempExpectation fulfill];
}

@end
