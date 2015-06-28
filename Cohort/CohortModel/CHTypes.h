//
//  CHTypes.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-27.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

typedef NS_ENUM(NSInteger, CHMediaType) {
    CHMediaTypeUnknown,
    CHMediaTypeSound,
    CHMediaTypeEpisode
};

typedef NSString * CHMediaTypeString;
#define CHMediaTypeStringUnknown    @""
#define CHMediaTypeStringSound      @"sound"
#define CHMediaTypeStringEpisode    @"episode"

typedef NS_ENUM(NSInteger, CHTriggerType) {
    CHTriggerTypeUnknown,
    CHTriggeredAtTime,
    CHTriggeredByServerSentEvent,
    CHTriggeredByUserInteraction
};

typedef void (^CHVoidBlock)();
