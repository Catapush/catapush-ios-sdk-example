//
//  MessageCell.h
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Divisumma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UICollectionViewCell

@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *textBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

@property (nonatomic,strong) UILabel *textLabel;

-(void)setText:(NSString *)text;

@end
