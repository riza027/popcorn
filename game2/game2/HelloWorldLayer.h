//
//  HelloWorldLayer.h
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


typedef enum tagPaddleState {
	kPaddleStateGrabbed,
	kPaddleStateUngrabbed
} PaddleState;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer{
    NSMutableArray *_targets;
    int tags;
    int countBaby;
    CGPoint controlPoint1;
	CGPoint controlPoint2;
    CGPoint endPosition;
    bool _MoveableSprite1touch;
    PaddleState state;
    int gameOverFlag;
    int score;
    int countPopcorn;
    int countPop;
    float spriteWidth;
    float spriteHeight;
    CCLabelTTF *countLbl;
    int timeToPlay;
    CCLabelTTF * prepareLabel;
    CCLabelTTF * timeoutLabel;
    CGRect MoveableSpriteRect;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end


