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
    
    [Catapush setIdentifier:@"test" andPassword:@"test"];
    
    [Catapush setupCatapushStateDelegate:self andMessagesDispatcherDelegate:self];
    
    [Catapush registerUserNotification:self voIPDelegate:nil];
    
    NSError *error;
    [Catapush start:&error];
    
    if (error != nil) {
        // Handle error...
    }
    
    [self setupUI];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    return YES;

}

#pragma mark VoIPNotificationDelegate implementation
-(void) didReceiveIncomingPushWithPayload:(PKPushPayload *)payload {
    
    NSLog(@"Received VoIP notification with payload:%@",payload);
    
}
```
6. Run the app
7. Back to your [Catapush Dashboard](http://www.catapush.com) and send a test message from "Your APP" -> Send Push.


Note: Catapush DOES register user notification for you, so DO NOT register user notification by calling instance method of ```UIApplication```.


# Prerequisites
These are pre-requisites for setting up your application with Catapush.
## Certificate, App Id, Push Entitlements and App Groups
* Make sure your app has an explicit app id and push entitlements in Apple's Developer Portal.
* Create an Apple Push Notification Authentication Key and configure your Catapush applicaton hosted on [Catapush servers](http://www.catapush.com).
* Create a specific App Group for the iOS Application and the Notification Service Extension.

### Create and configure the authentication key
This section describes how to generate an authentication key for an App ID enabled for Push Notifications. If you have an existing key, you can use that key instead of generating a new one.

To create an authentication key:
1) In your [Apple Developer Member Center](https://developer.apple.com/account), go to Certificates, Identifiers & Profiles, and select Keys.
2) Click the Add button (+) in the upper-right corner.
3) Enter a description for the APNs Auth Key.
4) Under Key Services, select the Apple Push Notifications service (APNs) checkbox, and click Continue.
5) Click Confirm and then Download. Save your key in a secure place. This is a one-time download, and the key cannot be retrieved later.

Once you have download it you have to configure your Catapush application.
1) Go to https://www.catapush.com/panel/apps/YOUR_APP_ID/platforms.
2) Click on iOS Token Based to enable it.
3) Fill iOS Team Id, iOS Key Id, iOS AuthKey and iOS Topic.

The iOS Team Id can be found here https://developer.apple.com/account/#/membership in "Membership Information" section.

The iOS Key Id can be retrieved here https://developer.apple.com/account/resources/authkeys/list, click on the key you have created and you can find it under "View Key Details" section.

The iOS AuthKey is the content of the key file.

Example:
```ruby
-----BEGIN PRIVATE KEY-----
...........................
          AUTH_KEY
...........................
-----END PRIVATE KEY-----
```

The iOS Topic is the bundle identifier of your iOS application.

![alt tag](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/images/catapush_ios_token_based.png)


### Notification Service Extension
In order to process the push notification a Notification Service Extension is required.
An example is already implemented.

### AppGroups
Catapush need that the Notification Service Extension and the main application can share resources.
In order to do that you have to create and enable a specific app group for both the application and the extension.
The app and the extansion must be in the same app group.
![alt tag](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/images/appgroup_1.png)
![alt tag](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/images/appgroup_2.png)
![alt tag](https://github.com/Catapush/catapush-ios-sdk-pod/blob/master/images/catapush_ios_token_based.png)

You should also add this information in the App plist and the Extension plist:
```ruby
    <key>Catapush</key>
    <dict>
        <key>AppGroup</key>
        <string>group.catapush.test</string>
    </dict>
```
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
