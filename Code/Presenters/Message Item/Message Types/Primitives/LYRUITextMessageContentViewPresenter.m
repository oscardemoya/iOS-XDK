//
//  LYRUITextMessageContentViewPresenter.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 02.09.2017.
//  Copyright (c) 2017 Layer. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "LYRUITextMessageContentViewPresenter.h"
#import "LYRUITextMessageContentView.h"
#import "LYRUIMessageItemView.h"
#import <LayerKit/LayerKit.h>
#import "LYRUITextMessage.h"
#import "LYRUIMessageViewContainer.h"
#import "LYRUIReusableViewsQueue.h"

static CGFloat const LYRUITextMessageContentViewVerticalPadding = 17.0;

@interface LYRUITextMessageContentViewPresenter ()

@property (nonatomic, strong) LYRUITextMessageContentView *sizingTextMessageView;

@end

@implementation LYRUITextMessageContentViewPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sizingTextMessageView = [[LYRUITextMessageContentView alloc] init];
    }
    return self;
}

- (instancetype)initWithConfiguration:(LYRUIConfiguration *)configuration {
    self = [self init];
    if (self) {
        self.layerConfiguration = configuration;
    }
    return self;
}

- (UIView *)viewForMessage:(LYRUITextMessage *)message {
    LYRUITextMessageContentView *textMessageView = [self.reusableViewsQueue dequeueReusableViewOfType:[LYRUITextMessageContentView class]];
    if (textMessageView == nil) {
        textMessageView = [[LYRUITextMessageContentView alloc] init];
    }
    [self setupTextView:textMessageView.textView forMessage:message];
    return textMessageView;
}

- (UIColor *)backgroundColorForMessage:(LYRUITextMessage *)message {
    BOOL outgoingMessage = [self isMessageOutgoing:message];
    if (outgoingMessage && message.metadata == nil) {
        return [UIColor colorWithRed:16.0/255.0 green:148.0/255.0 blue:208.0/255.0 alpha:1.0];
    }
    return [super backgroundColorForMessage:message];
}

- (void)setupTextView:(UITextView *)textView forMessage:(LYRUITextMessage *)message {
    textView.text = message.text;
    
    BOOL outgoingMessage = [self isMessageOutgoing:message];
    if (message.parentMessage == nil && outgoingMessage && message.metadata == nil) {
        textView.textColor = [UIColor whiteColor];
    } else {
        textView.textColor = [UIColor blackColor];
    }
}

- (BOOL)isMessageOutgoing:(LYRUITextMessage *)message {
    return [message.sender.userID isEqualToString:self.layerConfiguration.client.authenticatedUser.userID];
}

- (CGFloat)viewHeightForMessage:(LYRUITextMessage *)message minWidth:(CGFloat)minWidth maxWidth:(CGFloat)maxWidth {
    UITextView *textView = self.sizingTextMessageView.textView;
    [self setupTextView:textView forMessage:message];
    CGFloat textInsets = textView.textContainerInset.left + textView.textContainerInset.right + textView.textContainer.lineFragmentPadding;
    CGFloat textWidth = maxWidth - textInsets;
    CGRect stringRect = [textView.text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX)
                                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                 attributes:textView.typingAttributes
                                                    context:nil];
    CGFloat textViewHeight = ceil(stringRect.size.height);
    return textViewHeight + LYRUITextMessageContentViewVerticalPadding;
}

@end