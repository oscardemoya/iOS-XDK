//
//  LYRUIImageWithLettersViewConfigurator.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 20.07.2017.
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

#import "LYRUIImageWithLettersViewConfigurator.h"
#import "LYRUIImageWithLettersView.h"
#import "LYRUIImageFetcher.h"
#import "LYRUIImageFactory.h"
#import "LYRUIInitialsFormatter.h"

@interface LYRUIImageWithLettersViewConfigurator ()

@property (nonatomic, strong) id<LYRUIImageFetching> imageFetcher;
@property (nonatomic, strong) id<LYRUIImageCreating> imageFactory;
@property (nonatomic, strong) id<LYRUIInitialsFormatting> initialsFormatter;

@end

@implementation LYRUIImageWithLettersViewConfigurator

- (instancetype)init {
    self = [self initWithImageFetcher:nil imageFactory:nil initialsFormatter:nil];
    return self;
}

- (instancetype)initWithImageFetcher:(id<LYRUIImageFetching>)imageFetcher
                        imageFactory:(id<LYRUIImageCreating>)imageFactory
                   initialsFormatter:(id<LYRUIInitialsFormatting>)initialsFormatter {
    self = [super init];
    if (self) {
        if (imageFetcher == nil) {
            imageFetcher = [[LYRUIImageFetcher alloc] init];
        }
        self.imageFetcher = imageFetcher;
        if (imageFactory == nil) {
            imageFactory = [[LYRUIImageFactory alloc] init];
        }
        self.imageFactory = imageFactory;
        if (initialsFormatter == nil) {
            initialsFormatter = [[LYRUIInitialsFormatter alloc] init];
        }
        self.initialsFormatter = initialsFormatter;
    }
    return self;
}

#pragma mark - LYRUIImageWithLettersView configuration

- (void)setupImageWithLettersView:(LYRUIImageWithLettersView *)view withIdentity:(LYRIdentity *)identity {
    NSString *initials = [self.initialsFormatter initialsForIdentity:identity];
    
    if (identity.avatarImageURL) {
        __weak __typeof(self) weakSelf = self;
        __weak __typeof(view) weakView = view;
        [view.imageFetchTask cancel];
        view.imageFetchTask = [self.imageFetcher fetchImageWithURL:identity.avatarImageURL andCallback:^(UIImage * _Nullable image) {
            if (image) {
                weakView.image = image;
                weakView.letters = nil;
            } else {
                [weakSelf setInitials:initials orPlaceholderInView:weakView];
            }
        }];
    } else {
        [self setInitials:initials orPlaceholderInView:view];
    }
}

- (void)setupImageWithLettersViewWithMultipleParticipantsIcon:(LYRUIImageWithLettersView *)view {
    view.image = [self.imageFactory imageNamed:@"MultipleParticipantsPlaceholder"];
}

#pragma mark - Helpers

- (void)setInitials:(nullable NSString *)initials orPlaceholderInView:(LYRUIImageWithLettersView *)view {
    if (initials) {
        view.image = nil;
        view.letters = initials;
    } else {
        view.image = [self.imageFactory imageNamed:@"SingleParticipantPlaceholder"];
        view.letters = nil;
    }
}

@end