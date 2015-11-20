![Catapush Logo](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_logo.png)

# Catapush iOS SDK Example

This project shows how quickly Catapush iOS SDK can be integrated into your current app to receive Catapush messages and display them with a customizable bubble layout. Check out the official website: [Catapush - reliable push notification service](http://www.catapush.com).

![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_screen_shot.jpg)


##Usage


1. git clone https://github.com/Catapush/catapush-ios-sdk-example.git
2. cd catapush-ios-sdk-example
3. pod install
4. open catapush-ios-sdk-example.xcworkspace
5. Get your App Key from [Catapush Dashboard](http://www.catapush.com) and insert it together with a couple of credentials of your choice into your application delegate application:didFinishLaunchingWithOption:
```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Catapush setAppKey:@"YOUR_APP_KEY"];
    [Catapush startWithIdentifier: @"test" andPassword:@"test"];
    return YES;
}
```
6. Run the app
7. Back to your [Catapush Dashboard](http://www.catapush.com) and send some important message.


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
    
 [[MessageCollectionView appearance] setBackgroundColor:RGB(249,250,252)];
    
 [[MessageCollectionView appearance] setMessageTextFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
    
 [[MessageNavigationBar appearance] setBarTintColor:[UIColor redColor]];

 [[MessageNavigationBar appearance] setTitleTextAttributes: @{
                                            NSForegroundColorAttributeName:[UIColor greenColor],
                                            NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
                                            }];
    
```
###Example
Let's change the appearance of the  ```UINavigationBar``` with the following code:
```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

...

  [[MessageCell appearance] setBubbleViewCornerRadius:10];
  [[MessageCell appearance] setBubbleViewBorderColor:[UIColor colorWithWhite:0 alpha:0.2]];
  [[MessageCell appearance] setBubbleViewColor:[UIColor lightGrayColor]];
  [[MessageCell appearance] setBubbleViewBorderWidth:0.5];
  [[MessageCell appearance] setMessageTextColor:[UIColor whiteColor]];
  [[MessageCollectionView appearance] setBackgroundColor:[UIColor colorWithRed:249.0/255.0
                                                                           green:250.0/255.0
                                                                            blue:252.0/255.0
                                                                           alpha:0]];
    
  [[MessageCollectionView appearance] setMessageTextFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
  [[MessageNavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
  NSShadow *shadow = [NSShadow new];
  shadow.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
  shadow.shadowOffset = CGSizeMake(0, 1);
  NSDictionary *attrbutes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:245.0/255.0
                                                                             green:245.0/255.0
                                                                              blue:255.0/255.0
                                                                             alpha:0],
                              NSShadowAttributeName:shadow,
                              NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
                              };
  [[MessageNavigationBar appearance] setTitleTextAttributes: attrbutes];

}
```
![alt tag](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_screen_shot_custom.jpg)




