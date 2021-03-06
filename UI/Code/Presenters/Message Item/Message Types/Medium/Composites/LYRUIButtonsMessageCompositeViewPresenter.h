//
//  LYRUIButtonsMessageCompositeViewPresenter.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 13.10.2017.
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

#import "LYRUIMessageItemContentBasePresenter.h"
@protocol LYRUIMessageItemContentPresenting;

NS_ASSUME_NONNULL_BEGIN     // {
@interface LYRUIButtonsMessageCompositeViewPresenter : LYRUIMessageItemContentBasePresenter

@property (nonatomic, strong, nullable) id<LYRUIMessageItemContentPresenting> contentViewConfiguration;

- (void)setContentViewInContainer:(nullable id<LYRUIMessageViewContainer>)container forMessage:(LYRUIMessageType *)messageType;

- (CGFloat)contentViewHeightForMessageType:(LYRUIMessageType *)messageType minWidth:(CGFloat)minWidth maxWidth:(CGFloat)maxWidth;

@end
NS_ASSUME_NONNULL_END       // }
