//
//  FebView.m
//  Mixtape
//
//  Created by Mitchell Cooper on 7/10/12.
//  Copyright (c) 2012 mac-mini.org. All rights reserved.
//

#import "FebView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation FebView

- (void)sendMessage:(NSString *)command withArguments:(NSDictionary *)arguments {
    NSArray *ary = [NSArray arrayWithObjects:command, arguments, nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:ary options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"file://%@/index.html", [[NSBundle mainBundle] resourcePath]];
    [[self mainFrame] loadRequest: [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]];
}

@end
