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
    
    
    CHTrigger *trigger = [[CHTrigger alloc] initWithValue:0.0 andType:CHTriggeredAtTime error:nil];
        
    CHSoundAsset *iPhoneScore1BlueAsset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-blue" andFilename:@"iphonescore1-blue.m4a" error:nil];
    CHSoundAsset *iPhoneScore1RedAsset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-red" andFilename:@"iphonescore1-red.m4a" error:nil];
    CHSoundAsset *iPhoneScore1BlueSoloAsset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-bluesolo" andFilename:@"iphonescore1-blue-solo.m4a" error:nil];
    CHSoundAsset *iPhoneScore1RedSoloAsset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-redsolo" andFilename:@"iphonescore1-red-solo.m4a" error:nil];

    CHSoundCue *blueCue = [[CHSoundCue alloc] initWithSession:_session andAsset:iPhoneScore1BlueAsset withTags:[NSSet setWithObjects:@"blue", nil] withTrigger:trigger];
    CHSoundCue *redCue = [[CHSoundCue alloc] initWithSession:_session andAsset:iPhoneScore1RedAsset withTags:[NSSet setWithObjects:@"red", nil] withTrigger:trigger];
    CHSoundCue *blueSoloCue = [[CHSoundCue alloc] initWithSession:_session andAsset:iPhoneScore1BlueSoloAsset withTags:[NSSet setWithObjects:@"bluesolo", nil] withTrigger:trigger];
    CHSoundCue *redSoloCue = [[CHSoundCue alloc] initWithSession:_session andAsset:iPhoneScore1RedSoloAsset withTags:[NSSet setWithObjects:@"redsolo", nil] withTrigger:trigger];
    
    _iPhoneScore1 = [[CHEpisode alloc] initWithId:@"iphone-score1" withSession:_session andCues:[NSSet setWithObjects:blueCue, redCue, blueSoloCue, redSoloCue, nil] error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPlayBlueIPhoneScore1:(id)sender {
    NSLog(@"btn hit");
    NSError *error = nil;
    
    if(!_iPhoneScore1.hasStarted){
        _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"blue", nil] error:&error];
        
        if(!error){
            [_iPhoneScore1 loadForParticipant:_participant withCallback:^(void){ NSLog(@"loaded episode"); } error:&error];
        } else {
            NSLog(@"%@", error);
        }
        
        if(!error){
            [_iPhoneScore1 start];
        } else {
            NSLog(@"%@", error);
        }
    }
}

- (IBAction)btnPlayRedIPhoneScore1:(id)sender {NSLog(@"btn hit");
    NSLog(@"btn hit");
    NSError *error = nil;
    
    if(!_iPhoneScore1.hasStarted){
        _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"red", nil] error:&error];
        
        if(!error){
            [_iPhoneScore1 loadForParticipant:_participant withCallback:^(void){ NSLog(@"loaded episode"); } error:&error];
        } else {
            NSLog(@"%@", error);
        }
        
        if(!error){
            [_iPhoneScore1 start];
        } else {
            NSLog(@"%@", error);
        }
    }
}

- (IBAction)btnPlayBlueIPhoneScore1WithSolo:(id)sender {
    NSLog(@"btn hit");
    NSError *error = nil;
    
    if(!_iPhoneScore1.hasStarted){
        _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"bluesolo", nil] error:&error];
        
        if(!error){
            [_iPhoneScore1 loadForParticipant:_participant withCallback:^(void){ NSLog(@"loaded episode"); } error:&error];
        } else {
            NSLog(@"%@", error);
        }
        
        if(!error){
            [_iPhoneScore1 start];
        } else {
            NSLog(@"%@", error);
        }
    }
}

- (IBAction)btnPlayRedIPhoneScore1WithSolo:(id)sender {
    NSLog(@"btn hit");
    NSError *error = nil;
    
    if(!_iPhoneScore1.hasStarted){
        _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"redsolo", nil] error:&error];
        
        if(!error){
            [_iPhoneScore1 loadForParticipant:_participant withCallback:^(void){ NSLog(@"loaded episode"); } error:&error];
        } else {
            NSLog(@"%@", error);
        }
        
        if(!error){
            [_iPhoneScore1 start];
        } else {
            NSLog(@"%@", error);
        }
    }
}
@end
