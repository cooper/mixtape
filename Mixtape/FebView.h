//
//  FebView.h
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface FebView : WebView

- (void)sendMessage:(NSString *)command withArguments:(NSDictionary *)arguments;

@end
