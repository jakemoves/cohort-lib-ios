//
//  CHEvent.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHEvent.h"

@implementation CHEvent

-(id)initWithAssets:(NSDictionary *)assets andEpisodes:(NSDictionary *)episodes error:(NSError **)error {
    if (self = [super init]) {
        // custom initialization
        
        // enumerate assets, validate & create
        _assets = nil;
        
        if(assets){
            for(id<NSObject, CHMediaAsset> asset in assets){
                if([asset conformsToProtocol:@protocol(CHMediaAsset)]){
                    if(_assets){
                        [_assets setObject:asset forKey:asset.assetId];
                    } else {
                        _assets = [[NSMutableDictionary alloc] initWithObjectsAndKeys:asset, asset.assetId, nil];
                    }
                } else {
                    NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not add asset to event because the asset is not valid"};
                    *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Event.ErrorDomain" code:2 userInfo:tempDic];
                }
            }
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create event because assets is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Event.ErrorDomain" code:1 userInfo:tempDic];
        }
        
        // enumerate episodes, validate & create
        _episodes = nil;
        
        if(episodes){
            for(CHEpisode *episode in episodes){
                if(_episodes){
                    [_episodes setObject:episode forKey:episode.episodeId];
                } else {
                    _episodes = [[NSMutableDictionary alloc] initWithObjectsAndKeys:episode, episode.episodeId, nil];
                }
            }
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create event because episodes is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Event.ErrorDomain" code:3 userInfo:tempDic];
        }

        if(!assets || !episodes){
            self = nil;
        }
    }

    return self;
}

-(void)addParticipant:(CHParticipant *)participant {
    _participant = participant;
}

@end
