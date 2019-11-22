//
//  AppDelegate.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Catapush. All rights reserved.
//

#import "AppDelegate.h"
#import "Catapush.h"
#import "MessageCell.h"
#import "MessageCollectionView.h"
#import "Constants.h"
#import "MessageNavigationBar.h"

@interface AppDelegate () <CatapushDelegate,MessagesDispatchDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Catapush setAppKey:@"YOUR_APP_KEY"];
    
    [Catapush setIdentifier:@"test" andPassword:@"test"];
    
    [Catapush setupCatapushStateDelegate:self andMessagesDispatcherDelegate:self];
    
    [Catapush registerUserNotification:self];
    
    NSError *error;
    [Catapush start:&error];
    
    if (error != nil) {
        // Handle error...
    }
    
    [self setupUI];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    return YES;
}


- (void)setupUI {
      /*
    [[MessageCell appearance] setBubbleViewCornerRadius:10];
    [[MessageCell appearance] setBubbleViewBorderColor:[UIColor colorWithWhite:0 alpha:0.2]];
    [[MessageCell appearance] setBubbleViewColor:[UIColor lightGrayColor]];
    [[MessageCell appearance] setBubbleViewBorderWidth:0.5];
    [[MessageCollectionView appearance] setBackgroundColor:[UIColor colorWithRed:249.0/255.0
                                                                           green:250.0/255.0
                                                                            blue:252.0/255.0
                                                                           alpha:1]];
    
    [[MessageCell appearance] setMessageTextColor:[UIColor whiteColor]];

    [[MessageCollectionView appearance] setMessageTextFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
    
    [[MessageNavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[MessageCell appearance] setMessageTextColor:[UIColor whiteColor]];
    [[MessageCell appearance] setBubbleViewCornerRadius:2];
    [[MessageCell appearance] setBubbleViewColor:[UIColor lightGrayColor]];
    
    NSShadow *shadow = [NSShadow new];
    shadow.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    NSDictionary *attrbutes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:245.0/255.0
                                                                               green:245.0/255.0
                                                                                blue:255.0/255.0
                                                                               alpha:1],
                                NSShadowAttributeName:shadow,
                                NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
                                };
    [[MessageNavigationBar appearance] setTitleTextAttributes: attrbutes];
     */
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [Catapush applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSError *error;
    [Catapush applicationWillEnterForeground:application withError:&error];
    if (error != nil) {
        // Handle error...
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [Catapush applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [Catapush applicationWillTerminate:application];
}

#pragma mark Standard Push Notification Delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
   // Custom code (can be empty)
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Custom code (can be empty)
}

- (void)catapushDidConnectSuccessfully:(Catapush *)catapush
{
    UIAlertView *connectedAV = [[UIAlertView alloc] initWithTitle:@"Connected"
                                                          message:@"Catapush Connected!" delegate:self
                                                cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [connectedAV show];
}

- (void)catapush:(Catapush *)catapush didFailOperation:(NSString *)operationName withError:(NSError *)error {
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

-(void)libraryDidReceiveMessageIP:(MessageIP *)messageIP {
    [MessageIP sendMessageReadNotification:messageIP];
    [[Catapush allMessages] enumerateObjectsUsingBlock:^(MessageIP *m, NSUInteger idx, BOOL * stop) {
        NSLog(@"Message: \(%@)",m.body);
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    //quando si clicca sulla notifica
    completionHandler();
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    completionHandler(UNNotificationPresentationOptionNone);
}

@end
