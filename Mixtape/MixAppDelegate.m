//
//  MixAppDelegate.m
//  Mixtape
//
//  Created by Mitchell Cooper on 6/30/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//

#import "MixAppDelegate.h"

@implementation MixAppDelegate

@synthesize clientManager, window, optionsWindow, webView, febView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSBundle loadNibNamed:@"MainWindow" owner:self];
    // Insert code here to initialize your application
    
    // create delegates and manager.
    connDelegate  = [[MixConnectionDelegate alloc] init];
    manDelegate   = [[MixManagerDelegate alloc] init];
    clientManager = [[AgnesManager alloc] initWithDelegate:manDelegate];
    clientManager.connectionDelegate = connDelegate;
    clientManager.defaultReal = NSFullUserName();
    clientManager.defaultNick = [[clientManager.defaultReal componentsSeparatedByString:@" "] objectAtIndex:0];
    clientManager.defaultUser = [clientManager.defaultNick lowercaseString];

    AgnesConnection *conn = [clientManager createConnection:@"irc.mac-mini.org" port:6697 ssl:true];
    [conn connect];
    
    febView = [[FebView alloc] initWithView:webView];
    NSString *path = [NSString stringWithFormat:@"file://%@/index.html", [[NSBundle mainBundle] resourcePath]];
    [[webView mainFrame] loadRequest: [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]];
}



// handler for menu item click.
// loads preferences nib.
- (IBAction)showPreferences:(id)sender {
    
    // window exists; bring to font.
    if (optionsWindow)
        [optionsWindow orderFront:self];
    
    // does not exist; load the nib.
    else 
        [NSBundle loadNibNamed:@"Options" owner:self];
    
    [optionsWindow center];
}

- (BOOL)windowShouldClose:(id)sender {
    [window orderBack:self];
    return false;
}

@end
