//
//  MessageCell.h
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Catapush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UICollectionViewCell

@property (nonatomic, assign) CGFloat bubbleViewCornerRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat bubbleViewBorderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *bubbleViewBorderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *bubbleViewColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UITextView *textView;

-(void)setText:(NSString *)text;
-(void) setTimestamp:(NSDate*) date;

@end
