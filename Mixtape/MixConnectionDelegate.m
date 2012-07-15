//
//  MixConnectionDelegate.m
//  Mixtape
//
//  Created by Mitchell Cooper on 7/1/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/AgnesConnection
//

#import "MixConnectionDelegate.h"
#import "MixAppDelegate.h"
#define FEB [APP_DELEGATE feb]

// this object will be the delegate of AgnesConnections.
// this class implements the AgnesConnectionDelegate protocol.
// it will receive messages related to connection-specific events.

@implementation MixConnectionDelegate

- (void)connectionDidConnect:(AgnesConnection *)connection {
    NSLog(@"Connection established event received in Mixtape!");
}

- (void)connection:(AgnesConnection *)connection didReceiveLine:(NSString *)line {
}

- (void)connection:(AgnesConnection *)connection willChangeServerName:(NSString *)name {
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInt:connection.sid],    @"id",
        connection.serverName,                      @"oldName",
        name,                                       @"newName",
    nil];
    [FEB sendMessage:@"changeServerName" withArguments:arguments];
}

@end
