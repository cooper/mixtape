//
//  Feb.m, FebView.m
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/Feb
//

#import "Feb.h"

@implementation Feb

- (id)initWithView:(WebView *)view
{
    self = [super init];
    if (self) {
        buffer = [[NSMutableArray alloc] init];
        webView = view;
        webView.frameLoadDelegate = self;
    }
    return self;
}

// send an event.
- (id)sendMessage:(NSString *)command withArguments:(NSDictionary *)arguments {
    NSArray *ary = [NSArray arrayWithObjects:command, arguments, nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:ary options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *args = [NSArray arrayWithObject:string];
    
    // page has loaded, so go ahead and send the event and return its return value.
    if (loadComplete) {
        id ret = [[webView windowScriptObject] callWebScriptMethod:@"FebHandleEvent" withArguments:args];
        return ret;
    }
    
    // page hasn't loaded yet, sadly. let's just save it for later and pretend it returned null.
    else {
        [buffer addObject:args];
        return nil;
    }
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    if (frame != [sender mainFrame]) return;
    loadComplete = true;
    if ([buffer count] != 0) {
        for (NSArray *args in buffer)
            [[webView windowScriptObject] callWebScriptMethod:@"FebHandleEvent" withArguments:args];
        buffer = nil;
    }
}

@end
