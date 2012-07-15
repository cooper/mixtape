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
- (void)manager:(AgnesManager *)manager shouldCreateSessionForConnection:(AgnesConnection *)connection {
    MixSession *sess   = [[MixSession alloc] init];
    connection.session = sess;
    sess.connection    = connection;
    sess.feb = [APP_DELEGATE feb];
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInt:connection.identifier],     @"id",
        connection.address,                                 @"name",
        connection.nickname,                                @"nick",
    nil];
    [sess.feb sendMessage:@"createServerTab" withArguments:args];
}

@end
