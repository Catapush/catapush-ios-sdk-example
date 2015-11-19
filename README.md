![Catapush Logo](https://github.com/Catapush/catapush-ios-sdk-example/blob/master/catapush_logo.png)

# Catapush iOS SDK Example

This project shows how quickly Catapush iOS SDK can be integrated into your current app to receive Catapush messages and display them with a customizable bubble layout. Check out the official website:  [Catapush - reliable push notification service](http://www.catapush.com).

##Build Steps

```ruby
git clone https://github.com/Catapush/catapush-ios-sdk-example.git
cd catapush-ios-sdk-example
pod install
open catapush-ios-sdk-example.xcworkspace
```

Read following documentation to enable push notification:[Apple APNs Push Notification setup manual](http://www.catapush.com/docs-ios?__hssc=240266844.6.1447949295248&__hstc=240266844.8906dd1311d28178e3c8bdbb3bf2886a.1447404199228.1447945741012.1447949295248.9&hsCtaTracking=315ccd2b-1bb0-4020-b9f9-8b8dec529f1f|efb89882-78ec-4125-9441-59cdfd6082b2).





## UI appearance
Easily configure the UI appearance by changing TextFont, Background color attributes.

```ruby
 [[MessageCell appearance] setCornerRadius:10];
    
 [[MessageCell appearance] setTextBackgroundColor:[UIColor whiteColor]];
    
 [[MessageCell appearance] setTextColor:RGB(68,68,68)];
    
 [[MessageCell appearance] setBorderColor:[UIColor colorWithWhite:0 alpha:0.2]];
    
 [[MessageCell appearance] setBorderWidth:0.5];
    
 [[MessageCollectionView appearance] setBackgroundColor:RGB(249,250,252)];
    
 [[MessageCollectionView appearance] setBodyMesssageFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
```