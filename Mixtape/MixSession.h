//
//  MixSession.h
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FebView.h"

@interface MixSession : NSObject

@property BOOL isServer;
@property BOOL isChannel;
@property BOOL isUser;
@property (retain) FebView *febView;

@end
