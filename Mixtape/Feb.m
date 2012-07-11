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
        currentId = 0;
        eventHandlers = [[NSMutableDictionary alloc] init];
        buffer  = [[NSMutableArray alloc] init];
        webView = view;
        webView.frameLoadDelegate = self;
        [[webView windowScriptObject] setValue:self forKey:@"ObjC"];
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

// add an event handler.
- (void)on:(NSString *)command do:(FebCallback)callback {
    NSMutableArray *events;
    
    // if event array does not exist, create it.
    NSMutableArray *foundEvents = [eventHandlers objectForKey:command];
    if (foundEvents)
        events = foundEvents;
    else
        events = [[NSMutableArray alloc] init];
    
    NSArray *thisEvent = [NSArray arrayWithObjects:[NSNumber numberWithInt:currentId++], callback, nil];
    [events addObject:thisEvent];
    NSLog(@"installing handler %d for %@", currentId-1, command);
}

/* ObjC */

// receive an event.
- (void)sendJSON:(NSString *)json {
    NSLog(@"got JSON: %@", json);
}

- (void)NSLog:(NSString *)string {
    NSLog(@"feb: %@", string);
}


+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector {
    if (aSelector == @selector(sendJSON:) ||
        aSelector == @selector(NSLog:))
        return NO;
    return YES;
}

/* end ObjC */

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
