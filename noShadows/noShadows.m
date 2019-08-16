//
//  noShadows.m
//  noShadows
//
//  Created by Wolfgang Baird on 8/16/19.
//  Copyright © 2019 macenhance. All rights reserved.
//

#import "noShadows.h"

noShadows *plugin;

@implementation noShadows

+ (noShadows*) sharedInstance {
    static noShadows* plugin = nil;
    if (plugin == nil)
        plugin = [[noShadows alloc] init];
    return plugin;
}

+ (void)load {
    NSUInteger osx_ver = [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion;
    plugin = [noShadows sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:plugin
                                             selector:@selector(noShadows_WindowDidBecomeKey:)
                                                 name:NSWindowDidBecomeKeyNotification
                                               object:nil];
    
    NSLog(@"%@ loaded into %@ on macOS 10.%ld", [self class], [[NSBundle mainBundle] bundleIdentifier], (long)osx_ver);
}

- (void)noShadows_WindowDidBecomeKey:(NSNotification *)notification {
    [plugin noShadows_initialize:[notification object]];
}

- (void)noShadows_initialize:(NSWindow*)theWindow {
    //    NSLog(@"wb_ %@", [theWindow className]);
    [theWindow setHasShadow:false];
}

@end
