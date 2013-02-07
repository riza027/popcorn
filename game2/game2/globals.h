//
//  globals.h
//  IconTest
//
//  Created by Adways Developer iMac on 2012-12-14.
//  Copyright (c) 2012 James De Vega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface globals : NSObject

{
    NSString *score;
}

@property(nonatomic,retain) NSString *score;


+(globals*)sharedObject;


@end
