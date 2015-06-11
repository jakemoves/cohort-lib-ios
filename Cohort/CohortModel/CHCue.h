//
//  CHCue.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHMediaAsset.h"

@interface CHCue : NSObject

@property (nonatomic) NSString *targetGroup;
@property (nonatomic) CHMediaType *mediaType;
@property (nonatomic) double duration;

- (void) fire;

@end
