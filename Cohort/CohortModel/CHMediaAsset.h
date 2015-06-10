//
//  CHMediaAsset.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-09.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CHMediaType) {
    CHMediaTypeSound
};

@interface CHMediaAsset : NSObject

@property (strong, nonatomic) NSURL *sourceFile;

@end
