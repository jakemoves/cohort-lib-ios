//
//  ViewController.m
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    AEAudioController *audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription] inputEnabled:NO];
//    audioController.preferredBufferDuration = 0.005;
//    audioController.useMeasurementMode = YES;
//    [audioController start:NULL];
//
//    CHSoundAsset *asset = [[CHSoundAsset alloc] initWithAssetId:@"clicktrack" andFilename:@"clicktrack.m4a"];
//    
//    CHSoundCue *cue = [[CHSoundCue alloc] initWithAudioController:audioController andAsset:asset withCompletionBlock:^void{}];
//    [cue.audio play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
