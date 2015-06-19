//
//  CHCueing.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cohort.h"

@protocol CHCueing <NSObject>

@property (strong, nonatomic) NSString *targetGroup;
@property (readonly, nonatomic) CHMediaType mediaType;
@property (readonly, nonatomic) double duration;
@property (nonatomic) BOOL isLoaded;

-(void) load:(void (^)())callback;
-(void) fire:(void (^)())callback withCompletionHandler:(void (^)())completionHandler;
-(void) play:(void (^)())callback;
-(void) pause:(void (^)())callback;

@end