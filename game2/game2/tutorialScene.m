//
//  IntroLayer.m
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "tutorialScene.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation tutorialScene

CCSprite *bg;
CCSprite *bg2;
CCMenuItemImage *closeBtn;

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
        bg = [CCSprite spriteWithFile:@"tutorialpage@2x.png"];
        bg.position = ccp(size.width/2, size.height/2);
        bg.scaleX = 280 / bg.contentSize.width;
        bg.scaleY = 440 / bg.contentSize.height;
        [self addChild: bg z:10 tag:0];
        
        
        bg2 = [CCSprite spriteWithFile:@"top-page@2x.png"];
        bg2.position = ccp(size.width/2, size.height/2);
        bg2.scaleX = 320 / bg2.contentSize.width;
        bg2.scaleY = 480 / bg2.contentSize.height;
        [self addChild: bg2 z:0 tag:0];
        
        
        closeBtn = [CCMenuItemImage itemWithNormalImage:@"closebtn@2x.png" selectedImage:nil target:self selector:@selector(returnToHome)];
        //   door.position = ccp(size.width/5, size.height/5);
        closeBtn.scaleX = 50 / closeBtn.contentSize.width;
        closeBtn.scaleY = 50 / closeBtn.contentSize.height;
        
        CCMenu *menu = [CCMenu menuWithItems:closeBtn, nil];
        [menu alignItemsVertically];
        menu.position = ccp(275, 440);
        
        [self addChild:menu z:20 tag:0];
        
	}
	
	return self;
}


-(void)returnToHome{

    NSLog(@"CLOSE");
   [[CCDirector sharedDirector] replaceScene:[IntroLayer node]];

}

// EDIT


@end
