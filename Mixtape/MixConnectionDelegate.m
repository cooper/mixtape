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

// message sent for each raw string line of data from the server
// without the suffixing carriage return and newline.
// this message is forwarded: AgnesSocket ->
// AgnesSocketDelegate(AgnesConnection) -> AgnesConnectionDelegate.
- (void)connection:(AgnesConnection *)connection didReceiveLine:(NSString *)line {
    //NSTextView *textview = [connection.session textView];
    //[[[textview textStorage] mutableString] appendString: [NSString stringWithFormat:@"%@\n", line]];
    //[textview scrollRangeToVisible:NSMakeRange(textview.string.length, 0)];
}

- (void)connection:(AgnesConnection *)connection willChangeServerName:(NSString *)name {
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInt:connection.sid], @"id", name, @"newName",
    nil];
    [FEB sendMessage:@"changeServerName" withArguments:arguments];
}

@end
