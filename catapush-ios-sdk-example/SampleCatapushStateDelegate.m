//
//  SampleCatapushStateDelegate.m
//  catapush-ios-sdk-example
//
//  Created by Matteo Corradin on 03/11/2020.
//  Copyright © 2020 Catapush. All rights reserved.
//

#import "SampleCatapushStateDelegate.h"

#define LONG_DELAY  300 //5 Minutes
#define SHORT_DELAY 30 //30 seconds

@implementation SampleCatapushStateDelegate

- (void)catapushDidConnectSuccessfully:(Catapush *)catapush {
    UIAlertController * alert = [
        UIAlertController
        alertControllerWithTitle:@"Connected"
        message:@"Catapush Connected!"
        preferredStyle:UIAlertControllerStyleAlert
    ];
    UIAlertAction* okButton = [
        UIAlertAction
        actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) { }
    ];
    [alert addAction:okButton];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alert animated:false completion:nil];
}

- (void)catapush:(Catapush *)catapush didFailOperation:(NSString *)operationName withError:(NSError *)error {
    if ([error.domain isEqualToString:CATAPUSH_ERROR_DOMAIN]) {
        switch (error.code) {
            case INVALID_APP_KEY:
                /*
                 Check the app id and retry.
                 [Catapush setAppKey:@"YOUR_APP_KEY"];
                 */
                break;
            case USER_NOT_FOUND:
                /*
                 Please check if you have provided a valid username and password to Catapush via this method:
                 [Catapush setIdentifier:username andPassword:password];
                 */
                break;
            case WRONG_AUTHENTICATION:
                /*
                 Please verify your identifier and password validity. The user might have been deleted from the Catapush app (via API or from the dashboard) or the password has changed.
                 
                 You should not keep retrying, delete the stored credentials.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case GENERIC:
                /*
                 An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case XMPP_MULTIPLE_LOGIN:
                /*
                 The same user identifier has been logged on another device, the messaging service will be stopped on this device
                 Please check that you are using a unique identifier for each device, even on devices owned by the same user.
                 */
                return;
            case API_UNAUTHORIZED:
                /*
                 The credentials has been rejected    Please verify your identifier and password validity. The user might have been deleted from the Catapush app (via API or from the dashboard) or the password has changed.
                 
                 You should not keep retrying, delete the stored credentials.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case API_INTERNAL_ERROR:
                /*
                 Internal error of the remote messaging service
                 
                 An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case REGISTRATION_BAD_REQUEST:
                /*
                 Internal error of the remote messaging service    An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case REGISTRATION_FORBIDDEN_WRONG_AUTH:
                /*
                 Wrong auth    Please verify your identifier and password validity. The user might have been deleted from the Catapush app (via API or from the dashboard) or the password has changed.
                 
                 You should not keep retrying, delete the stored credentials.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case REGISTRATION_NOT_FOUND_APPLICATION:
                /*
                 Application not found
                 
                 You appplication is not found or not active.
                 You should not keep retrying.
                 */
                break;
            case REGISTRATION_NOT_FOUND_USER:
                /*
                 User not found
                 The user has been probably deleted from the Catapush app (via API or from the dashboard).
                 
                 You should not keep retrying.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case REGISTRATION_INTERNAL_ERROR:
                /*
                 Internal error of the remote messaging service    An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case OAUTH_BAD_REQUEST:
                /*
                 Internal error of the remote messaging service    An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case OAUTH_BAD_REQUEST_INVALID_CLIENT:
                /*
                 Internal error of the remote messaging service    An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case OAUTH_BAD_REQUEST_INVALID_GRANT:
                /*
                 Internal error of the remote messaging service    An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case OAUTH_INTERNAL_ERROR:
                /*
                 Internal error of the remote messaging service    An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 Please try again in a few minutes.
                 */
                return [self retry:LONG_DELAY];
            case UPDATE_PUSH_TOKEN_FORBIDDEN_WRONG_AUTH:
                /*
                 Credentials error
                 
                 Please verify your identifier and password validity. The user might have been deleted from the Catapush app (via API or from the dashboard) or the password has changed.
                 
                 You should not keep retrying, delete the stored credentials.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case UPDATE_PUSH_TOKEN_FORBIDDEN_NOT_PERMITTED:
                /*
                 Credentials error
                 
                 Please verify your identifier and password validity. The user might have been deleted from the Catapush app (via API or from the dashboard) or the password has changed.
                 
                 You should not keep retrying, delete the stored credentials.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case UPDATE_PUSH_TOKEN_NOT_FOUND_CUSTOMER:
                /*
                 Application error
                 
                 You appplication is not found or not active.
                 You should not keep retrying.
                 */
                break;
            case UPDATE_PUSH_TOKEN_NOT_FOUND_APPLICATION:
                /*
                 Application not found
                 
                 You appplication is not found or not active.
                 You should not keep retrying.
                 */
                break;
            case UPDATE_PUSH_TOKEN_NOT_FOUND_USER:
                /*
                 User not found
                 
                 Please verify your identifier and password validity. The user might have been deleted from the Catapush app (via API or from the dashboard) or the password has changed.
                 
                 You should not keep retrying, delete the stored credentials.
                 Provide a new identifier to this installation to solve the issue.
                 */
                break;
            case UPDATE_PUSH_TOKEN_INTERNAL_ERROR:
                /*
                 Internal error of the remote messaging service when updating the push token.
                 
                 Nothing, it's handled automatically by the sdk.
                 An unexpected internal error on the remote messaging service has occurred.
                 This is probably due to a temporary service disruption.
                 */
                return;
           case NETWORK_ERROR:
                /*
                 The SDK couldn’t establish a connection to the Catapush remote messaging service.
                 
                 The device is not connected to the internet or it might be blocked by a firewall or the remote messaging service might be temporarily disrupted.    Please check your internet connection and try to reconnect again.
                 */
                return [self retry:SHORT_DELAY];
            case PUSH_TOKEN_UNAVAILABLE:
                /*
                 Push token is not available.
                 
                 Nothing, it's handled automatically by the sdk.
                 */
                return;
            case INTERNAL_NETWORK_ERROR:
                /*
                 The SDK couldn’t establish a connection to the Catapush remote messaging service.
                 The device is not connected to the internet or it might be blocked by a firewall or the remote messaging service might be temporarily disrupted.
                 
                 Nothing, it's handled automatically by the sdk. Just for debug.
                 
                 You could check underlyingError to obtain the error just for debug.
                 if (error.userInfo != nil) {
                 NSError* underlyingError = error.userInfo[NSUnderlyingErrorKey];
                 }
                 */
                return;
            case UPLOAD_FILE_ERROR:
                /*
                 There was a problem while sending an attachment.
                 The device is not connected to the internet or it might be blocked by a firewall or the remote messaging service might be temporarily disrupted.
                 
                 You could check underlyingError to obtain the error just for debug.
                 if (error.userInfo != nil) {
                 NSError* underlyingError = error.userInfo[NSUnderlyingErrorKey];
                 }
                 
                 Please try to send the message again in a few minutes.
                 */
                return;
            default:
                return;
        }
    }else{
        return [self retry:SHORT_DELAY];
    }
    
    NSString *errorMsg = [NSString stringWithFormat:@"The operation %@ is failed with error:\n%@", operationName, [error localizedDescription]];
    
    UIAlertController * alert = [
        UIAlertController
        alertControllerWithTitle:@"Error"
        message:errorMsg
        preferredStyle:UIAlertControllerStyleAlert
    ];
    UIAlertAction* okButton = [
        UIAlertAction
        actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) { }
    ];
    [alert addAction:okButton];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alert animated:false completion:nil];
}

- (void)retry:(int)delayInSeconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSError *error;
        [Catapush start:&error];
        if (error != nil) {
            // API KEY, USERNAME or PASSWORD not set
        }
    });
}

@end
