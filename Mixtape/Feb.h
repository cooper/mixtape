//
//  Feb.h, FebView.h
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 Hakkin Lain and Mitchell Cooper. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/Feb
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef void (^FebCallback)(NSDictionary *arguments);

@interface Feb : NSObject {
    WebView *webView;
    NSMutableArray *buffer;
    NSMutableDictionary *eventHandlers;
    int loadComplete;
    int currentId;
}

- (id)initWithView:(WebView *)view;
- (id)sendMessage:(NSString *)command withArguments:(NSDictionary *)arguments;
- (int)on:(NSString *)command do:(FebCallback)callback;
- (BOOL)deleteHandler:(int)id fromEvent:(NSString *)command;

@end
