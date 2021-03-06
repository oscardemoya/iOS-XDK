//
//  LYRUICarouselMessageCellPresenter.m
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 01.02.2018.
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

#import "LYRUICarouselMessageCellPresenter.h"
#import "LYRUICarouselMessage.h"
#import "LYRUIMessageItemView.h"
#import "LYRUIMessageType.h"
#import "LYRUICarouselMessageViewLayout.h"
#import "LYRUICarouselMessageCollectionViewCell.h"
#import "LYRUIListDataSource.h"
#import "UIView+LYRUISafeArea.h"

static CGFloat const LYRUICarouselMessageCellPresenterViewsWithMarginsWidth = 52.0;

@implementation LYRUICarouselMessageCellPresenter

- (NSSet<Class> *)handledItemTypes {
    return [NSSet setWithObject:[LYRUICarouselMessage class]];
}

- (NSString *)cellReuseIdentifier {
    return NSStringFromClass([LYRUICarouselMessageCollectionViewCell class]);
}

- (void)registerCellInCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[LYRUICarouselMessageCollectionViewCell class] forCellWithReuseIdentifier:self.cellReuseIdentifier];
}

- (CGSize)cellSizeInCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath {
    LYRUIMessageType *message = (LYRUIMessageType *)[self.listDataSource itemAtIndexPath:indexPath];
    CGFloat cellWidth = CGRectGetWidth(collectionView.bounds);
    UIEdgeInsets insets = collectionView.lyr_safeAreaInsets;
    CGFloat maxContentViewWidth = cellWidth - insets.left - LYRUICarouselMessageCellPresenterViewsWithMarginsWidth;
    CGFloat height = [self cellHeightForMessage:message contentViewWidth:maxContentViewWidth];
    return CGSizeMake(cellWidth, height);
}

- (void)setupMessageViewLayout:(LYRUIMessageItemView *)messageView
                    forMessage:(LYRUIMessageType *)message {
    LYRUICarouselMessageViewLayout *layout = [[LYRUICarouselMessageViewLayout alloc] init];
    messageView.layout = layout;
}

@end
