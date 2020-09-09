//
//  NotificationService.m
//  Service
//
//  Created by Matteo Corradin on 22/11/2019.
//  Copyright © 2019 Catapush. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    [super didReceiveNotificationRequest:request withContentHandler:contentHandler];
}

- (void)handleError:(NSError * _Nonnull) error withContentHandler:(void (^_Nullable)(UNNotificationContent * _Nullable))contentHandler  withBestAttemptContent: (UNMutableNotificationContent* _Nullable) bestAttemptContent{
    if (contentHandler != nil && bestAttemptContent != nil){
        if (error.code == CatapushCredentialsError) {
            bestAttemptContent.body = @"User not logged in";
        }
        if (error.code == CatapushNetworkError) {
            bestAttemptContent.body = @"Network error";
        }
        if (error.code == CatapushNoMessagesError) {
            bestAttemptContent.body = @"No new message";
        }
        if (error.code == CatapushFileProtectionError) {
            bestAttemptContent.body = @"Unlock the device at least once to receive the message";
        }
        if (error.code == CatapushConflictErrorCode) {
            bestAttemptContent.body = @"Connected from another resource";
        }
        if (error.code == CatapushAppIsActive) {
            bestAttemptContent.body = @"Please open the app to read the message";
        }
        contentHandler(bestAttemptContent);
    }
}

- (void)handleMessage:(MessageIP * _Nullable) message withContentHandler:(void (^_Nullable)(UNNotificationContent * _Nullable))contentHandler  withBestAttemptContent: (UNMutableNotificationContent* _Nullable) bestAttemptContent{
    if (contentHandler != nil && bestAttemptContent != nil){
        if (message != nil) {
            bestAttemptContent.body = message.body.copy;
        }else{
            bestAttemptContent.body = @"No new message";
        }
        contentHandler(bestAttemptContent);
    }
}

@end
