//
//  GameScene.m
//  WolfRun
//
//  Created by Michael Smith on 2/6/14.
//  Copyright Michael Smith 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "GameScene.h"
#import "IntroScene.h"
#import "CCAnimation.h"


// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation GameScene
{
    CCSprite *_boySprite;
    CCSprite *_girlSprite;
    CCSprite *_wolfSprite;
    CCSprite *_rockSprite;
    CCPhysicsNode *_physicsWorld;
    CCButton *backButton;
    CCButton *startButton;
    
    CCSprite *_wolfWalkSprite;
    CCSprite *_wolfHitSprite;
    CCSprite *_wolfDieSprite;
    
    CCAction *_WolfWalk;
    CCAction *_WolfHit;
    CCAction *_WolfDie;
    
    BOOL WolfWalk;
    BOOL WolfHit;
    BOOL WolfDie;
    
    NSMutableArray *wolfWalkFrames;
    NSMutableArray *wolfHitFrames;
    NSMutableArray *wolfDieFrames;
    
    NSMutableArray * sprites;
    
    int hitCount;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (GameScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    hitCount = 0;
    
    sprites = [[NSMutableArray alloc]init];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Set Background Image
    CCSprite *background = [CCSprite spriteWithImageNamed:@"desert_BG.png"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    //Preload sound effects
    [[OALSimpleAudio sharedInstance]preloadEffect:@"jump_10.wav"];
    [[OALSimpleAudio sharedInstance]preloadEffect:@"jump_11.wav"];
    [[OALSimpleAudio sharedInstance]preloadEffect:@"saberhowl.wav"];
    
    // Adding Physics Node
    _physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    _physicsWorld.debugDraw = YES;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    // Start Game button
    startButton = [CCButton buttonWithTitle:@"Start Game" fontName:@"Chalkduster" fontSize:18.0f];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5f, 0.35f);
    [startButton setTarget:self selector:@selector(onStartClicked:)];
    [self addChild:startButton];
    
    // Add Boy sprite
    _boySprite = [CCSprite spriteWithImageNamed:@"Boy.png"];
    _boySprite.position  = ccp(self.contentSize.width/1.15,self.contentSize.height/3);
    [sprites addObject:_boySprite];
    _boySprite.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, _boySprite.contentSize} cornerRadius:0];
    _boySprite.physicsBody.collisionGroup = @"playerGroup";
    _boySprite.physicsBody.collisionType = @"playerCollision";
    
    
    // Add Wolf sprite
    _wolfSprite = [CCSprite spriteWithImageNamed:@"Wolf.png"];
    _wolfSprite.position  = ccp(self.contentSize.width/8,self.contentSize.height/2);
    [sprites addObject:_wolfSprite];
    _wolfSprite.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, _wolfSprite.contentSize} cornerRadius:0];
    _wolfSprite.physicsBody.collisionGroup = @"monsterGroup";
    _wolfSprite.physicsBody.collisionType = @"monsterCollision";
    _wolfHitSprite.physicsBody.collisionGroup = @"monsterGroup";
    _wolfHitSprite.physicsBody.collisionType = @"monsterCollision";
    
    // Add Rock sprite
    _rockSprite = [CCSprite spriteWithImageNamed:@"Rocks_1.png"];
    _rockSprite.position = ccp(self.contentSize.width/1.15,self.contentSize.height/3);
    [sprites addObject:_rockSprite];
    _rockSprite.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:_rockSprite.contentSize.width/2.0f andCenter:_rockSprite.anchorPointInPoints];
    _rockSprite.physicsBody.collisionGroup = @"playerGroup";
    _rockSprite.physicsBody.collisionType = @"rockCollision";
    
    // Create a back button
    backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Chalkduster" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.color = [CCColor redColor];
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    // Adding Animated Wolf Sprites
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"WolfWalk-hd.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"WolfHit-hd.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"WolfDie-hd.plist"];
    
    CCSpriteBatchNode *wolfWalkSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"WolfWalk-hd.png"];
    CCSpriteBatchNode *wolfHitSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"WolfHit-hd.png"];
    CCSpriteBatchNode *wolfDieSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"WolfDie-hd.png"];
    [self addChild:wolfWalkSpriteSheet];
    [self addChild:wolfHitSpriteSheet];
    [self addChild:wolfDieSpriteSheet];
    
    //CCSpriteFrame *walk = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"darksaber_walk001.png"];
   // _wolfWalkSprite = [CCSprite spriteWithSpriteFrame:walk];
   // [self addChild:_wolfWalkSprite];
    CCSpriteFrame *hit = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"darksaber_hit001.png"];
    _wolfHitSprite = [CCSprite spriteWithSpriteFrame:hit];
    _wolfHitSprite.position  = ccp(self.contentSize.width/8,self.contentSize.height/3);
    CCSpriteFrame *die = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"darksaber_death001.png"];
    _wolfDieSprite = [CCSprite spriteWithSpriteFrame:die];
    _wolfDieSprite.position  = ccp(self.contentSize.width/8,self.contentSize.height/3);
    
    
    wolfWalkFrames = [NSMutableArray array];
    for (int i=1; i<=39; i++) {
        [wolfWalkFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"darksaber_walk00%d.png", i]]];
    }
    wolfHitFrames = [NSMutableArray array];
    for (int i=1; i<=26; i++) {
        [wolfHitFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"darksaber_hit00%d.png", i]]];
    }
    wolfDieFrames = [NSMutableArray array];
    for (int i=1; i<=101; i++) {
        [wolfDieFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"darksaber_death00%d.png", i]]];
    }
    
    
    
    

    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Pr frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
 
    CGPoint location = [touch locationInNode:self];
    CGRect _boySpriteRect = [_boySprite boundingBox];
    CGRect _wolfSpriteRect = [_wolfSprite boundingBox];
    
    // particularSprite touched
    if(CGRectContainsPoint(_boySpriteRect, location)) {
        
        [[OALSimpleAudio sharedInstance] playEffect:@"jump_10.wav"];
        CCActionFlipX *boyFlip = [CCActionFlipX actionWithFlipX:TRUE];
        
        [_boySprite runAction:boyFlip];
        [_physicsWorld addChild:_rockSprite];
        CCActionRotateBy *rockSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
        [_rockSprite runAction:[CCActionRepeatForever actionWithAction:rockSpin]];
        CCActionMoveTo *rockMove = [CCActionMoveTo actionWithDuration:1.5f position:_wolfSprite.position];
        CCActionRemove *rockRemove = [CCActionRemove action];
        [_rockSprite runAction:[CCActionSequence actionWithArray:@[rockMove,rockRemove]]];
    
        
    }else if (CGRectContainsPoint(_wolfSpriteRect, location)){
        
        [[OALSimpleAudio sharedInstance] playEffect:@"saberhowl.wav"];
        CCActionJumpBy *wolfJump_Up = [CCActionJumpBy actionWithDuration:1.0f position:ccp(0, 200) height:50 jumps:1];
        CCActionJumpBy *wolfJump_Down = [CCActionJumpBy actionWithDuration:0.2f position:ccp(0, -200) height:50 jumps:1];
        [_wolfSprite runAction:[CCActionSequence actionWithArray:@[wolfJump_Up, wolfJump_Down]]];
        
    }
    
    
}

#pragma mark - Collision Detection

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster rockCollision:(CCNode *)rock
{
    if (hitCount < 3) {
        [_physicsWorld addChild:_wolfHitSprite];
        [[OALSimpleAudio sharedInstance] playEffect:@"saberhowl.wav"];
        //[self addChild:_wolfHitSprite];
        CCAnimation *wolfHitAnim = [CCAnimation animationWithSpriteFrames:wolfHitFrames delay:0.05f];
        CCActionAnimate *HitAction = [CCActionAnimate actionWithAnimation:wolfHitAnim];
        [_wolfHitSprite runAction:HitAction];
        [monster removeFromParent];
        
        hitCount++;
    }else{
        [_physicsWorld addChild:_wolfDieSprite];
        //[self addChild:_wolfDieSprite];
        CCAnimation *wolfDieAnim = [CCAnimation animationWithSpriteFrames: wolfDieFrames delay:0.05f];
        CCActionAnimate *DieAction = [CCActionAnimate actionWithAnimation:wolfDieAnim];
        [_wolfDieSprite runAction:DieAction];
        [monster removeFromParent];
    }
    
    [rock removeFromParent];
    return YES;
}
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player monsterCollision:(CCNode *)monster
{
    [monster removeFromParent];
    [[OALSimpleAudio sharedInstance] playEffect:@"saberhowl.wav"];
    
    [[OALSimpleAudio sharedInstance] stopBg];
        return YES;
}




// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onStartClicked:(id)sender
{
    
    [_physicsWorld addChild:_boySprite];
    [_physicsWorld addChild:_wolfSprite];
    
    
    
    [startButton removeFromParent];
}

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}


// -----------------------------------------------------------------------
@end