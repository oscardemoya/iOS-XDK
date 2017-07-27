#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>
#import <Atlas/LYRUIBaseListView.h>
#import <Atlas/LYRUIListLayout.h>
#import <Atlas/LYRUIListDataSource.h>
#import <Atlas/LYRUIListDelegate.h>
#import <Atlas/LYRUIParticipantsFiltering.h>

SpecBegin(LYRUIBaseListView)

describe(@"LYRUIBaseListView", ^{
    __block LYRUIBaseListView *listView;
    __block UICollectionViewLayout<LYRUIListViewLayout> *layoutMock;
    __block id<LYRUIListDelegate> delegateMock;
    __block id<LYRUIListDataSource> dataSourceMock;
    
    beforeEach(^{
        listView = [[LYRUIBaseListView alloc] init];
        
        LYRUIListLayout *layout = [[LYRUIListLayout alloc] init];
        layoutMock = OCMPartialMock(layout);
        [[OCMStub([layoutMock copyWithZone:NSDefaultMallocZone()]) andReturn:layoutMock] ignoringNonObjectArgs];
        delegateMock = mockProtocol(@protocol(LYRUIListDelegate));
        dataSourceMock = mockProtocol(@protocol(LYRUIListDataSource));
    });
    
    afterEach(^{
        listView = nil;
    });
    
    describe(@"after initialization", ^{
        it(@"should have the collection view set", ^{
            expect(listView.collectionView).notTo.beNil();
        });
        it(@"should have the collection view added as subview", ^{
            expect(listView.collectionView.superview).to.equal(listView);
        });
    });
    
    describe(@"items", ^{
        __block NSMutableArray *arrayMock;
        
        beforeEach(^{
            listView.dataSource = dataSourceMock;
        });
        
        context(@"getter", ^{
            beforeEach(^{
                arrayMock = mock([NSMutableArray class]);
                [given(dataSourceMock.sections) willReturn:arrayMock];
            });
            
            it(@"should return data source sections array", ^{
                expect(listView.items).to.equal(arrayMock);
            });
        });
        
        context(@"setter", ^{
            beforeEach(^{
                arrayMock = mock([NSMutableArray class]);
                listView.items = arrayMock;
            });
            
            it(@"should update data source sections array with mutable copy of passed array", ^{
                [verify(dataSourceMock) setSections:arrayMock];
            });
        });
    });
    
    describe(@"layout", ^{
        context(@"setter", ^{
            beforeEach(^{
                listView.layout = layoutMock;
            });
            
            it(@"should set collection view's layout", ^{
                expect(listView.collectionView.collectionViewLayout).to.equal(layoutMock);
            });
            it(@"should install constraints", ^{
                OCMVerify([layoutMock addConstraintsInView:listView]);
            });
        });
    });
    
    describe(@"delegate", ^{
        context(@"setter", ^{
            beforeEach(^{
                listView.delegate = delegateMock;
            });
            
            it(@"should set collection view's delegate", ^{
                expect(listView.collectionView.delegate).to.equal(delegateMock);
            });
            it(@"should setup delegates `indexPathSelected` block", ^{
                [verify(delegateMock) setIndexPathSelected:anything()];
            });
        });
    });
    
    describe(@"dataSource", ^{
        context(@"setter", ^{
            beforeEach(^{
                listView.dataSource = dataSourceMock;
            });
            
            it(@"should set collection view's dataSource", ^{
                expect(listView.collectionView.dataSource).to.equal(dataSourceMock);
            });
        });
    });
    
    describe(@"itemSelected", ^{
        __block NSObject *itemMock;
        __block BOOL itemSelectedCalled;
        __block NSObject *capturedItem;
        
        beforeEach(^{
            itemMock = mock([NSObject class]);
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:2];
            [given([dataSourceMock itemAtIndexPath:indexPath]) willReturn:itemMock];
            listView.dataSource = dataSourceMock;
            
            itemSelectedCalled = NO;
            listView.itemSelected = ^(NSObject *item) {
                itemSelectedCalled = YES;
                capturedItem = item;
            };
        });
        
        context(@"when delegate's index path selection callback is called", ^{
            beforeEach(^{
                listView.delegate = delegateMock;
                HCArgumentCaptor *indexPathSelectedArgument = [HCArgumentCaptor new];
                [verify(delegateMock) setIndexPathSelected:(id)indexPathSelectedArgument];
                void(^indexPathSelected)(NSIndexPath *) = indexPathSelectedArgument.value;
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:2];
                indexPathSelected(indexPath);
            });
            
            it(@"should call item selected callback", ^{
                expect(itemSelectedCalled).to.beTruthy();
            });
            it(@"should call item selected callback with item at provided index path, taken from data source", ^{
                expect(capturedItem).to.equal(itemMock);
            });
        });
    });
    
    describe(@"selectedItems", ^{
        __block NSArray *returnedItems;
        __block NSArray *selectedItems;
        
        beforeEach(^{
            listView.dataSource = dataSourceMock;
            selectedItems = @[
                              mock([NSObject class]),
                              mock([NSObject class]),
                              mock([NSObject class]),
                              ];
            [given([dataSourceMock selectedItemsInCollectionView:listView.collectionView]) willReturn:selectedItems];
            
            returnedItems = listView.selectedItems;
        });
        
        it(@"should return selected items for view's collection view, returned from data source", ^{
            expect(returnedItems).to.equal(selectedItems);
        });
    });
    
    describe(@"participantsFilter", ^{
        context(@"setter", ^{
            __block LYRUIParticipantsFiltering participantsFilterBlock;
            __block id configuratorMock1;
            
            beforeEach(^{
                participantsFilterBlock = ^ NSSet *(NSSet *participants) {
                    return participants;
                };
                
                configuratorMock1 = mockProtocol(@protocol(LYRUIParticipantsFiltering));
                id configuratorMock2 = mock([NSObject class]);
                LYRUIListDataSource *dataSourceMock = mock([LYRUIListDataSource class]);
                [given(dataSourceMock.allConfigurations) willReturn:@[configuratorMock1, configuratorMock2]];
                listView.dataSource = dataSourceMock;
                
                listView.participantsFilter = participantsFilterBlock;
            });
            
            it(@"should update configurator's participant filtering block", ^{
                [verify(configuratorMock1) setParticipantsFilter:participantsFilterBlock];
            });
        });
    });
});

SpecEnd
