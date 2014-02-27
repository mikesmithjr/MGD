//
//  IntructionsScene.m
//  WolfRun
//
//  Created by Michael Smith on 2/26/14.
//  Copyright 2014 Michael Smith. All rights reserved.
//


// Import the interfaces
#import "IntroScene.h"
#import "GameScene.h"
#import "MenuScene.h"
#import "CreditsScene.h"
#import "IntructionsScene.h"

// -----------------------------------------------------------------------
#pragma mark - InstructionsScene
// -----------------------------------------------------------------------

@implementation InstructionsScene
{
    CCButton *backButton;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (InstructionsScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    //Preload Background music
    
    //[[OALSimpleAudio sharedInstance]preloadBg:@"background_music.mp3"];
    
    //Start Background Music
    //[[OALSimpleAudio sharedInstance] playBg:@"background_music.mp3" loop:YES];
    
    // Set Background Image
    CCSprite *background = [CCSprite spriteWithImageNamed:@"desert_BG.png"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    // Label 1
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Tap the player on the screen to toss rocks at the wolf." fontName:@"Chalkduster" fontSize:12.0f];
    label1.positionType = CCPositionTypeNormalized;
    label1.color = [CCColor blackColor];
    label1.position = ccp(0.5f, 0.65f);
    [self addChild:label1];
    
    // Label 2
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"After 3 hits the wolf will die and you win the game." fontName:@"Chalkduster" fontSize:12.0f];
    label2.positionType = CCPositionTypeNormalized;
    label2.color = [CCColor blackColor];
    label2.position = ccp(0.5f, 0.5f);
    [self addChild:label2];
    
    // Label 3
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"If you miss you lose the game." fontName:@"Chalkduster" fontSize:12.0f];
    label3.positionType = CCPositionTypeNormalized;
    label3.color = [CCColor blackColor];
    label3.position = ccp(0.5f, 0.35f);
    [self addChild:label3];
    
    // Create a back button
    backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Chalkduster" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.color = [CCColor redColor];
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
	  
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------


- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}


// -----------------------------------------------------------------------
@end
