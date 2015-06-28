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
    
    __block NSError *sseError = nil;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _session = [appDelegate cohortSession];
    [_session listenForCuesWithURL:[NSURL URLWithString:@"http://jqrs.org/test/listen"] withCompletionHandler:^(BOOL success, NSError *error) {
        if(!success){
            sseError = error;
#ifdef DEBUG
            NSLog(@"%@", error);
#endif  
        }
    }];
    
    NSError *error = nil;
    
    CHTrigger *trigger = [[CHTrigger alloc] initWithValue:0.0 ofType:CHTriggeredAtTime forMediaType:CHMediaTypeStringSound error:&error];
    
    CHTrigger *episodeTrigger = [[CHTrigger alloc] initWithValue:1 ofType:CHTriggeredByServerSentEvent forMediaType:CHMediaTypeStringEpisode error:&error];
        
    CHSoundAsset *iPhoneScore1BlueAsset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-blue" andFilename:@"iphonescore1-blue.m4a" error:nil];
    CHSoundAsset *iPhoneScore1RedAsset = [[CHSoundAsset alloc] initWithAssetId:@"iphone1-red" andFilename:@"iphonescore1-red.m4a" error:nil];

    CHSoundCue *blueCue = [[CHSoundCue alloc] initWithSession:_session andAsset:iPhoneScore1BlueAsset withTriggers:[NSArray arrayWithObject:trigger] withTags:[NSSet setWithObject:@"blue"] withCompletionBlock:nil];
    CHSoundCue *redCue = [[CHSoundCue alloc] initWithSession:_session andAsset:iPhoneScore1RedAsset withTriggers:[NSArray arrayWithObject:trigger] withTags:[NSSet setWithObject:@"red"] withCompletionBlock:nil];
    
    _iPhoneScore1 = [[CHEpisode alloc] initWithId:@"iPhone Score 1" withSession:_session andCues:[NSSet setWithObjects:blueCue, redCue, nil] withTriggers:[NSArray arrayWithObject:episodeTrigger] withCompletionBlock:nil error:&error];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoadScoreForBlue:(id)sender {
    NSLog(@"btn hit");
    NSError *error = nil;
    
    if(!_iPhoneScore1.isRunning){
        _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"blue", nil] error:&error];
        
        if(!error){
            [_iPhoneScore1 loadForParticipant:_participant error:&error];
        } else {
            NSLog(@"%@", error);
        }
    }
}

- (IBAction)btnLoadScoreForRed:(id)sender {
    NSLog(@"btn hit");
    NSError *error = nil;
    
    if(!_iPhoneScore1.isRunning){
        _participant = [[CHParticipant alloc] initWithTags:[NSSet setWithObjects:@"all", @"red", nil] error:&error];
        
        if(!error){
            [_iPhoneScore1 loadForParticipant:_participant error:&error];
        } else {
            NSLog(@"%@", error);
        }
    }
}
@end
