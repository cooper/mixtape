//
//  MixAppDelegate.h
//  Mixtape
//
//  Created by Mitchell Cooper on 6/30/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Agnes/Agnes.h>
#import "MixConnectionDelegate.h"
#import "MixManagerDelegate.h"
#import "Feb.h"
#define APP_DELEGATE (MixAppDelegate *)[[NSApplication sharedApplication] delegate]
#define FEB [APP_DELEGATE feb]

@interface MixAppDelegate : NSObject <NSApplicationDelegate> {
    MixConnectionDelegate *connDelegate;
    MixManagerDelegate *manDelegate;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *optionsWindow;
@property (assign) IBOutlet WebView *webView;
@property Feb *feb;
@property AgnesManager *clientManager;

// called from menu->main->preferences
- (IBAction)showPreferences:(id)sender;

@end
