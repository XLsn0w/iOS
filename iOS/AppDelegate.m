//
//  AppDelegate.m
//  iOS
//
//  Created by i on 2020/10/12.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:(UIScreen.mainScreen.bounds)];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [ViewController new];
    return YES;
}

@end
