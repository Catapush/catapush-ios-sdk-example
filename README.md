![Catapush Logo](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_logo.png)

# Catapush iOS SDK Example

This project shows how quickly Catapush iOS SDK can be integrated into your current app to receive Catapush messages and display them with a customizable bubble layout. For more information about Catapush platform check out the official website: [Catapush - reliable push notification service](http://www.catapush.com).

![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_screen_shot.jpg)


##Usage

1. sudo gem install cocoapods (IMPORTANT: run it also if you have already installed cocoapods)
2. git clone https://github.com/Catapush/catapush-ios-sdk-example.git
3. cd catapush-ios-sdk-example
4. pod install
5. open catapush-ios-sdk-example.xcworkspace
6. Get your App Key from [Catapush Dashboard](http://www.catapush.com) from the left menu in "Your APP" -> App details 
7. Create the first user from "Your APP" -> User
8. Insert the App Key and the user credentials into your application delegate (catapush-ios-sdk-example/catapush-ios-sdk-example/AppDelegate.m) :
```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Catapush setAppKey:@"YOUR_APP_KEY"];
    
    [Catapush startWithIdentifier: @"test" andPassword:@"test"];
    
    [Catapush setupCatapushStateDelegate:self andMessagesDispatcherDelegate:self];
    
    [Catapush registerUserNotification:self voIPDelegate:self];
    
    [self setupUI];
    return YES;
}

#pragma mark VoIPNotificationDelegate implementation
-(void) didReceiveIncomingPushWithPayload:(PKPushPayload *)payload {
    
    NSLog(@"Received VoIP notification with payload:%@",payload);
    
}
```
6. Run the app
7. Back to your [Catapush Dashboard](http://www.catapush.com) and send a test message from "Your APP" -> Send Push.


This example allows to receive VoIP push notification (PushKit framework). A VoIP Push Notification Certificate has to be associated to this app in the section "Your APP" -> Platforms. 
You can choose if you want read and show directly the push notifications or let the library to handle them, if you set ```voIPDelegate``` to ```nil``` in the method ```didFinishLaunchingWithOptions``` (```registerUserNotification:self voIPDelegate:nil```), then Catapush Library will display an alert message and will play a default sound when a notification is received. Instead if you want to completly handle them you have to implement ```didReceiveIncomingPushWithPayload/1```.

The method ```registerUserNotification/2``` requests registration for standard or Voip push notification. The library choose the right type using the capabilites settings enabled in XCode as described below.

Note: Catapush DOES register user notification for you, so *DO NOT* register user notification by calling instance method  ```registerUserNotificationSettings/1``` of ```UIApplication```.


#Prerequisites
You must enable the right capabilites in your Xcode project and create a certificate for your VoIP app. Each VoIP app requires its own individual VoIP Services certificate, mapped to a unique App ID. This certificate allows your notification server to connect to the VoIP service. Visit the [Apple Developer Member Center](https://developer.apple.com/) and create a new VoIP Services Certificate.

##Enabling Voice Over IP Push Notifications
Set the following capabilites in your XCode project:

![alt tag](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/capabilities_remote_xcode.png)

![alt tag](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/capabilities_xcode.png)


##Certificate, App Id, and Entitlements
These are pre-requisites for setting up VoIP with Catapush.
* Make sure your app has an explicit app id and push entitlements in Apple's Developer Portal.
* Create a VoIP Push Certificate. This can be re-used for development and production.

Follow this [step by step tutorial](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/CREATING_APN_CERTIFICATE.md) to generate VoIP certificate and configure your Catapush applicaton hosted on [Catapush servers](http://www.catapush.com).

## UI appearance
You can easily configure the UI appearance by changing TextFont, Background color attributes. You can find this code commented in catapush-ios-sdk-example/catapush-ios-sdk-example/AppDelegate.m

```ruby
 [[MessageCell appearance] setBubbleViewCornerRadius:10];  
 [[MessageCell appearance] setBubbleViewBorderColor:[UIColor colorWithWhite:0 alpha:0.2]];
 [[MessageCell appearance] setBubbleViewColor:[UIColor lightGrayColor]];
 [[MessageCell appearance] setBubbleViewBorderWidth:0.5];
 [[MessageCell appearance] setMessageTextColor:[UIColor whiteColor]];
 [[MessageCollectionView appearance] setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:250.0/255.0 blue:252.0/255.0 alpha:0]];
 [[MessageCollectionView appearance] setMessageTextFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
 [[MessageNavigationBar appearance] setBarTintColor:[UIColor redColor]];
 [[MessageNavigationBar appearance] setTitleTextAttributes: @{
                                            NSForegroundColorAttributeName:[UIColor greenColor],
                                            NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
                                            }];

```

```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

     // ...

    // Customize Bubble
    [[MessageCell appearance] setMessageTextColor:[UIColor whiteColor]];
    [[MessageCell appearance] setBubbleViewCornerRadius:2];
    [[MessageCell appearance] setBubbleViewColor:[UIColor lightGrayColor]];

    // Customize Navigation Bar - Add Shadow to Navigation Bar Title
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
    [[MessageNavigationBar appearance] setBarTintColor:[UIColor redColor]];



}
```
![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_screen_shot_custom_red.jpg)


##Clipboard
Use Long tap to copy a text into clipboard.

![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_screen_shot_clipboard.jpg)
