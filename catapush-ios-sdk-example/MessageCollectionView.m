//
//  MessageCollectionView.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 14/11/15.
//  Copyright © 2015 Divisumma. All rights reserved.
//

#import "MessageCollectionView.h"
#import "Constants.h"
@implementation MessageCollectionView

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.messageTextFont = [UIFont systemFontOfSize:16];
    self.backgroundColor = RGB(249,250,252);
    return self;
}

@end
