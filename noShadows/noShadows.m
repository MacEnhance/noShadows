//
//  noShadows.m
//  noShadows
//
//  Created by Wolfgang Baird on 8/16/19.
//  Copyright © 2019 macenhance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface noShadows : NSObject
+ (noShadows*)share;
@end

@implementation noShadows

+ (noShadows*)share {
    static noShadows* plugin = nil;
    if (plugin == nil)
        plugin = [[noShadows alloc] init];
    return plugin;
}

+ (void)load {
    NSArray *globalBlacklist = [NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"blacklist" ofType:@"plist"]];
    if (![globalBlacklist containsObject:NSBundle.mainBundle.bundleIdentifier] && ![NSUserDefaults.standardUserDefaults boolForKey:@"MEMiniMeBlacklist"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (NSWindow *w in NSApp.windows)
                [w setHasShadow:false];
        });
        [[NSNotificationCenter defaultCenter] addObserver:noShadows.share
                                                 selector:@selector(noShadows_WindowDidBecomeKey:)
                                                     name:NSWindowDidBecomeKeyNotification
                                                   object:nil];
    }
    NSLog(@"%@ loaded into %@", self.className, NSProcessInfo.processInfo.operatingSystemVersionString);
}

- (void)noShadows_WindowDidBecomeKey:(NSNotification *)notification {
    NSWindow *win = [notification object];
    [win setHasShadow:false];
}

@end
