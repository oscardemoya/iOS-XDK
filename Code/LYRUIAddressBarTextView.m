//
//  LYRUIAddresBarView.m
//  Pods
//
//  Created by Kevin Coleman on 10/27/14.
//
//

#import "LYRUIAddressBarTextView.h"
#import "LYRUIConstants.h"
#import "LYRUIMessagingUtilities.h"

NSString *const LYRUIPlaceHolder = @"Enter Name";

@interface LYRUIAddressBarTextView ()

@property (nonatomic) UILabel *toLabel;
@property (nonatomic) NSUInteger maxHeight;

@end

@implementation LYRUIAddressBarTextView

static NSUInteger const LYRUILineSpacingConstant = 6;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setFirstLineHeadIndent:28.0f];
        [paragraphStyle setHeadIndent:0];
        [paragraphStyle setLineSpacing:LYRUILineSpacingConstant];
        self.typingAttributes = @{NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [UIColor blackColor]};
        
        self.toLabel = [[UILabel alloc] init];
        self.toLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.toLabel.text = @"To:";
        self.toLabel.textColor = LSGrayColor();
        [self.toLabel sizeToFit];
        [self addSubview:self.toLabel];
        
        [self updateConstraints];
    
    }
    return self;
}

- (void)updateConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:12]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    [self layoutSubviews];
    if (self.contentSize.height > self.maxHeight) {
        return CGSizeMake(self.contentSize.width, self.maxHeight);
    }
    return self.contentSize;
}


- (void)setAddressBarFont:(UIFont *)addressBarFont
{
    self.font = addressBarFont;
    self.toLabel.font = addressBarFont;
    [self setUpMaxHeight];
    [self invalidateIntrinsicContentSize];
    _addressBarFont = addressBarFont;
}

- (void)setUpMaxHeight
{
    CGSize size = LYRUITextPlainSize(@" ", self.font);
    if (!self.maxHeight) {
        self.maxHeight = ceil(size.height) * 2 + LYRUILineSpacingConstant + self.textContainerInset.top + self.textContainerInset.bottom;
    }
}

@end