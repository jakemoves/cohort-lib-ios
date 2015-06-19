//
//  CHSoundAsset.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSoundAsset.h"

@implementation CHSoundAsset

@synthesize sourceFile = _sourceFile;
@synthesize mediaType = _mediaType;
@synthesize assetId = _assetId;

- (id)initWithAssetId:(NSString *)assetId andFilename:(NSString *)filename error:(NSError **)error {
    if (self = [super init]) {
        // custom initialization
        
        _mediaType = CHMediaTypeSound;
        
        // not tested yet!
        if(assetId){
            if([assetId isEqualToString:@""]){
                NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create asset because the assetId is an empty string"};
                *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Asset.ErrorDomain" code:2 userInfo:tempDic];
            } else {
                _assetId = assetId;
            }
        } else {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: @"Could not create asset because the assetId is nil"};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Episode.ErrorDomain" code:1 userInfo:tempDic];
        }
        
        NSString *assetPath = [[NSBundle mainBundle] resourcePath];
        NSString *filepath = [assetPath stringByAppendingPathComponent:filename];
        if([[NSFileManager defaultManager] fileExistsAtPath: filepath] == NO)
        {
            NSDictionary *tempDic = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Could not create asset because file '%@' does not exist at path ' %@", filename, filepath]};
            *error = [[NSError alloc] initWithDomain:@"rocks.cohort.Asset.ErrorDomain" code:3 userInfo:tempDic];
        } else {
            _sourceFile = [[NSURL alloc] initWithString:filepath];
            
            // ~save basic info about asset? (i.e. duration?)
        }
        
        if(!_assetId || !_sourceFile){
            self = nil;
        }
    }
    
    return self;
}

@end
