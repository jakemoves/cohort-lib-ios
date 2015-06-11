//
//  CHSoundAsset.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHMediaAsset.h"

@interface CHSoundAsset : CHMediaAsset

@property (readonly, nonatomic) CHMediaType mediaType;
@property (readonly, nonatomic) NSString *assetId;
@property (readonly, nonatomic) NSURL *sourceFile;

-(id)initWithAssetId:(NSString *)assetId andFilename:(NSString *)filename;

//refactor -- maybe id should live in cuelist or showbook once we have them

@end