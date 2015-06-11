//
//  CHSoundAsset.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "CHSoundAsset.h"

@implementation CHSoundAsset

- (id)initWithAssetId:(NSString *)assetId andFilename:(NSString *)filename{
    if (self = [super init]) {
        // custom initialization
        
        NSError *error = nil;
        _mediaType = CHMediaTypeSound;
        _assetId = assetId;
        
        NSString *assetPath = [[NSBundle mainBundle] resourcePath];
        NSString *filepath = [assetPath stringByAppendingPathComponent:filename];
        if([[NSFileManager defaultManager] fileExistsAtPath: filepath] == NO)
        {
            error = [NSError errorWithDomain:[NSString stringWithFormat:@"File %@ does not exist at path %@", filename, filepath] code:408 userInfo:nil];
        } else {
            _sourceFile = [[NSURL alloc] initWithString:filepath];
            
            // ~save basic info about asset? (i.e. duration?)
        }
        
        // flag errors
        if(error){
            NSDictionary *errorPackage = [[NSDictionary alloc] initWithObjectsAndKeys:error,@"error", nil];
            
            // ncbt (not covered by test)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"error" object:self userInfo:errorPackage];
            
            return nil;
        } else {
            return self;
        }
    } else {
        return self;
    }
}

@end
