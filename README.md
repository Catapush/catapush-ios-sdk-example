![Catapush Logo](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_logo.png)

# Catapush iOS SDK Example

This project shows how quickly Catapush iOS SDK can be integrated into your current app to receive Catapush messages and display them with a customizable bubble layout. Check out the official website: [Catapush - reliable push notification service](http://www.catapush.com).

![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_screen_shot.jpg)


##Usage


1. git clone https://github.com/Catapush/catapush-ios-sdk-example.git
2. cd catapush-ios-sdk-example
3. pod install
4. open catapush-ios-sdk-example.xcworkspace
5. Get your App Key from [Catapush Dashboard](http://www.catapush.com) and insert it together with a couple of credentials of your choice into your application delegate:
```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [Catapush setAppKey:@"YOUR_APP_KEY"];

  [Catapush startWithIdentifier: @"test" andPassword:@"test"];


  [Catapush registerUserNotification:self voIPDelegate:self];

    return YES;
}

#pragma mark VoIPNotificationDelegate implementation
-(void) didReceiveIncomingPushWithPayload:(PKPushPayload *)payload {

    NSLog(@"Received VoIP notification with payload:%@",payload);

}

```
6. Run the app
7. Back to your [Catapush Dashboard](http://www.catapush.com) and send some important message.

Note:
This example allows to receive VoIP push notification. A VoIP Push Notification Certificate has to be
associated to this app.
If you set ```voIPDelegate``` to nil of the method ```registerUserNotification:self voIPDelegate:```, then Catapush Library will not call ```didReceiveIncomingPushWithPayload/1``` and will display an alert message and will play a default sound when a notification is received.

## Creating a VoIP certificate in the Apple Developer Member Center
You must also create a certificate for your VoIP app. Each VoIP app requires its own individual VoIP Services certificate, mapped to a unique App ID. This certificate allows your notification server to connect to the VoIP service. Visit the Apple Developer Member Center and create a new VoIP Services Certificate.

![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/voip_certificate_creation_2x.png)



##Advanced
Read the following documentation to enable push notification: [Catapush - Apple APNs Push Notification setup manual](http://www.catapush.com/docs-ios?__hssc=240266844.6.1447949295248&__hstc=240266844.8906dd1311d28178e3c8bdbb3bf2886a.1447404199228.1447945741012.1447949295248.9&hsCtaTracking=315ccd2b-1bb0-4020-b9f9-8b8dec529f1f|efb89882-78ec-4125-9441-59cdfd6082b2).


## UI appearance
Easily configure the UI appearance by changing TextFont, Background color attributes.

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
###Example
The following code shows how to change the appearance of the message bubbles and the navigation bar:
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
