
#import "sprite.h"
#import "cocos2d.h"

@implementation sprite

- (CGRect)rectInPixels
{
	CGSize s = [texture_ contentSizeInPixels];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (CGRect)rect
{
	CGSize s = [texture_ contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

+ (id)paddleWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
        
		state = kPaddleStateUngrabbed;
	}
    
	return self;
}

- (void)onEnter
{
	CCDirector *director =  [CCDirector sharedDirector];
    
	[[director touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	CCDirector *director = [CCDirector sharedDirector];
    
	[[director touchDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
	CGRect r = [self rectInPixels];
	return CGRectContainsPoint(r, p);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (state != kPaddleStateUngrabbed) return NO;
	if ( ![self containsTouchLocation:touch] ) return NO;
    
	state = kPaddleStateGrabbed;
	return YES;
    NSSet *allTouches = [event allTouches];
    UITouch * touchme = [[allTouches allObjects] objectAtIndex:0];

    CGPoint location = [touchme locationInView: [touchme view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    int arraysize = [_targets count];
    for (int i = 0; i < arraysize; i++) {
        
        if (CGRectContainsPoint( [[_targets objectAtIndex:i] boundingBox], location)) {
            CCSprite *sprite = [_targets objectAtIndex:i];
            NSLog(@"sprite tag%i", sprite.tag);
            //some code to destroy ur enemy here
            
            // determine where to spawn the target along the Y axis
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            int minX = sprite.contentSize.height/2;
            int maxX = winSize.width - sprite.contentSize.width/2;
            int rangeX = maxX - minX;
            int actualX = (arc4random() % rangeX) + minX;
            
            countBaby = countBaby + 1;
            //int actualDuration = (arc4random() % rangeDuration) + minDuration;
            NSLog(@"actualDuration%i", 1);
            // Create the actions
            id actionMove = [CCMoveTo actionWithDuration:2 position:ccp(actualX, (400+sprite.position.y))];
            id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveRestart:)];
            [sprite stopAllActions];
            NSLog(@"height%f=%f", sprite.position.y, 300+ -sprite.position.y);
            [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        }
    }
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	// If it weren't for the TouchDispatcher, you would need to keep a reference
	// to the touch from touchBegan and check that the current touch is the same
	// as that one.
	// Actually, it would be even more complicated since in the Cocos dispatcher
	// you get NSSets instead of 1 UITouch, so you'd need to loop through the set
	// in each touchXXX method.
    
	NSAssert(state == kPaddleStateGrabbed, @"Paddle - Unexpected state!");
    
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
	self.position = CGPointMake(touchPoint.x, self.position.y);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state == kPaddleStateGrabbed, @"Paddle - Unexpected state!");
    
	state = kPaddleStateUngrabbed;
}
@end
