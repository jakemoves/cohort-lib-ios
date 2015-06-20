//
//  ViewController.h
//  Cohort
//
//  Created by Jacob Niedzwiecki on 2015-06-08.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHSoundCue.h"
#import "CHSession.h"
#import "CHParticipant.h"
#import "CHEvent.h"
#import "CHEpisode.h"

@interface ViewController : UIViewController

@property (readonly, strong, nonatomic) CHSession *session;
@property (readonly, strong, nonatomic) CHParticipant *participant;
@property (strong, nonatomic) CHEpisode *iPhoneScore1;

- (IBAction)btnPlayBlueIPhoneScore1:(id)sender;
- (IBAction)btnPlayRedIPhoneScore1:(id)sender;
- (IBAction)btnPlayBlueIPhoneScore1WithSolo:(id)sender;
- (IBAction)btnPlayRedIPhoneScore1WithSolo:(id)sender;

@end

