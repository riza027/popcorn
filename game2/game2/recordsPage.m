//
//  IntroLayer.m
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "recordsPage.h"
#import "HelloWorldLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation recordsPage

@synthesize _bestS;

CCSprite *bg;
CCSprite *bg2;
CCSprite *popcorn;
CCMenu *menus;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	recordsPage *layer = [recordsPage node];
	
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
        bg = [CCSprite spriteWithFile:@"result-bg@2x.png"];
        bg.position = ccp(size.width/2, size.height/2);
        bg.scaleX = 280 / bg.contentSize.width;
        bg.scaleY = 400 / bg.contentSize.height;
        [self addChild: bg z:10 tag:0];
        
        
        popcorn = [CCSprite spriteWithFile:@"big-popcorn@2x.png"];
        popcorn.position = ccp(size.width/2, 220);
        popcorn.scaleX = 90 / popcorn.contentSize.width;
        popcorn.scaleY = 100 / popcorn.contentSize.height;
        
        [self addChild: popcorn z:20];
        
        CCSprite *bstScore = [CCSprite spriteWithFile:@"bestscore-title@2x.png"];
        bstScore.position = ccp(size.width/2, 370);
        bstScore.scaleX = 180 / bstScore.contentSize.width;
        bstScore.scaleY = 30 / bstScore.contentSize.height;
        [self addChild:bstScore z:20];
        
        
        self._bestS = [CCLabelTTF labelWithString:@"" fontName:@"American Typewriter" fontSize:45];
        _bestS.color = ccc3(0,180,0);
        _bestS.position = ccp(size.width/2, 320);
        [self addChild:_bestS z:20];
        

        bg2 = [CCSprite spriteWithFile:@"top-page@2x.png"];
        bg2.position = ccp(size.width/2, size.height/2);
        bg2.scaleX = 320 / bg2.contentSize.width;
        bg2.scaleY = 480 / bg2.contentSize.height;
        [self addChild: bg2 z:0 tag:0];
        
        
        NSUserDefaults *scoreData = [NSUserDefaults standardUserDefaults];
       // int currScore = [myScore intValue];
        
        int s = [scoreData integerForKey:@"score1"];
            
        [_bestS setString:[NSString stringWithFormat:@"%i",s]];

        [scoreData synchronize];
        
        
        CCMenuItemImage *playAgain = [CCMenuItemImage itemWithNormalImage:@"playBtn@2x.png" selectedImage:nil target:self selector:@selector(play)];
        //   door.position = ccp(size.width/5, size.height/5);
        playAgain.scaleX = 100 / playAgain.contentSize.width;
        playAgain.scaleY = 50 / playAgain.contentSize.height;
        
        CCMenuItemImage *menubtn = [CCMenuItemImage itemWithNormalImage:@"menuBtn@2x.png" selectedImage:nil target:self selector:@selector(backToMenu)];
        menubtn.scaleX = 100 / menubtn.contentSize.width;
        menubtn.scaleY = 50 / menubtn.contentSize.height;
        
        menus = [CCMenu menuWithItems: playAgain, menubtn, nil];
        [menus alignItemsHorizontally];
        menus.position = ccp(size.width/2, 120);
        
        [self addChild:menus z:20];
        
        
	}
	
	return self;
}

-(void)play{

[[CCDirector sharedDirector] replaceScene:[CCTransitionProgressInOut transitionWithDuration:1 scene:[HelloWorldLayer node]]];

}


-(void)backToMenu{

[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1 scene:[IntroLayer node]]];

}


@end
