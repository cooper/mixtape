//
//  Feb.m, FebView.m
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 Hakkin Lain and Mitchell Cooper. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/Feb
//

#import "Feb.h"

@implementation Feb

- (id)initWithView:(WebView *)view
{
    self = [super init];
    if (self) {
        currentId     = 0;
        eventHandlers = [[NSMutableDictionary alloc] init];
        loadComplete  = 0;
        buffer  = [[NSMutableArray alloc] init];
        webView = view;
        webView.frameLoadDelegate = self;
        
        // bind ObjC and inject feb.js.
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
    if (loadComplete >= 2) {
        id ret = [[[webView windowScriptObject] valueForKey:@"feb"]
                    callWebScriptMethod:@"_handleEvent" withArguments:args];
        return ret;
    }
    
    // page hasn't loaded yet, sadly. let's just save it for later and pretend it returned null.
    else {
        [buffer addObject:args];
        return nil;
    }
}

// parse an incoming JSON event.
- (void)handleMessage:(NSString *)json {
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *command = [result objectAtIndex:0];
    NSDictionary *arguments = [result objectAtIndex:1];
    [self fireEvent:command withArguments:arguments];
}

// fire event callbacks.
- (void)fireEvent:(NSString *)command withArguments:(NSDictionary *)arguments {
    NSMutableArray *events = [eventHandlers objectForKey:command];
    if (events == nil) return;

    // call each callback with arguments.
    for (NSArray *e in events)
        ((FebCallback)[e objectAtIndex:1])(arguments);
}

// add an event handler.
- (int)on:(NSString *)command do:(FebCallback)callback {
    NSMutableArray *events;
    
    // if event array does not exist, create it.
    NSMutableArray *foundEvents = [eventHandlers objectForKey:command];
    if (foundEvents)
        events = foundEvents;
    else {
        events = [[NSMutableArray alloc] init];
        [eventHandlers setObject:events forKey:command];
    }

    // register the event.
    int myId = currentId++;
    NSArray *thisEvent = [NSArray arrayWithObjects:[NSNumber numberWithInt:myId], callback, nil];
    [events addObject:thisEvent];

    return myId;
}

// delete an event handler.
- (BOOL)deleteHandler:(int)id fromEvent:(NSString *)command {
    NSMutableArray *events = [eventHandlers objectForKey:command];
    
    // no handlers for this event at all...
    if (events == nil) return FALSE;
    
    // look for an event with this id.
    for (NSArray *e in events) {
        if (![[e objectAtIndex:0] isEqualToNumber:[NSNumber numberWithInt:id]])
            continue;
        [events removeObject:e];
        return TRUE;
    }
    
    return FALSE;
}

/* ObjC */

// receive an event.
- (void)sendJSON:(NSString *)json {
    [self handleMessage:json];
}

- (void)NSLog:(NSString *)string {
    NSLog(@"feb: %@", string);
}

- (void)febLoaded {
    loadComplete++;
    [self flushIfDone];
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector {
    if (aSelector == @selector(sendJSON:) ||
        aSelector == @selector(NSLog:)    ||
        aSelector == @selector(febLoaded))
        return NO;
    return YES;
}

/* end ObjC */


/* frame load delegate */

- (void)webView:(WebView *)sender didCommitLoadForFrame:(WebFrame *)frame {
    [[sender windowScriptObject] evaluateWebScript:@"\
        document.addEventListener(\"DOMContentLoaded\", function () {\
            var script   = document.createElement('script');\
            script.type  = \"text/javascript\";\
            script.src   = \"base.js\";\
            document.head.appendChild(script);\
        });\
    "];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    if (frame != [sender mainFrame]) return;
    loadComplete++;
    [self flushIfDone];
}

/* end frame load delegate */

- (void)flushIfDone {
    if ([buffer count] == 0 || loadComplete < 2) return;
    for (NSArray *args in buffer)
        [[[webView windowScriptObject] valueForKey:@"feb"]
            callWebScriptMethod:@"_handleEvent" withArguments:args];
}

@end
