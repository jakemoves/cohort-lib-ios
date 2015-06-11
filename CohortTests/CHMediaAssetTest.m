//
//  CHMediaAssetTest.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CHMediaAsset.h"

@interface CHMediaAssetTest : XCTestCase

@end

@implementation CHMediaAssetTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateMediaAsset {
    CHMediaAsset *asset = [[CHMediaAsset alloc] init];
    XCTAssertNotNil(asset);
}

@end
