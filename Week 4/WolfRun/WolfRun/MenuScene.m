//
//  MenuScene.m
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
#pragma mark - MenuScene
// -----------------------------------------------------------------------

@implementation MenuScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MenuScene *)scene
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
    [[OALSimpleAudio sharedInstance] playBg:@"background_music.mp3" loop:YES];
    
    // Set Background Image
    CCSprite *background = [CCSprite spriteWithImageNamed:@"desert_BG.png"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    // Title
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Wolf Run" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.75f); // Middle of screen
    [self addChild:label];
    
    // Game scene button
    CCButton *playButton = [CCButton buttonWithTitle:@"Play Game" fontName:@"Chalkduster" fontSize:18.0f];
    playButton.positionType = CCPositionTypeNormalized;
    playButton.position = ccp(0.5f, 0.5f);
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    [self addChild:playButton];
    
    // Game Instructions button
    CCButton *instructionsButton = [CCButton buttonWithTitle:@"Instructions" fontName:@"Chalkduster" fontSize:18.0f];
    instructionsButton.positionType = CCPositionTypeNormalized;
    instructionsButton.position = ccp(0.5f, 0.40f);
    [instructionsButton setTarget:self selector:@selector(onInstructionsClicked:)];
    [self addChild:instructionsButton];
    
    // Game Credits button
    CCButton *creditsButton = [CCButton buttonWithTitle:@"Credits" fontName:@"Chalkduster" fontSize:18.0f];
    creditsButton.positionType = CCPositionTypeNormalized;
    creditsButton.position = ccp(0.5f, 0.30f);
    [creditsButton setTarget:self selector:@selector(onCreditsClicked:)];
    [self addChild:creditsButton];
	
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void)onInstructionsClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[InstructionsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void)onCreditsClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}


// -----------------------------------------------------------------------
@end