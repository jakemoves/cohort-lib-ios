//
//  CHTrigger.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cohort.h"
#import "CHCueable.h"

@interface CHTrigger : NSObject

@property (readonly, nonatomic) CHTriggerType type;
@property (readonly, nonatomic) CHMediaTypeString mediaTypeAsString;
@property (nonatomic) NSNumber *value;
@property (nonatomic, copy) CHVoidBlock fireBlock;
@property (nonatomic) BOOL isArmed;

-(id)initWithValue:(double)value ofType:(CHTriggerType)type forMediaType:(CHMediaTypeString)mediaTypeAsString error:(NSError **)error;

-(void) arm:(void (^)())fireBlock;
-(void) disarm;
-(void) removeObservers;
-(void) pull;

@end
