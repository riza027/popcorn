//
//  IntroLayer.m
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "tutorialScene.h"
#import "recordsPage.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

CCSprite *bg;
CCSprite *door;
CCMenu *menu;
CCMenu *menu2;
CCSprite *signage;
CCMenuItemImage *start;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {
        [[CCDirector sharedDirector] setDisplayStats:NO];

        CGSize size = [[CCDirector sharedDirector] winSize];
        bg = [CCSprite spriteWithFile:@"top-page@2x.png"];
        bg.position = ccp(size.width/2, size.height/2);
        bg.scaleX = 320 / bg.contentSize.width;
        bg.scaleY = 480 / bg.contentSize.height;
        [self addChild: bg];
        
        
        start = [CCMenuItemImage itemWithNormalImage:@"play@2x.png" selectedImage:@"play@2x.png" target:self selector:@selector(aboutToPlay:)];
     //   door.position = ccp(size.width/5, size.height/5);
        start.scaleX = 130 / start.contentSize.width;
        start.scaleY = 180 / start.contentSize.height;
        
        menu = [CCMenu menuWithItems:start, nil];
        [menu alignItemsVertically];
        menu.position = ccp(size.width/5, size.height/5);
        
        [self addChild:menu];

        CCSprite *menus2 = [CCSprite spriteWithFile:@"button-container@2x.png"];
       
        menus2.position = ccp(220, size.height/4);
        menus2.scaleX = 180 / menus2.contentSize.width;
        menus2.scaleY = 130 / menus2.contentSize.height;
       [self addChild: menus2];
        
         CCMenuItemImage *tutorial = [CCMenuItemImage itemWithNormalImage:@"tutorial@2x.png" selectedImage:nil target:self selector:@selector(tutorial)];
        //   door.position = ccp(size.width/5, size.height/5);
        tutorial.scaleX = 135 / tutorial.contentSize.width;
        tutorial.scaleY = 30 / tutorial.contentSize.height;
        
        CCMenuItemImage *record = [CCMenuItemImage itemWithNormalImage:@"record@2x.png" selectedImage:nil target:self selector:@selector(scores)];
        //   door.position = ccp(size.width/5, size.height/5);
        record.scaleX = 135 / record.contentSize.width;
        record.scaleY = 30 / record.contentSize.height;
        
        menu2 = [CCMenu menuWithItems: tutorial, record, nil];
        [menu2 alignItemsVertically];
        menu2.position = ccp(220, 115);
        
        [self addChild:menu2];
        
        // plist to add definitions of each frame to the cache. for feed_up_end
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"signage.plist"];
        
        // Create a sprite sheet with the squirrel eating chick up images  for feed_up_end
        CCSpriteBatchNode *sign = [CCSpriteBatchNode batchNodeWithFile:@"signage.png"];
        
        [self addChild:sign];
        signage = [CCSprite spriteWithSpriteFrameName:@"s1.png"];
        signage.position = ccp(size.width/5, size.height/6);
        //resize backgroundImage
        signage.scaleX = 50 / signage.contentSize.width;
        signage.scaleY = 40 / signage.contentSize.height;
        //[self addChild:squirrel z:0 tag:1];
        [sign addChild:signage];
        
        
        NSMutableArray *eatUpEndAnimFrames = [NSMutableArray array];
      //  [eatUpEndAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"s1.png"]]];
        for(int i = 1; i <= 4; ++i) {
            [eatUpEndAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"s%d.png", i]]];
            
            CCAnimation *move = [CCAnimation animationWithSpriteFrames:eatUpEndAnimFrames delay:0.18f];
            CCAction *eatUp = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:move ]];
            
            [signage runAction:eatUp];
            }
        
	}
	
	return self;
}


-(void) aboutToPlay: (id) sender {
  //  [self removeChild:menu cleanup:YES];
    timeoutLabel.visible=YES;
    prepareLabel.visible=YES;
    
   /**
    bg2 = [CCSprite spriteWithFile:@"bg@2x.png"];
    bg2.position = ccp(size.width/2, size.height/2);
    bg2.scaleX = 320 / bg2.contentSize.width;
    bg2.scaleY = 480 / bg2.contentSize.height;
    [self removeChild:bg cleanup:YES];
    [self addChild: bg2];
    [self schedule: @selector(tick:) interval:1];
    */
   //  menu.visible = YES;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressInOut transitionWithDuration:1 scene:[HelloWorldLayer node]]];
    
    
}

-(void)scores{

    recordsPage *records = [recordsPage node];
    [[CCDirector sharedDirector] replaceScene:records];
    
    
    

}

-(void)tutorial{

    tutorialScene *tutorialP = [tutorialScene node];
    [[CCDirector sharedDirector] replaceScene:tutorialP];


}

 
@end
