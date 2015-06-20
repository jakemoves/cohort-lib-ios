//
//  CHEvent.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHEpisode.h"
#import "CHMediaAsset.h"
#import "CHParticipant.h"

@interface CHEvent : NSObject

@property (strong, nonatomic) NSMutableDictionary *assets;
@property (strong, nonatomic) NSMutableDictionary *episodes;
@property (strong, nonatomic) CHParticipant *participant;

-(id)initWithAssets:(NSDictionary *)assets andEpisodes:(NSDictionary *)episodes error:(NSError **)error;

@end
