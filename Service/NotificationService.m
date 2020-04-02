//
//  NotificationService.m
//  Service
//
//  Created by Matteo Corradin on 22/11/2019.
//  Copyright © 2019 Catapush. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNNotificationRequest *receivedRequest;
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.receivedRequest = request;
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    [super didReceiveNotificationRequest:request withContentHandler:contentHandler];
}

- (void)handleError:(NSError *) error{
    if (error.code == CatapushCredentialsError) {
        self.bestAttemptContent.body = @"User not logged in";
    }
    if (error.code == CatapushNetworkError) {
        self.bestAttemptContent.body = @"Newtork error";
    }
    if (error.code == CatapushNoMessagesError) {
        self.bestAttemptContent.body = @"No new message";
    }
    if (error.code == CatapushFileProtectionError) {
        self.bestAttemptContent.body = @"Unlock the device at least once to receive the message";
    }
    self.contentHandler(self.bestAttemptContent);
}

- (void)handleMessage:(MessageIP *) message{
    if (message != nil) {
        self.bestAttemptContent.body = message.body.copy;
    }else{
        self.bestAttemptContent.body = @"No new message";
    }
    self.contentHandler(self.bestAttemptContent);
}

@end
