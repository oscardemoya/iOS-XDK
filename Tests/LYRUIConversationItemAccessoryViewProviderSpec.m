#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>
#import <Atlas/LYRUIConversationItemAccessoryViewProvider.h>
#import <Atlas/LYRUIAvatarView.h>
#import <LayerKit/LayerKit.h>

@interface LYRUIConversationItemAccessoryViewProvider (PrivateProperties)

@property (nonatomic, strong) LYRUIParticipantsFiltering participantsFilter;

@end

SpecBegin(LYRUIConversationItemAccessoryViewProvider)

describe(@"LYRUIConversationItemAccessoryViewProvider", ^{
    __block LYRUIConversationItemAccessoryViewProvider *provider;
    __block LYRUIParticipantsFiltering participantsFilterMock;
    __block LYRConversation *conversationMock;
    __block NSArray<LYRIdentity *> *participants;
    
    beforeEach(^{
        LYRIdentity *identityMock1 = mock([LYRIdentity class]);
        LYRIdentity *identityMock2 = mock([LYRIdentity class]);
        LYRIdentity *identityMock3 = mock([LYRIdentity class]);
        participants = @[identityMock1, identityMock2, identityMock3];
        NSSet *participantsSet = [NSSet setWithArray:participants];
        
        participantsFilterMock = ^NSSet *(NSSet *identities) {
            return participantsSet;
        };
        provider = [[LYRUIConversationItemAccessoryViewProvider alloc] initWithParticipantsFilter:participantsFilterMock];
        conversationMock = mock([LYRConversation class]);
        [given(conversationMock.participants) willReturn:participantsSet];
    });
    
    afterEach(^{
        provider = nil;
        conversationMock = nil;
        participants = nil;
    });
    
    describe(@"accessoryViewForConversation:", ^{
        __block LYRUIAvatarView *returnedView;
        
        beforeEach(^{
            returnedView = (LYRUIAvatarView *)[provider accessoryViewForConversation:conversationMock];
        });
        
        it(@"should return an `LYRUIAvatarView`", ^{
            expect(returnedView).to.beAKindOf([LYRUIAvatarView class]);
        });
        it(@"should disable translating autoresizing mask into constraints", ^{
            expect(returnedView.translatesAutoresizingMaskIntoConstraints).to.beFalsy();
        });
        it(@"should setup view with identities", ^{
            assertThat(returnedView.identities, containsInAnyOrderIn(participants));
        });
    });
    
    describe(@"setupAccessoryView:forConversation:", ^{
        __block LYRUIAvatarView *view;
        
        beforeEach(^{
            view = [[LYRUIAvatarView alloc] init];
            [provider setupAccessoryView:view forConversation:conversationMock];
        });
        
        it(@"should setup view with identities", ^{
            assertThat(view.identities, containsInAnyOrderIn(participants));
        });
    });
});

SpecEnd
