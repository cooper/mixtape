//
//  Feb.h, FebView.h
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//
// Documentation: https://github.com/cooper/mixtape/wiki/Feb
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface Feb : NSObject {
    WebView *webView;
    NSMutableArray *buffer;
    BOOL loadComplete;
}

- (id)initWithView:(WebView *)view;
- (id)sendMessage:(NSString *)command withArguments:(NSDictionary *)arguments;

@end
