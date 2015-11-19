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
    UILabel *timeStamp;
}

-(id)initWithFrame:(CGRect)frame {
    
    if (!(self = [super initWithFrame:frame])) return nil;

    self.textView = [UITextView new];
    
    self.textView.layer.masksToBounds = YES;
    
    self.textView.scrollEnabled = NO;
    
    self.textView.textContainerInset = UIEdgeInsetsMake(TEXT_CONTAINER_INSET, TEXT_CONTAINER_INSET,
                                                        TEXT_CONTAINER_INSET, TEXT_CONTAINER_INSET);
    
    self.textView.editable = NO;
    
    
    
    timeStamp = [UILabel new];
    
    timeStamp.textAlignment = NSTextAlignmentCenter;
    
    timeStamp.font = [UIFont systemFontOfSize:10];
    
    timeStamp.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:timeStamp];
    [self.contentView addSubview:self.textView];
    
    
    return self;
}

-(void) layoutSubviews {
    timeStamp.frame = CGRectZero;
    
    if (timeStamp.text) {
        
        timeStamp.frame = CGRectMake(0, 0, self.bounds.size.width, TIMESTAMP_TEXT_HEIGHT);
    }
    
    self.textView.frame = CGRectMake(0,
                                     CGRectGetHeight(timeStamp.frame),
                                     CGRectGetWidth(self.bounds),
                                     CGRectGetHeight(self.bounds) - CGRectGetHeight(timeStamp.frame));
    [self.textView becomeFirstResponder];
    
    
}

-(void) prepareForReuse {
    
    [super prepareForReuse];
    
    self.text = @"";
    
    timeStamp.text = nil;
    
}

-(void) setText:(NSString *)text {
    
    self.textView.text = [text copy];
    
}

-(void) setTimestamp:(NSDate*) date {

    NSDateFormatter *dateFormatter  = [NSDateFormatter new];
    
    [dateFormatter setDateFormat: @"MM-dd HH:mm"];
    
    timeStamp.text = [dateFormatter stringFromDate:date];

}

#pragma UI Appareance

-(void) setCornerRadius:(CGFloat)cornerRadius {
    
    self.textView.layer.cornerRadius = cornerRadius;
    
}

-(void) setTextBackgroundColor:(UIColor *)backgroundColor {
    
    self.textView.backgroundColor = backgroundColor;
    
}

-(void) setBorderWidth:(CGFloat)borderWidth {
    
    self.textView.layer.borderWidth = borderWidth;
    
}

-(void) setTextColor:(UIColor *)textColor {
    
   self.textView.textColor = textColor;
}

-(void) setBorderColor:(UIColor *)borderColor {
    
    self.textView.layer.borderColor = borderColor.CGColor;
    
}

@end
