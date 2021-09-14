//
//  MLAppDelegate.m
//  MLLogin
//
//  Created by git on 09/08/2021.
//  Copyright (c) 2021 git. All rights reserved.
//

#import "MLAppDelegate.h"
#import <FBSDKCoreKit.h>
#import <GoogleSignIn.h>

@implementation MLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FBSDKApplicationDelegate sharedInstance] application:application
      didFinishLaunchingWithOptions:launchOptions];
    
    /// 当您的应用启动时，调用restorePreviousSignInWithCallback以尝试恢复已使用 Google 登录的用户的登录状态。这样做可确保用户不必在每次打开您的应用时都登录（除非他们已退出）。
    [GIDSignIn.sharedInstance restorePreviousSignInWithCallback:^(GIDGoogleUser * _Nullable user,
                                                                  NSError * _Nullable error) {
      if (error) {
        // Show the app's signed-out state.
      } else {
        // Show the app's signed-in state.
      }
    }];
    
//    [GIDSignIn sharedInstance].clientID = @"748197369663-mtcr8e00arei2bogdnofsoabdbsi86k2.apps.googleusercontent.com";
//    [GIDSignIn sharedInstance].delegate = self;
    
    // Override point for customization after application launch.
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    /// facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application
                                                 openURL:url
                                                 options:options];
    /// goole
    [GIDSignIn.sharedInstance handleURL:url];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
