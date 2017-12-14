//
//  LYRUIConfiguration.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 14.12.2017.
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

#import "LYRUIConfiguration.h"
#import "LYRUIConfiguration+DependencyInjection.h"

@interface LYRUIConfiguration ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, LYRUIDependencyProviding> *themes;
@property (nonatomic, strong) NSMutableDictionary<NSString *, LYRUIDependencyProviding> *configurations;

@end

@implementation LYRUIConfiguration

- (instancetype)init {
    self = [self init];
    return self;
}

- (instancetype)initWithLayerClient:(LYRClient *)client {
    self = [super init];
    if (self) {
        self.client = client;
        self.participantsSorter = LYRUIParticipantsDefaultSorter();
        self.themes = [[NSMutableDictionary alloc] init];
        self.configurations = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setClient:(LYRClient *)client {
    _client = client;
    if (self.participantsFilter == nil && client.authenticatedUser != nil) {
        self.participantsFilter = LYRUIParticipantsDefaultFilterWithCurrentUser(client.authenticatedUser);
    }
}

#pragma mark - LYRUIDependencyInjection

- (id)themeForViewClass:(Class)viewClass {
    LYRUIDependencyProviding provider = self.themes[NSStringFromClass(viewClass)];
    return provider(self);
}

- (id)configurationForViewClass:(Class)viewClass {
    LYRUIDependencyProviding provider = self.configurations[NSStringFromClass(viewClass)];
    return provider(self);
}

@end
