//
//  IntroLayer.h
//  game2
//
//  Created by user on 1/14/13.
//  Copyright user 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    
    int timeToPlay;
    CCLabelTTF * prepareLabel;
    CCLabelTTF * timeoutLabel;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
