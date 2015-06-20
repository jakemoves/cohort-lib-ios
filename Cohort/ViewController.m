//
//  ViewController.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _session = [appDelegate cohortSession];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPlayBlueIPhoneScore1:(id)sender {
    NSLog(@"btn hit");
    NSError *error = nil;
    
    _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"blue", nil] error:&error];
    
    CHSoundAsset *asset;
    if(!error){
         asset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-blue" andFilename:@"fluxdelux-iphone-score1-blue.m4a" error:&error];
    } else {
        NSLog(@"%@", error);
    }
    
    CHTrigger *trigger;
    if(!error){
        trigger = [[CHTrigger alloc] initWithValue:0.0 andType:CHTriggeredAtTime error:&error];
    } else {
        NSLog(@"%@", error);
    }
    
    CHSoundCue *cue1 = [[CHSoundCue alloc] init];
    CHSoundCue *cue2 = [[CHSoundCue alloc] init];
    if(!error){
        cue1 = [[CHSoundCue alloc] initWithSession:_session andAsset:asset withTags:[NSSet setWithObjects:@"blue", nil] withTrigger:trigger];
        cue2 = [[CHSoundCue alloc] initWithSession:_session andAsset:asset withTags:[NSSet setWithObjects:@"red", nil] withTrigger:trigger];
    } else {
        NSLog(@"%@", error);
    }
    
    CHEpisode *episode;
    if(!error){
        episode = [[CHEpisode alloc] initWithId:@"iphone-score1" withSession:_session andCues:[NSSet setWithObjects:cue1, cue2, nil] withParticipant:_participant error:&error];
    } else {
        NSLog(@"%@", error);
    }
    
//    if(!error){
//        CHEvent *event = [[CHEvent alloc] initWithAssets:[[NSDictionary alloc] initWithObjectsAndKeys:asset, asset.assetId, nil]
//                                             andEpisodes:[[NSDictionary alloc] initWithObjectsAndKeys:episode, episode.episodeId, nil]
//                                                   error:&error];
//    } else {
//        NSLog(@"%@", error);
//    }
    
    if(!error){
        [episode load:^(void){ NSLog(@"loaded episode"); }];
        [episode start];
    } else {
        NSLog(@"%@", error);
    }
}

- (IBAction)btnPlayRedIPhoneScore1:(id)sender {NSLog(@"btn hit");
    NSError *error = nil;
    
    _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"red", nil] error:&error];
    
    CHSoundAsset *asset;
    if(!error){
        asset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-blue" andFilename:@"fluxdelux-iphone-score1-blue.m4a" error:&error];
    } else {
        NSLog(@"%@", error);
    }
    
    CHTrigger *trigger;
    if(!error){
        trigger = [[CHTrigger alloc] initWithValue:0.0 andType:CHTriggeredAtTime error:&error];
    } else {
        NSLog(@"%@", error);
    }
    
    CHSoundCue *cue1 = [[CHSoundCue alloc] init];
    CHSoundCue *cue2 = [[CHSoundCue alloc] init];
    if(!error){
        cue1 = [[CHSoundCue alloc] initWithSession:_session andAsset:asset withTags:[NSSet setWithObjects:@"blue", nil] withTrigger:trigger];
        cue2 = [[CHSoundCue alloc] initWithSession:_session andAsset:asset withTags:[NSSet setWithObjects:@"red", nil] withTrigger:trigger];
    } else {
        NSLog(@"%@", error);
    }
    
    CHEpisode *episode;
    if(!error){
        episode = [[CHEpisode alloc] initWithId:@"iphone-score1" withSession:_session andCues:[NSSet setWithObjects:cue1, cue2, nil] withParticipant:_participant error:&error];
    } else {
        NSLog(@"%@", error);
    }
    
    //    if(!error){
    //        CHEvent *event = [[CHEvent alloc] initWithAssets:[[NSDictionary alloc] initWithObjectsAndKeys:asset, asset.assetId, nil]
    //                                             andEpisodes:[[NSDictionary alloc] initWithObjectsAndKeys:episode, episode.episodeId, nil]
    //                                                   error:&error];
    //    } else {
    //        NSLog(@"%@", error);
    //    }
    
    if(!error){
        [episode load:^(void){ NSLog(@"loaded episode"); }];
        [episode start];
    } else {
        NSLog(@"%@", error);
    }

}
@end
