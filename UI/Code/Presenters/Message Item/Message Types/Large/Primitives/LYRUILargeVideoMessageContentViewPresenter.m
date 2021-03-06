//
//  LYRUILargeVIdeoMessageContentViewPresenter.m
//  Layer-XDK-UI-iOS
//
//  Created by Klemen Verdnik on 7/10/18.
//  Copyright (c) 2018 Layer. All rights reserved.
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

#import "LYRUILargeVideoMessageContentViewPresenter.h"

@implementation LYRUILargeVideoMessageContentViewPresenter

- (void)setupViewConstraints:(UIView *)view forImageSize:(CGSize)size {
    CGFloat maxHeight = LYRUIMediaItemViewMaxHeight;
    CGFloat ratio = (size.height != 0.0) ? (size.width / size.height) : LYRUIMessageItemViewImageDefaultRatio;
    [self setupViewConstraints:view];
    if (size.width != 0.0) {
        CGFloat width = (size.height > maxHeight) ? (maxHeight * ratio) : size.width;
        NSLayoutConstraint *widthConstraint = [view.widthAnchor constraintEqualToConstant:width];
        widthConstraint.priority = 501.0;
        widthConstraint.active = YES;
    }
}

@end
