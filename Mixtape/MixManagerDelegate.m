//
//  MixManagerDelegate.m
//  Mixtape
//
//  Created by Mitchell Cooper on 7/8/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/AgnesManager
//

#import "MixAppDelegate.h"
#import "MixManagerDelegate.h"
#import "MixSession.h"

@implementation MixManagerDelegate

// create a new session for the server.
- (void)createConnectionSession:(AgnesManager *)manager connection:(AgnesConnection *)conn {
    MixSession *sess = [[MixSession alloc] init];
    conn.session = sess;
    sess.feb = [APP_DELEGATE feb];
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInt:conn.sid],      @"id",
        conn.address,                           @"name",
        conn.nickname,                          @"nick",
    nil];
    [sess.feb sendMessage:@"createServerTab" withArguments:args];
}

@end
