//
//  CreditsScene.m
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

// -----------------------------------------------------------------------
#pragma mark - CreditsScene
// -----------------------------------------------------------------------

@implementation CreditsScene
{
    CCButton *backButton;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (CreditsScene *)scene
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
    
    // Title
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Wolf Run" fontName:@"Chalkduster" fontSize:36.0f];
    label1.positionType = CCPositionTypeNormalized;
    label1.color = [CCColor redColor];
    label1.position = ccp(0.5f, 0.9f); // Middle of screen
    [self addChild:label1];
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Werewolf sprite by MindChamber" fontName:@"Chalkduster" fontSize:18.0f];
    label2.positionType = CCPositionTypeNormalized;
    label2.color = [CCColor blackColor];
    label2.position = ccp(0.5f, 0.75f); // Middle of screen
    [self addChild:label2];
    
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Background and Character parts Dylan Squires" fontName:@"Chalkduster" fontSize:18.0f];
    label3.positionType = CCPositionTypeNormalized;
    label3.color = [CCColor blackColor];
    label3.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label3];
    
    CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"Music by Azazel42" fontName:@"Chalkduster" fontSize:18.0f];
    label4.positionType = CCPositionTypeNormalized;
    label4.color = [CCColor blackColor];
    label4.position = ccp(0.5f, 0.25f); // Middle of screen
    [self addChild:label4];
    
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