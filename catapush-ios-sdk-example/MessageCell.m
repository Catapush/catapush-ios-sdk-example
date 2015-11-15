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
    UILabel *textLabel;
    
}

-(id)initWithFrame:(CGRect)frame {
    
    if (!(self = [super initWithFrame:frame])) return nil;

    textLabel = [UILabel new];
    
    textLabel.numberOfLines = 0;
    
    textLabel.font = FONT;
    
    self.layer.masksToBounds = YES;
    
    [self.contentView addSubview:textLabel];
    return self;
}

-(void) layoutSubviews {

    textLabel.frame = CGRectInset(self.bounds,TEXT_PADDING,TEXT_PADDING);
    
}

-(void) prepareForReuse {
    
    [super prepareForReuse];
    
    self.text = @"";
    
}

-(void) setText:(NSString *)text {
    
    _text = [text copy];
    
    textLabel.text = self.text;
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
    
   textLabel.textColor = textColor;
}

-(void) setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
    
}


@end
