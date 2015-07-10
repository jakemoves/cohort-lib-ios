//
//  CHVideoCue.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-07-10.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHVideoCue.h"

@implementation CHVideoCue

@synthesize targetTags = _targetTags;
@synthesize mediaType = _mediaType;
@synthesize mediaTypeAsString = _mediaTypeAsString;
@synthesize triggers = _triggers;
@synthesize isLoaded = _isLoaded;
@synthesize isRunning = _isRunning;
@synthesize duration = _duration;
@synthesize completionBlock = _completionBlock;

- (id)initWithSession:(CHSession *)session andAsset:(CHVideoAsset *)asset withTriggers:(NSArray *)triggers withTags:(NSSet *)tags withCompletionBlock:(CHVoidBlock)completionBlock {
    
    return self;
}

- (void)load:(NSError *__autoreleasing *)error {
    
}

- (void)fire {
    
}

- (void)play {
    
}

- (void)pause {
    
}

@end
