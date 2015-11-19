//
//  MessageCollectionView.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 14/11/15.
//  Copyright © 2015 Divisumma. All rights reserved.
//

#import "MessageCollectionView.h"

@implementation MessageCollectionView


-(id) initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    self.bodyMesssageFont = [UIFont systemFontOfSize:14];
    
    return self;
}

@end
