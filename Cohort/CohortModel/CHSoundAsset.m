//
//  CHSoundAsset.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSoundAsset.h"

@implementation CHSoundAsset

- (id)init {
    if (self = [super init]) {
        // custom initialization
        
        _mediaType = CHMediaTypeSound;
    }
    return self;
}

@end
