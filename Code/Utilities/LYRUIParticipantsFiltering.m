//
//  LYRUIParticipantsFiltering.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 04.08.2017.
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

#import "LYRUIParticipantsFiltering.h"
#import <LayerKit/LayerKit.h>

LYRUIParticipantsFiltering(^LYRUIParticipantsDefaultFilterWithCurrentUser)(LYRIdentity *) = ^LYRUIParticipantsFiltering(LYRIdentity *currentUser) {
    return ^NSSet<LYRIdentity *> *(NSSet<LYRIdentity *> *participants) {
        if (currentUser == nil) {
            return participants;
        }
        
        NSPredicate *notCurrentUserPredicate = [NSPredicate predicateWithBlock:^BOOL(LYRIdentity * _Nullable identity, NSDictionary<NSString *,id> * _Nullable bindings) {
            return ![identity.userID isEqual:currentUser.userID];
        }];
        return [participants filteredSetUsingPredicate:notCurrentUserPredicate];
    };
};