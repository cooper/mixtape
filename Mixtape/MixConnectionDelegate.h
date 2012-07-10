//
//  MixConnectionDelegate.h
//  Mixtape
//
//  Created by Mitchell Cooper on 7/1/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/AgnesConnection
//

#import <Foundation/Foundation.h>
#import "Agnes.h"

// this class implements the AgnesConnectionDelegate protocol.
// it will receive messages related to connection-specific events.

@interface MixConnectionDelegate : NSObject <AgnesConnectionDelegate>

@end
