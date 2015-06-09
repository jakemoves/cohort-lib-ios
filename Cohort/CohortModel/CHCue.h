//
//  CHCue.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CHMediaType) {
    CHMediaTypeSound
};

@interface CHCue : NSObject

@property (nonatomic) NSString *targetGroup;
@property (nonatomic) CHMediaType *mediaType;
@property (nonatomic, copy) void (^action)();
@property (nonatomic) double duration;

- (void) fire;

@end
