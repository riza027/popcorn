//
//  globals.m
//  IconTest
//
//  Created by Adways Developer iMac on 2012-12-14.
//  Copyright (c) 2012 James De Vega. All rights reserved.
//

#import "globals.h"

static globals *sharedObject = nil;

@implementation globals

@synthesize score;

+(globals*)sharedObject{
	if(sharedObject == nil)
	{
		sharedObject = [[super allocWithZone:NULL]init];
	}
	return sharedObject;
}


@end
