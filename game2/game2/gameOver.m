//
//  IntroLayer.m
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"
#import "gameOver.h"
#import "IntroLayer.h"
#import "globals.h"

#pragma mark - gameOver

@implementation gameOver

@synthesize _label;
@synthesize _bestS;
@synthesize file_name_plist;
CCSprite *bg;
CCSprite *resultbg;
CCSprite *menu;
CCSprite *gOver;
CCSprite *popcorn;
CCSprite *newRecord;
CCLabelTTF *lblScore;




// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	gameOver *layer = [gameOver node];
	
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
        
        
        /**
        popcorn_file = [NSMutableDictionary dictionaryWithContentsOfFile:file_name_plist];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistDirectory = [NSString stringWithFormat:@"%@", [paths objectAtIndex:0]];
        NSString *popcorn_file_directory = [NSString stringWithFormat:@"%@/Caches", plistDirectory];
        // file name
        file_name_plist =[NSString stringWithFormat:@"%@/%@",popcorn_file_directory, @"popcorn_info.plist"];
        
        
         NSLog(@"CS: %@", [popcorn_file objectForKey:@"score"]);
        NSLog(@"%@", file_name_plist);
       // NSLog(@"%@", popcorn_file);
        
        
        //Then search for cache dir
        NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                    NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cacheDir = [libraryDir stringByAppendingPathComponent:@"Caches"];
        [popcorn_file setObject:@"riza" forKey:@"name"];
        //Then write the file
        file_name_plist = [cacheDir stringByAppendingString:@"/popcorn_info.plist"];
        [popcorn_file writeToFile:file_name_plist atomically:YES];
        
        NSLog(@"%@", file_name_plist);
        */
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        bg = [CCSprite spriteWithFile:@"bg-game.png"];
        bg.position = ccp(size.width/2, size.height/2);
        bg.scaleX = 320 / bg.contentSize.width;
        bg.scaleY = 480 / bg.contentSize.height;
        
        [self addChild: bg];
        
        resultbg = [CCSprite spriteWithFile:@"result-bg@2x.png"];
        resultbg.position = ccp(size.width/2, size.height/2);
        resultbg.scaleX = 240 / resultbg.contentSize.width;
        resultbg.scaleY = 400 / resultbg.contentSize.height;
        
        [self addChild: resultbg];
        
        /**
        globals *scr = [globals sharedObject];
       NSString *lblScore = [NSString stringWithFormat:@"My Total Score is: %@", scr.score];
        CCLabelTTF *totalScore = [CCLabelTTF labelWithString:lblScore fontName:@"Marker Felt" fontSize:25];
        totalScore.position = ccp(size.width/4, size.height/4);
        [self addChild:totalScore];
        NSLog(@"SCORE");
     */
        
        gOver = [CCSprite spriteWithFile:@"gameover-title@2x.png"];
        gOver.position = ccp(size.width/2, 400);
        gOver.scaleX = 180 / gOver.contentSize.width;
        gOver.scaleY = 30 / gOver.contentSize.height;
        
        [self addChild: gOver];
        
        
        popcorn = [CCSprite spriteWithFile:@"popcorn@2x.png"];
        popcorn.position = ccp(size.width/2, 290);
        popcorn.scaleX = 200 / popcorn.contentSize.width;
        popcorn.scaleY = 160 / popcorn.contentSize.height;
        
        [self addChild: popcorn];
        
        
        CCSprite *scoreTitle = [CCSprite spriteWithFile:@"scoreLbl@2x.png"];
        scoreTitle.position = ccp(98, 180);
        scoreTitle.scaleX = 80 / scoreTitle.contentSize.width;
        scoreTitle.scaleY = 30 / scoreTitle.contentSize.height;
        [self addChild:scoreTitle];
        
        self._label = [CCLabelTTF labelWithString:@"" fontName:@"American Typewriter" fontSize:40];
        _label.color = ccc3(0,0,0);
        _label.position = ccp(205, 180);
        [self addChild:_label];
        
       self._bestS = [CCLabelTTF labelWithString:@"" fontName:@"American Typewriter" fontSize:40];
        _bestS.color = ccc3(0,0,0);
        _bestS.position = ccp(205, 135);
        [self addChild:_bestS];
        
        
        CCSprite *bstScore = [CCSprite spriteWithFile:@"bestscore@2x.png"];
        bstScore.position = ccp(112, 135);
        bstScore.scaleX = 110 / bstScore.contentSize.width;
        bstScore.scaleY = 30 / bstScore.contentSize.height;
        [self addChild:bstScore];
        
        
        newRecord = [CCSprite spriteWithFile:@"newrecord@2x-1.png"];
        newRecord.position = ccp(size.width/4 + 150, 350);
        newRecord.scaleX = 75 / newRecord.contentSize.width;
        newRecord.scaleY = 75 / newRecord.contentSize.height;
        [self addChild:newRecord];
        newRecord.visible = NO;
        
        
        
        CCMenuItemImage *playAgain = [CCMenuItemImage itemWithNormalImage:@"playBtn@2x.png" selectedImage:nil target:self selector:@selector(playAgain)];
        //   door.position = ccp(size.width/5, size.height/5);
        playAgain.scaleX = 80 / playAgain.contentSize.width;
        playAgain.scaleY = 30 / playAgain.contentSize.height;
        
        CCMenuItemImage *menu = [CCMenuItemImage itemWithNormalImage:@"menuBtn@2x.png" selectedImage:nil target:self selector:@selector(backToMenu)];
        menu.scaleX = 80 / menu.contentSize.width;
        menu.scaleY = 30 / menu.contentSize.height;
        
        menu = [CCMenu menuWithItems: playAgain, menu, nil];
        [menu alignItemsHorizontally];
        menu.position = ccp(155, 80);
        
        [self addChild:menu];
        
        /**
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"userDefault" ofType:@"plist"];
        
        NSDictionary *appDefault = [NSDictionary dictionaryWithContentsOfFile:defaultPath];
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefault];
        */
        
    //    NSLog(@"APP: %@", appDefault);
     //   NSLog(@"DEFAULT PATH: %@", defaultPath);
        
	}
	
	return self;
}

-(void)Scoring:(NSString*)myScore{
    
    /**
    //Create a Mutant Dictionary
    popcorn_file = [[NSMutableDictionary alloc] init];
    
    //Fill it with data
    //    [popcorn_file setObject:@"1" forKey:@"score"];
    //     [popcorn_file setObject:@"1" forKey:@"best_score"];
    
    //Then search for cache dir
    NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cacheDir = [libraryDir stringByAppendingPathComponent:@"Caches"];
    //Then write the file
    file_name_plist = [cacheDir stringByAppendingString:@"/popcorn_info.plist"];
    [popcorn_file writeToFile:file_name_plist atomically:YES];
    
    NSLog(@"%@", file_name_plist);
    
    
    
    NSString *bestScore = [NSString stringWithFormat:@"%@", [popcorn_file objectForKey:@"best_score"]];
     NSString *currentScore = myScore;
    
    
 //   NSLog(@"CS: %@", [popcorn_file objectForKey:@"score"]);
  
    int s = [myScore intValue];
    int bs = [bestScore intValue];
    NSLog(@"bestScore:%i", bs);
    [popcorn_file setObject:currentScore forKey:@"score"];
 
    if(s > bs){
     //   CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        NSString *BestScoreLbl = [NSString stringWithFormat:@"%@", currentScore];
        [_bestS setString:BestScoreLbl];
        
        [popcorn_file setObject:BestScoreLbl forKey:@"best_score"];
        [popcorn_file writeToFile:file_name_plist atomically:YES];
    }
  
    else{
        NSString *BestScoreLbl = [NSString stringWithFormat:@"%@", currentScore];
        [_bestS setString:BestScoreLbl];
        [popcorn_file writeToFile:file_name_plist atomically:YES];
    }
     */

    
    NSUserDefaults *scoreData = [NSUserDefaults standardUserDefaults];
    int currScore = [myScore intValue];
  //  [scoreData setInteger:s forKey:@"score1"];
    
    int s = [scoreData integerForKey:@"score1"];
    NSLog(@"%i", s);
    NSLog(@"CURRENT SCORE:%i", currScore);
    
    
    if (currScore > s) {
        [scoreData setInteger:currScore forKey:@"score1"];
      
        [_bestS setString:[NSString stringWithFormat:@"%i",currScore]];
        newRecord.visible = YES;
        
        
    }
    else{
    
        [_bestS setString:[NSString stringWithFormat:@"%i",s]];
    
    }
      [scoreData synchronize];
    
    NSLog(@"SCORE: %@", scoreData);
    
   }


-(void)playAgain {


[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1 scene:[HelloWorldLayer node]]];

}


-(void)backToMenu {
[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1 scene:[IntroLayer node]]];


}


/**
-(void)Scoring:(NSString*)myScore{
    
    // total score
    NSString *TotalScoreLbl = [NSString stringWithFormat:@"My Total Score is:%i", ts];
    [_label setString:TotalScoreLbl];
    int ts = [TotalScoreLbl intValue];
}
*/


-(void)dealloc {

  //  [_bestS release];
  //  _bestS = nil;
  //  [_label release];
 //   _label = nil;
    
    [super dealloc];
}

@end
