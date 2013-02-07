/* TouchesTest (c) Valentin Milea 2009
 */
#import "cocos2d.h"

typedef enum tagPaddleState {
	kPaddleStateGrabbed,
	kPaddleStateUngrabbed
} PaddleState;

@interface sprite : CCSprite <CCTouchOneByOneDelegate> {
@private
	PaddleState state;
    NSMutableArray *_targets;
    int tags;
    int countBaby;
}

@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, readonly) CGRect rectInPixels;

+ (id)paddleWithTexture:(CCTexture2D *)texture;
@end
