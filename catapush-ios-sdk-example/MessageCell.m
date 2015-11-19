//
//  MessageCell.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Divisumma. All rights reserved.
//

#import "MessageCell.h"
#import "Constants.h"


@implementation MessageCell {
    
}

-(id)initWithFrame:(CGRect)frame {
    
    if (!(self = [super initWithFrame:frame])) return nil;

    self.textLabel = [UILabel new];
    
    self.textLabel.numberOfLines = 0;
    
    self.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.textLabel];
    
    return self;
}

-(void) layoutSubviews {

    self.textLabel.frame = CGRectInset(self.bounds,TEXT_PADDING,TEXT_PADDING);
    
}

-(void) prepareForReuse {
    
    [super prepareForReuse];
    
    self.text = @"";
    
}

-(void) setText:(NSString *)text {
    
    self.textLabel.text = [text copy];
    
}


#pragma UI Appareance

-(void) setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    
}

-(void) setTextBackgroundColor:(UIColor *)backgroundColor {
    
    self.backgroundColor = backgroundColor;
    
}

-(void) setBorderWidth:(CGFloat)borderWidth {
    
    self.layer.borderWidth = borderWidth;
    
}

-(void) setTextColor:(UIColor *)textColor {
    
   self.textLabel.textColor = textColor;
}

-(void) setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
    
}


@end
