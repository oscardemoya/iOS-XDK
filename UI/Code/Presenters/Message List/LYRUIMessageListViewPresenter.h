//
//  LYRUIMessageListViewPresenter.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 18.08.2017.
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

#import <Foundation/Foundation.h>
#import "LYRUIConfigurable.h"
#import "LYRUIListViewPresenting.h"

/**
 @abstract The `LYRUIMessageListViewPresenter` objects will be used for presenting a `LYRUIMessageListView` with proper layout, data source, and delegate for presenting list of `LYRIdentity` items.
 */
@interface LYRUIMessageListViewPresenter : NSObject <LYRUIListViewPresenting, LYRUIConfigurable>

- (Class)delegateClass;
- (Class)cellPresenterClass;

@end
