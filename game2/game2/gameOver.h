// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
//#import <Foundation/Foundation.h>

// HelloWorldLayer
@interface gameOver : CCScene
{
    
     CCLabelTTF *_label;
     NSString *file_name_plist;
    CCLabelTTF *_bestS;

}

@property(nonatomic, retain) CCLabelTTF *_label;
@property(nonatomic, retain) CCLabelTTF *_bestS;
@property(nonatomic, retain) NSString *file_name_plist;


-(void)gameOverFailed;
-(void)Scoring:(NSString*)myScore;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
