//
//  CreditsScene.h
//  WolfRun
//
//  Created by Michael Smith on 2/26/14.
//  Copyright 2014 Michael Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface CreditsScene : CCScene

// -----------------------------------------------------------------------

+ (CreditsScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end
