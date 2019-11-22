//
//  MessageCell.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Catapush. All rights reserved.
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
    self.textView.editable = NO;

    // Defaults
    self.textView.layer.cornerRadius = 10;
    self.textView.layer.borderWidth= 0.5;
    self.textView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.textColor = RGB(68, 68, 68);
    self.textView.textContainerInset = UIEdgeInsetsMake(TxtInset, TxtInset, TxtInset, TxtInset);
    
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
        timeStamp.frame = CGRectMake(0, 0, self.bounds.size.width, TimestampHeight);
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
-(void) setBubbleViewCornerRadius:(CGFloat)cornerRadius {
    self.textView.layer.cornerRadius = cornerRadius;
}

-(void) setBubbleViewBorderWidth:(CGFloat)borderWidth {
    self.textView.layer.borderWidth = borderWidth;
}

-(void) setBubbleViewBorderColor:(UIColor *)borderColor {
    self.textView.layer.borderColor = borderColor.CGColor;
}

-(void) setBubbleViewColor:(UIColor *)backgroundColor {
    self.textView.backgroundColor = backgroundColor;
}

-(void) setMessageTextColor:(UIColor *)textColor {
   self.textView.textColor = textColor;
}

@end
