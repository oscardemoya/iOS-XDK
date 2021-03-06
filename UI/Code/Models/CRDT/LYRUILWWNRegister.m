//
//  LYRUILWWNRegister.m
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 22.03.2018.
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

#import "LYRUILWWNRegister.h"

@implementation LYRUILWWNRegister

#pragma mark - Properties

- (NSString *)type {
    return @"LWWN";
}

#pragma mark - Public methods

- (NSArray<NSDictionary *> *)addOperation:(LYRUIOROperation *)operation {
    if ([self containsOperationWithID:operation.operationID]) {
        return nil;
    }
    NSMutableArray *operationDictionaries = [[NSMutableArray alloc] init];
    for (LYRUIOROperation *operation in [self.adds copy]) {
        [operationDictionaries addObjectsFromArray:[super removeOperationWithID:operation.operationID]];
    }
    [operationDictionaries addObjectsFromArray:[super addOperation:operation]];
    return operationDictionaries;
}

@end
