//
//  HelloWorldLayer.m
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "globals.h"

enum {
    kTagCannonSprite = 1001,
	kTagCatBezierAction,
	kTagControlPoint1Sprite,
	kTagControlPoint1Label,
	kTagControlPoint2Sprite,
	kTagControlPoint2Label,
	kTagEndPointSprite,
};


// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "CCTouchDispatcher.h"
#import "IntroLayer.h"
#import "gameOver.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer


CCSprite *target;
CCSprite *sprite2;
CCSprite *sprite3;
CCSprite *collision;
CCSprite *collisionLeft;
CCSprite *bg;
CCSprite *scoreBoard;
CCSprite *machineUp;
CCSprite *machineLeft;
CCSprite *machineRight;
CCSprite *imthin;
CCSprite *imfat;
CCSprite *tablet;
NSArray *paddles;
NSString *projectile;
float leftStartXPosition;
float rightStartXPosition;
CCSpriteFrameCache* frameCache;
int actX;
CCMenu *pauseM;
CCMenu *resumeM;
bool paustatus = TRUE;
int imfatTimer;
int imthinTimer;
int imfatFlag;
int imthinFlag;
int imfattestFlag;
int tabletCountdown;
bool isFat;
bool thin;
bool isNormal;
bool fat;
NSString *sprite;
CGPoint location;


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        [[CCDirector sharedDirector] setDisplayStats:NO];

        self.isTouchEnabled = YES;
        tabletCountdown = 10;
        isFat = NO;
        tags = 0;
        thin = NO;
        fat = NO;
        isNormal = NO;
        countPopcorn = 0;
    //   globals *scr2 = [globals sharedObject];
     //   scr2.score = @"0";
        gameOverFlag = 0;
      //  sprite = @"normal";
        _targets = [[NSMutableArray alloc] init];
        imfatTimer = 3;
        imthinTimer = 3;
        imfatFlag = 1; //not fat 0, fat 1
        imfattestFlag = 1;
        imthinFlag = 1; //not thin 0, thin 1
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        bg = [CCSprite spriteWithFile:@"bg-game.png"];
        bg.position = ccp(size.width/2, size.height/2);
        bg.scaleX = 320 / bg.contentSize.width;
        bg.scaleY = 480 / bg.contentSize.height;
        [self addChild: bg z:0 tag:0];
        
        scoreBoard = [CCSprite spriteWithFile:@"score@2x.png"];
        scoreBoard.scaleX = 60 / scoreBoard.contentSize.width;
        scoreBoard.scaleY = 60 / scoreBoard.contentSize.height;
        scoreBoard.position = ccp(60, 420);
        [self addChild: scoreBoard];
        
        
        machineUp = [CCSprite spriteWithFile:@"machine-up@2x.png"];
        machineUp.scaleX = 50 / machineUp.contentSize.width;
        machineUp.scaleY = 50 / machineUp.contentSize.height;
        machineUp.position = ccp(size.width/2, 380);
        [self addChild: machineUp];
        
        
        machineLeft = [CCSprite spriteWithFile:@"machine-left@2x.png"];
        machineLeft.scaleX = 50 / machineLeft.contentSize.width;
        machineLeft.scaleY = 50 / machineLeft.contentSize.height;
        machineLeft.position = ccp(size.width/2, 380);
        [self addChild: machineLeft];
        machineLeft.visible=NO;
        
        machineRight = [CCSprite spriteWithFile:@"machine-right@2x.png"];
        machineRight.scaleX = 50 / machineRight.contentSize.width;
        machineRight.scaleY = 50 / machineRight.contentSize.height;
        machineRight.position = ccp(size.width/2, 380);
        [self addChild: machineRight];
        machineRight.visible=NO;
        
        
        _MoveableSprite1touch=FALSE;
		sprite2 =[CCSprite spriteWithFile:@"normal-1@2x.png"];
        sprite2.scaleX = 220 / sprite2.contentSize.width;
        sprite2.scaleY = 180 / sprite2.contentSize.height;
		sprite2.position = ccp(size.width/2,80);
        sprite2.anchorPoint = CGPointMake(0.5, 0.5);
		[self addChild:sprite2 z:100 tag:0];
        
        
        imfat = [CCSprite spriteWithFile:@"fat@2x.png"];
        imfat.scaleX = 75 / imfat.contentSize.width;
        imfat.scaleY = 75 / imfat.contentSize.height;
        imfat.position = ccp(size.width/2 + 50, size.height/4 + 95);
        [self addChild: imfat];
        imfat.visible=NO;
        
        
        imthin = [CCSprite spriteWithFile:@"thin@2x.png"];
        imthin.scaleX = 75 / imthin.contentSize.width;
        imthin.scaleY = 75 / imthin.contentSize.height;
        imthin.position = ccp(size.width/2 + 50, size.height/4 + 95);
        [self addChild: imthin];
        imthin.visible=NO;
        
        

     //   [self startTheGame];
/**
        NSString *cannon = [NSString stringWithFormat:@"popcorn@2x.png"];
        target = [CCSprite spriteWithFile:cannon];
        spriteWidth =  30 / target.contentSize.width;
        spriteHeight = 30 / target.contentSize.height;
        //target.scaleX = 30 / target.contentSize.width;
        //target.scaleY = 30 / target.contentSize.height;
        
        target.scaleX = spriteWidth;
        target.scaleY = spriteHeight;
       // target.position = ccp(139, 400);
        [self addChild:target];
    */
        
        collision =[CCSprite spriteWithFile:@"bg-game.png"];
        collision.scaleX = 320 / collision.contentSize.width;
        collision.scaleY = 10 / collision.contentSize.height;
		collision.position = ccp(size.width/2,0);
		[self addChild:collision];
        
        
        collisionLeft =[CCSprite spriteWithFile:@"bg-game.png"];
        collisionLeft.scaleX = 320 / collisionLeft.contentSize.width;
        collisionLeft.scaleY = 10 / collisionLeft.contentSize.height;
		collisionLeft.position = ccp(-size.width/2,0);
		[self addChild:collisionLeft];
        
        
       CCSprite *a =[CCSprite spriteWithFile:@"trans_collision@2x.png"];
        a.scaleX = 320 / a.contentSize.width;
        a.scaleY = 50 / a.contentSize.height;
		a.position = ccp(size.width,0);
		[self addChild:a z:50 tag:0];
        
        // plist to add definitions of each frame to the cache.
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"man.plist"];
        // Create a sprite sheet with the blue balloon
        CCSpriteBatchNode *popAnim = [CCSpriteBatchNode batchNodeWithFile:@"man.png"];
        [self addChild:popAnim];
        
        
        //for pause game
        CCMenuItemImage *pauseBtn = [CCMenuItemImage itemWithNormalImage:@"pause@2x.png" selectedImage:nil target:self selector:@selector(pauseGame)];
        pauseBtn.scaleX = 52 / pauseBtn.contentSize.width;
        pauseBtn.scaleY = 52 / pauseBtn.contentSize.height;
        pauseM = [CCMenu menuWithItems:pauseBtn, nil];
        pauseM.position = ccp(270, 430);
        [self addChild:pauseM z:40 tag:0];
        
        //for resume
        CCMenuItemImage *resumeBtn = [CCMenuItemImage itemWithNormalImage:@"resume@2x.png" selectedImage:nil target:self selector:@selector(resumeGame)];
        resumeBtn.scaleX = 45 / resumeBtn.contentSize.width;
        resumeBtn.scaleY = 45 / resumeBtn.contentSize.height;
        resumeM = [CCMenu menuWithItems:resumeBtn, nil];
        resumeM.position = ccp(270, 430);
        [self addChild:resumeM z:40 tag:0];
        resumeM.visible = NO;
        
        countLbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", score] fontName:@"Marker Felt" fontSize:35];
        countLbl.position =  ccp( 60 , 410 );
		countLbl.color = ccc3(0, 0, 0);
		// add the label as a child to this Layer
		[self addChild: countLbl];
        
       
          timeToPlay = 5;
        
        double time = 1.0;
        id delay = [CCDelayTime actionWithDuration: time];
        id callbackAction = [CCCallFunc actionWithTarget: self selector: @selector(tick)];
        id sequence = [CCSequence actions: delay, callbackAction, nil];
        [self runAction: sequence];
        return self;
        timeoutLabel  = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:50];
        timeoutLabel.position =  ccp( size.width/2, size.height/2);
        [self addChild: timeoutLabel];

        
    //    [self startSpriteMovement];
    
        //     [self schedule:@selector(update:) interval:0.5];
        
     //   [self schedule:@selector(update:)];
     //   [self addTarget];
        
    }
	return self;
}

-(void)startTheGame{
    //[self addTarget];
    //[self addTarget2];
    //[self schedule:@selector(gameLogic:) interval:0.1];
    SEL setActionIsDone1 = @selector(gameLogic1:);
    [self performSelector:setActionIsDone1 withObject:nil afterDelay:2.0];
 //   [self schedule:@selector(update:)];
    
}
-(void)gameLogic1:(ccTime)dt{
    [self startSpriteMovement];
    
  //  [self schedule:@selector(startTabletTimer:) interval:1.0f];

}


-(void)startTabletTimer:(ccTime)dt {

    tabletCountdown = tabletCountdown - 1;
    if (tabletCountdown <= 0) {
        [self unschedule:@selector(startTabletTimer:)];
            NSLog(@"TABLET: %i", tabletCountdown);
    }
}


-(void) tick
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    if(timeToPlay==1) [self startTheGame];
    else {
        timeToPlay--;
        NSString * countStr;
        
        if(timeToPlay==1){
            countStr = [NSString stringWithFormat:@"GO!"];
        }
        else{
            countStr = [NSString stringWithFormat:@"%d", timeToPlay-1];
            
        }
        timeoutLabel.string = countStr;
        
        //and some cool animation effect
        CCLabelTTF* label = [CCLabelTTF labelWithString:countStr fontName:@"Marker Felt" fontSize:60];
        
      //  label.position = timeoutLabel.position;
        label.position = ccp(size.width/2, size.height/2);
        label.color = ccBLACK;
        [self addChild: label z: 1001];
        
        id scoreAction = [CCSequence actions:[CCSpawn actions:[CCScaleBy actionWithDuration:0.4 scale:2.0],[CCEaseIn actionWithAction:[CCFadeOut actionWithDuration:0.4] rate:2],nil],[CCCallBlock actionWithBlock:^{
            [self removeChild:label cleanup:YES];
        }],nil];
        [label runAction:scoreAction];
        
        double time = 1.0;
        id delay = [CCDelayTime actionWithDuration: time];
        id callbackAction = [CCCallFunc actionWithTarget: self selector: @selector(tick)];
        id sequence = [CCSequence actions: delay, callbackAction, nil];
        [self runAction: sequence];
    }
}

-(void)imfatCountdown:(ccTime)dt {
    NSLog(@"imfatCountdown");
    imfatTimer--;
    
    if (imfatTimer <= 0) {
        imfatFlag = 0;
        imfat.visible = NO;
        [self unschedule:@selector(imfatCountdown:)];
        imfatTimer = 3;
    }
    else{
        imfatFlag = 0;
        imfat.visible = YES;
    }
}

-(void)imfattestCountdown:(ccTime)dt{

    NSLog(@"imfatCountdown");
    imfatTimer--;
    
    if (imfatTimer <= 0) {
        imfattestFlag = 0;
        imfat.visible = NO;
        [self unschedule:@selector(imfattestCountdown:)];
        imfatTimer = 3;
    }
    else{
        imfattestFlag = 0;
        imfat.visible = YES;
    }


}



-(void)imthinCountdown:(ccTime)dt{
   
    imthinTimer--;
    
    if (imthinTimer <= 0) {
        imthinFlag = 0;
        imthin.visible = NO;
        [self unschedule:@selector(imthinCountdown:)];
        imthinTimer = 3;
        }
    else{
        imthinFlag = 0;
        imthin.visible = YES;
               
    }


}

-(void)startSpriteMovement
{
    
  //  int r = arc4random() % 2;
    
    NSString *projectile = @"";

    if (tabletCountdown <= 0) {
        
        projectile = [NSString stringWithFormat:@"tablet@2x.png"];
        
    }
    else if (tabletCountdown > 0) {
    
        projectile = [NSString stringWithFormat:@"popcorn_1.png"];
        
    }
    
    
    target = [CCSprite spriteWithFile:projectile];
    spriteWidth =  50 / target.contentSize.width;
    spriteHeight = 50 / target.contentSize.height;
    target.scaleX = spriteWidth;
    target.scaleY = spriteHeight;
    [self addChild:target z:50];
    
    
    
    NSLog(@"SPRITE: %@", projectile);
    actX = (arc4random() % 320);

   //   CCSprite *target = (CCSprite *)[self getChildByTag:kTagCannonSprite];
	// Setup default positions for the bezier
    	controlPoint1 = ccp(165, 400);
    	controlPoint2 = ccp(165, 620);
    	endPosition = ccp(165, 20);

    target.position = controlPoint1;
    target.scaleX = spriteWidth/10;
    target.scaleY = spriteHeight/10;
    
    [self cornMovement];
}

-(void)cornMovement
{
   
    target.visible = NO;
   // [self removeChild:target cleanup:YES];
    NSString *projectile = @"";
    
    if (tabletCountdown <= 0) {
        
        projectile = [NSString stringWithFormat:@"tablet@2x.png"];
      //  tablet = target;
        tags =  2;
        target.tag = tags ;
    }
    else if (tabletCountdown > 0) {
        
        projectile = [NSString stringWithFormat:@"popcorn_1.png"];
        tags =  1;
        target.tag = tags;
        
    }
    
    target = [CCSprite spriteWithFile:projectile];
    spriteWidth =  50 / target.contentSize.width;
    spriteHeight = 50 / target.contentSize.height;
    target.scaleX = spriteWidth;
    target.scaleY = spriteHeight;
    [self addChild:target z:50 tag:tags];


    target.visible =YES;
  //  CCSprite *target = (CCSprite *)[self getChildByTag:kTagCannonSprite];
    ccBezierConfig bezier;
    id bezierAction;
    [self schedule:@selector(update:)];
    // Create the bezier path
    bezier.controlPoint_1 = controlPoint1;
    bezier.controlPoint_2 = controlPoint2;
    bezier.endPosition = endPosition;

    int actualX2 = (arc4random() % 320);

    
    target.position = controlPoint1;
    target.scaleX = spriteWidth/10;
    target.scaleY = spriteHeight/10;
    controlPoint1 = ccp(165, 400);
    controlPoint2 = ccp(actualX2, 620);
    float x = controlPoint2.x;
    
     NSLog(@"END POSITION: %f", controlPoint1.x);
    
     if (endPosition.x < 220 && endPosition.x > 120 ) {
        machineUp.visible = YES;
        machineLeft.visible = NO;
         machineRight.visible = NO;
         target.position = ccp(160, 400);

    }
    else if (endPosition.x < 120) {
        machineLeft.visible = YES;
        machineUp.visible = NO;
        machineRight.visible = NO;
        target.position = ccp(150, 400);
        //controlPoint1.x = 145;
    }
    else if (endPosition.x > 220){
        machineRight.visible = YES;
        machineLeft.visible = NO;
        machineUp.visible = NO;
        target.position = ccp(170, 400);
      //  controlPoint1.x = 175;
    }

    endPosition = ccp(x, 10);
    float dur;
    if (countPop > 20) {
        dur = 1.5;
    }
    else if (countPop <= 20){
        dur = 2;
    }
    else if (countPop > 40){
        dur = 1.20;
    
    }
    
    // Creat the bezier action
	bezierAction = [CCBezierTo actionWithDuration:dur bezier:bezier];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(bezierFinished2:)];
   
	// Run the action sequence
    [target runAction:[CCScaleTo actionWithDuration:4 scale:1.5f]];
     [target runAction:[CCRotateBy actionWithDuration:3 angle:360]];
	CCAction *arcAction = [CCSequence actions: bezierAction, callback, nil];
//	arcAction.tag = kTagCatBezierAction;
	[target runAction:arcAction];
   //       NSLog(@"SPRITE: %@", projectile);
   
}


-(void)checkCollision {
    
  //  CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGSize texSize3 = [collision contentSize];
    CGSize texSize4 = [collisionLeft contentSize];
    //Rect for popcorn and person
  //  CGRect characterRect = CGRectMake(sprite2.position.x, sprite2.position.y, sprite2.contentSize.width/2, sprite2.contentSize.height);
    
   CGRect charRect = CGRectMake(sprite2.position.x+6,
                                    sprite2.position.y +40,
                                    sprite2.contentSize.width/7,
                                    sprite2.contentSize.height/2);
    CGRect objectRect;
    objectRect = CGRectMake(target.position.x, target.position.y, target.contentSize.width, target.contentSize.height);
    
    
    //Rect for popcorn and trans-collision
    CGRect colRect = CGRectMake(collision.position.x, collision.position.y, texSize3.width+300, texSize3.height/10);
    CGRect colRect2 = CGRectMake(collisionLeft.position.x, collisionLeft.position.y, texSize4.width, texSize4.height/10);
    

    if(CGRectIntersectsRect(charRect, objectRect)){
        NSLog(@"TAGS: %i", target.tag);
        
        //when he eats popcorn
        if (target.tag == 1) {
            score = score + 1;
            countPopcorn = countPopcorn + 1;
            countPop = countPop + 1;
            [countLbl setString:[NSString stringWithFormat:@"%i", score]];
            NSLog(@"%i", score);
            NSLog(@"COLLIDE");
            CCAction *eat;
            
            if (countPopcorn >= 10 && countPopcorn <= 19) {
                
                if (!isNormal) {
              
                    if (imfatFlag == 1) {
                        [self schedule:@selector(imfatCountdown:) interval:0.5f];
                    }
                isFat = TRUE;
                imthinFlag = 1;
                sprite = @"fat";
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"fat-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fat-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
              //  [self unschedule:@selector(imfatCountdown:)];
                }
                else if (isNormal){
                
                    isFat = NO;
                    imfattestFlag = 1;
                    imthinFlag = 1;
                    sprite = @"normal";
                    
                    if (imfatFlag == 1) {
                        [self schedule:@selector(imfatCountdown:) interval:0.5f];
                    }
                    NSMutableArray *expAnim = [NSMutableArray arrayWithCapacity:3];
                    for (int i = 1; i < 4; i++)
                    {
                        NSString* file = [NSString stringWithFormat:@"man-normal-%i@2x.png", i];
                        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                        [expAnim addObject:frame];
                    }
                    [expAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"man-normal-1@2x.png"]]];
                    
                    CCAnimation *expOkAnim = [CCAnimation animationWithSpriteFrames:expAnim delay:0.03f];
                    eat = [CCAnimate actionWithAnimation:expOkAnim];
                    [sprite2 runAction:eat];
                    [self unschedule:@selector(update:)];
                    
                    [target runAction:[CCSequence actions:
                                       [CCDelayTime actionWithDuration:0.08f],
                                       [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                       nil]];
                    //  target.visible =NO;
                
                }
                else if (thin) {
                
                    isFat = NO;
                    imfatFlag = 1;
                    imfattestFlag = 1;
                    imthinFlag = 1;
                    sprite = @"thin";
                    NSMutableArray *expAnim = [NSMutableArray arrayWithCapacity:3];
                    for (int i = 1; i < 4; i++)
                    {
                        NSString* file = [NSString stringWithFormat:@"thin-%i@2x.png", i];
                        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                        [expAnim addObject:frame];
                    }
                    [expAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"thin-1@2x.png"]]];
                    
                    CCAnimation *expOkAnim = [CCAnimation animationWithSpriteFrames:expAnim delay:0.03f];
                    eat = [CCAnimate actionWithAnimation:expOkAnim];
                    [sprite2 runAction:eat];
                    [self unschedule:@selector(update:)];
                    
                    [target runAction:[CCSequence actions:
                                       [CCDelayTime actionWithDuration:0.08f],
                                       [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                       nil]];
                
                }
                
            else if (fat){
        
                if (imfatFlag == 1) {
                    [self schedule:@selector(imfatCountdown:) interval:0.5f];
                }
                isFat = TRUE;
                imthinFlag = 1;
                sprite = @"fat";
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"fat-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fat-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
                
            }
                
            }
            
           else if (countPopcorn >= 20) {
                imthinFlag = 1;
               if (imfattestFlag == 1) {
                   [self schedule:@selector(imfattestCountdown:) interval:0.5f];
               }
                isFat = TRUE;
               sprite = @"fattest";
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"fattest-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fattest-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
           //    [self unschedule:@selector(imfatCountdown:)];
                
            }
            
            else if (countPopcorn < 10){
                
                if (!thin && !fat) {
                isFat = NO;
                imfatFlag = 1;
                imfattestFlag = 1;
                imthinFlag = 1;
                sprite = @"normal";
                    if (countPopcorn == 9) {
                        fat = YES;
                        isNormal = NO;
                    }
                    
                NSMutableArray *expAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"man-normal-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [expAnim addObject:frame];
                }
                [expAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"man-normal-1@2x.png"]]];
                
                CCAnimation *expOkAnim = [CCAnimation animationWithSpriteFrames:expAnim delay:0.03f];
                eat = [CCAnimate actionWithAnimation:expOkAnim];
                [sprite2 runAction:eat];
                [self unschedule:@selector(update:)];
                
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
                //  target.visible =NO;
                }
                
                else if (isNormal){
                
                    isFat = NO;
                    imfatFlag = 1;
                    imfattestFlag = 1;
                    imthinFlag = 1;
                    
                    if (countPopcorn == 9) {
                        fat = YES;
                        isNormal = NO;
                    }
                    
                    sprite = @"normal";
                    NSMutableArray *expAnim = [NSMutableArray arrayWithCapacity:3];
                    for (int i = 1; i < 4; i++)
                    {
                        NSString* file = [NSString stringWithFormat:@"man-normal-%i@2x.png", i];
                        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                        [expAnim addObject:frame];
                    }
                    [expAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"man-normal-1@2x.png"]]];
                    
                    CCAnimation *expOkAnim = [CCAnimation animationWithSpriteFrames:expAnim delay:0.03f];
                    eat = [CCAnimate actionWithAnimation:expOkAnim];
                    [sprite2 runAction:eat];
                    [self unschedule:@selector(update:)];
                    
                    [target runAction:[CCSequence actions:
                                       [CCDelayTime actionWithDuration:0.08f],
                                       [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                       nil]];
                    //  target.visible =NO;
                
                }
                
                else if (thin){
                isFat = NO;
                NSLog(@"THIN: %i", thin);
               // thin = 0;
                imfatFlag = 1;
                imfattestFlag = 1;
                imthinFlag = 1;
                    if (countPopcorn == 9) {
                isNormal = YES;
                }
                sprite = @"thin";
                NSMutableArray *expAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"thin-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [expAnim addObject:frame];
                }
                [expAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"thin-1@2x.png"]]];
                
                CCAnimation *expOkAnim = [CCAnimation animationWithSpriteFrames:expAnim delay:0.03f];
                eat = [CCAnimate actionWithAnimation:expOkAnim];
                [sprite2 runAction:eat];
                [self unschedule:@selector(update:)];
                
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
                }
                
                else if (fat){
                    isFat = TRUE;
                    imthinFlag = 1;
                    sprite = @"fat";
                    NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                    for (int i = 1; i < 4; i++)
                    {
                        NSString* file = [NSString stringWithFormat:@"fat-%i@2x.png", i];
                        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                        [fatAnim addObject:frame];
                    }
                    [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fat-1@2x.png"]]];
                    
                    CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                    CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                    [sprite2 runAction:eat2];
                    [self unschedule:@selector(update:)];
                    [target runAction:[CCSequence actions:
                                       [CCDelayTime actionWithDuration:0.08f],
                                       [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                       nil]];
                
                }
                
            }
            
            
        }
        //when he eats medicine
        else if (target.tag == 2){
            NSLog(@"SPRITE NAME: %@", sprite);
            
            if (sprite == @"fat") {
                tabletCountdown = 10;
                countPopcorn = 0;
                isNormal = YES;
                imfatFlag = 1;
                isFat = NO;
                
                if (imthinFlag == 1) {
                    [self schedule:@selector(imthinCountdown:) interval:0.5f];
                }
                
                NSLog(@"COLLIDE");
                NSLog(@"IM THIN");
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"man-normal-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"man-normal-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
            }
            else if (sprite == @"fattest") {
                tabletCountdown = 10;
                countPopcorn = 0;
                isFat = YES;
                fat = YES;
                imfattestFlag = 1;
                if (imthinFlag == 1) {
                    [self schedule:@selector(imthinCountdown:) interval:0.5f];
                }
                
                NSLog(@"COLLIDE");
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"fat-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fat-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
                //     [self unschedule:@selector(imfatCountdown:)];
                
                
            }
            
            else if (sprite == @"fattest") {
                tabletCountdown = 10;
                countPopcorn = 0;
                isFat = YES;
                fat = YES;
                imfattestFlag = 1;
                NSLog(@"COLLIDE");
                if (imthinFlag == 1) {
                    [self schedule:@selector(imthinCountdown:) interval:0.5f];
                }
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"fattest-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fattest-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
            }
            
            else if (sprite == @"normal") {
                tabletCountdown = 10;
                isFat = NO;
                countPopcorn = 0;
                thin = YES;
                isNormal = NO;
                
                if (imthinFlag == 1) {
                    [self schedule:@selector(imthinCountdown:) interval:0.5f];
                }
                
                NSLog(@"COLLIDE");
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"thin-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"thin-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
            }
            
            else if (sprite == @"thin") {
                tabletCountdown = 10;
                isFat = NO;
                countPopcorn = 0;
                isNormal = NO;
                thin = YES;
                
                if (imthinFlag == 1) {
                    [self schedule:@selector(imthinCountdown:) interval:0.5f];
                }
                
                NSLog(@"COLLIDE");
                NSMutableArray *fatAnim = [NSMutableArray arrayWithCapacity:3];
                for (int i = 1; i < 4; i++)
                {
                    NSString* file = [NSString stringWithFormat:@"thin-%i@2x.png", i];
                    CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
                    [fatAnim addObject:frame];
                }
                [fatAnim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"thin-1@2x.png"]]];
                
                CCAnimation *fatAnim2 = [CCAnimation animationWithSpriteFrames:fatAnim delay:0.03f];
                CCAction *eat2 = [CCAnimate actionWithAnimation:fatAnim2];
                [sprite2 runAction:eat2];
                [self unschedule:@selector(update:)];
                [target runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:0.08f],
                                   [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
                                   nil]];
            }
            
            
        }
        
    }

  
    else if ((CGRectIntersectsRect(colRect, objectRect)) && target.tag == 1)
    {
        
          //  [self unschedule:@selector(update:)];
            double time = 0.3;
            id delay = [CCDelayTime actionWithDuration: time]; 
            id gOver = [CCCallFunc actionWithTarget:self selector:@selector(gameOver)];
            CCAction *arcAction = [CCSequence actions:  gOver, nil];
            [self runAction:arcAction];
            [target stopAllActions];
            [self unschedule:@selector(update:)];
        
            NSLog(@"GAME OVER");

    }
    
    else if ((CGRectIntersectsRect(colRect2, objectRect)) && target.tag == 1)
    {
        
     //   [self unschedule:@selector(update:)];
        double time = 0.3;
        id delay = [CCDelayTime actionWithDuration: time];
        id gOver = [CCCallFunc actionWithTarget:self selector:@selector(gameOver)];
        CCAction *arcAction = [CCSequence actions: gOver, nil];
        [self runAction:arcAction];
        [target stopAllActions];
        [self unschedule:@selector(update:)];

        
        NSLog(@"GAME OVER2");
        
    }
    
    else if ((CGRectIntersectsRect(colRect2, objectRect)) && target.tag == 2)
    {
    
        NSLog(@"OKAY");
        target.visible = NO;
        tabletCountdown = 10;
        
    }
    else if ((CGRectIntersectsRect(colRect, objectRect)) && target.tag == 2)
    {
        NSLog(@"OKAY 2");
        target.visible = NO;
        tabletCountdown = 10;
    }
    
   /** else if (target.tag == 2 && target.position.y < 50){
            NSLog(@"OKAY");
        //[self unschedule:@selector(update:)];
      //  [target runAction:[CCSequence actions:
      //                     [CCDelayTime actionWithDuration:0.08f],
      //                     [CCCallFunc actionWithTarget:self selector:@selector(removeSprite)],
         //                  nil]];
        tabletCountdown = 5;
        target.visible = NO;
    } */
    
        
}

-(void)removeSprite{


    if (target.tag == 1) {
        target.visible = NO;
    }
    else if (target.tag = 2){
    target.visible = NO;
    }
}

-(void) update:(ccTime)delta{

    
    [self checkCollision];
    
}


-(void)bezierFinished2:(id)sender
{
    [self unschedule:@selector(update:)];
  //  CCSprite *sprite = (CCSprite *)sender;
  //  [self removeChild:sprite cleanup:YES];
	// Perform the movement
    if (gameOverFlag == 0) {
        
        if (tabletCountdown == 10) {
            
           int r = arc4random() % 5;
            [self schedule:@selector(startTabletTimer:) interval:r];
            NSLog(@"TABLET: %i", tabletCountdown);
        }
        [self cornMovement];
    }
    else {
        [self gameOver];
    }
      
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* myTouch = [touches anyObject];
	location = [myTouch locationInView: [myTouch view]];
	location = [[CCDirector sharedDirector]convertToGL:location];

	MoveableSpriteRect = CGRectMake(sprite2.position.x - (sprite2.contentSize.width/2),
                                           sprite2.position.y - (sprite2.contentSize.height/2),
                                           sprite2.contentSize.width,
                                           sprite2.contentSize.height);
	if (CGRectContainsPoint(MoveableSpriteRect, location)) {
		_MoveableSprite1touch=TRUE;
	}

}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (paustatus == TRUE) {
    
  //  CCSprite *tempSprite = (CCSprite *)[self getChildByTag:0];
    UITouch *myTouch = [touches anyObject];
	CGPoint point = [myTouch locationInView:[myTouch view]];
	point = [[CCDirector sharedDirector] convertToGL:point];
        if(_MoveableSprite1touch==TRUE){
            if (isFat == NO) {
            sprite2.position = ccp(point.x, 80);
            }
            else if (isFat == TRUE){
                
              //  float speed=500;
               // float dist = ccpDistance(location, point);
               // float dur = dist/speed;
                
            id move = [CCMoveTo actionWithDuration:0.25 position:ccp(point.x, 80)];
            [sprite2 runAction:move];
            
            }
        }
    }
    
}
    
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	_MoveableSprite1touch=FALSE;

}


-(void)gameOver{
     // if (target.tag == 1) {
   // [self unschedule:@selector(update:)];
    gameOverFlag = 1;
   // CCSprite *sprite = (CCSprite *)sender;
   // [self removeChild:target cleanup:YES];
    //[_targetsLeft release];
    
  //  [self runAction:[CCSequence actions:
                 //    [CCCallFunc actionWithTarget:self selector:@selector(gameOverFailed)],
               //      nil]];
    
    [self gameOverFailed];
    
   // }
}


-(void)gameOverFailed {
   // CGSize size = [[CCDirector sharedDirector] winSize];
    
    gameOver *gameOverScene = [gameOver node];
    NSString *lblScore = [NSString stringWithFormat:@"%i", score];
  //  CCLabelTTF *totalScore = [CCLabelTTF labelWithString:lblScore fontName:@"Marker Felt" fontSize:25];
//    totalScore.position = ccp(size.width/4, size.height/5);
    [gameOverScene._label setString:lblScore];
    [gameOverScene Scoring:[NSString stringWithFormat:@"%i", score]];
  //  [self addChild:totalScore];
  //  [[CCDirector sharedDirector] replaceScene:gameOverScene];
    
    
      [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:gameOverScene]];
}


-(void)pauseGame{
    NSLog(@"Pause");
    pauseM.visible = NO;
    resumeM.visible = YES;
    paustatus = FALSE;
    [[CCDirector sharedDirector] pause];
}

-(void)resumeGame{
    NSLog(@"Play");
    pauseM.visible = YES;
    resumeM.visible = NO;
    paustatus = TRUE;
    _MoveableSprite1touch = TRUE;
    [[CCDirector sharedDirector] resume];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
