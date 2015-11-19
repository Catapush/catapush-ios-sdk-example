//
//  AppDelegate.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Divisumma. All rights reserved.
//

#import "AppDelegate.h"
#import "CatapushHeaders.h"
#import "MessageCell.h"
#import "MessageCollectionView.h"
#import "Constants.h"

@interface AppDelegate () <CatapushDelegate,MessagesDispatchDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Catapush setAppKey:@"1936ff755bc74f186c9ed888d573fcc9"];
    
    [Catapush startWithIdentifier: @"test" andPassword:@"test"];
    
    [Catapush setupCatapushStateDelegate:self andMessagesDispatcherDelegate:self];
    
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
        
    } else
    {
        
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        
    }
    
    application.applicationIconBadgeNumber = 0;
    
    if ([remoteNotification[@"sender"] isEqualToString:@"catapush"]) {
        // Wake up, it's Catapush!
    }

    [self setupUI];
    
    return YES;
}

- (void)setupUI {
    
    [[MessageCell appearance] setCornerRadius:10];
    
    [[MessageCell appearance] setTextBackgroundColor:[UIColor whiteColor]];
    
    [[MessageCell appearance] setTextColor:RGB(68,68,68)];
    
    [[MessageCell appearance] setBorderColor:[UIColor colorWithWhite:0 alpha:0.2]];
    
    [[MessageCell appearance] setBorderWidth:0.5];
    
    [[MessageCollectionView appearance] setBackgroundColor:RGB(249,250,252)];
    
    [[MessageCollectionView appearance] setBodyMesssageFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [Catapush applicationDidEnterBackground:application];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [Catapush applicationWillEnterForeground:application];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    [Catapush registerForRemoteNotificationsWithDeviceToken:deviceToken];

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail Register Notification: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [CatapushRemoteNotifications application:application
                didReceiveRemoteNotification:userInfo
                      fetchCompletionHandler:completionHandler];
}

- (void)catapushDidConnectSuccessfully:(Catapush *)catapush
{
    UIAlertView *connectedAV = [[UIAlertView alloc] initWithTitle:@"Connected"
                                                          message:@"Catapush Connected!" delegate:self
                                                cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [connectedAV show];
}

- (void)catapush:(Catapush *)catapush didFailOperation:(NSString *)operationName withError:(NSError *)error
{
    
    if ([error.domain isEqualToString:CATAPUSH_ERROR_DOMAIN]) {
        
        switch (error.code) {
            case WRONG_AUTHENTICATION:
                break;
            case INVALID_APP_KEY:
                break;
            case USER_NOT_FOUND:
                break;
            case GENERIC:
                break;
            default:
                break;
        }
        
    }
    
    NSString *errorMsg = [NSString stringWithFormat:@"The operation %@ is failed with error:\n%@", operationName, [error localizedDescription]];
    
    UIAlertView *flowErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:errorMsg
                                                                delegate:self
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
    [flowErrorAlertView show];
    
}

-(void)libraryDidReceiveMessageIP:(MessageIP *)messageIP
{
    NSLog(@"Did receive IP Message with identifier: %@ and body: %@", messageIP.identifier, messageIP.body);
    
    [MessageIP sendMessageReadNotification:messageIP];
    [[Catapush allMessages] enumerateObjectsUsingBlock:^(MessageIP *m, NSUInteger idx, BOOL * stop) {
        NSLog(@"MESSAGE: \(%@)",m.body);
    }];
}

@end
