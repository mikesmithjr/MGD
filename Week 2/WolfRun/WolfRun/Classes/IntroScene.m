//
//  IntroScene.m
//  WolfRun
//
//  Created by Michael Smith on 2/6/14.
//  Copyright Michael Smith 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "GameScene.h"


// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
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
    
    [[OALSimpleAudio sharedInstance]preloadBg:@"background_music.mp3"];
    
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
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Game scene button
    CCButton *playButton = [CCButton buttonWithTitle:@"Play Game" fontName:@"Chalkduster" fontSize:18.0f];
    playButton.positionType = CCPositionTypeNormalized;
    playButton.position = ccp(0.5f, 0.35f);
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    [self addChild:playButton];

	
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



// -----------------------------------------------------------------------
@end
