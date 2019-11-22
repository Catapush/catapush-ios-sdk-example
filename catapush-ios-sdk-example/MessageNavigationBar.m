//
//  MessageNavigationBar.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 20/11/15.
//  Copyright © 2015 Catapush. All rights reserved.
//

#import "MessageNavigationBar.h"
#import "Constants.h"
@implementation MessageNavigationBar


-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [super setBarTintColor: RGB(0,144,213)];
    [super setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(245,245,255.0)}];
    return self;
}


@end
