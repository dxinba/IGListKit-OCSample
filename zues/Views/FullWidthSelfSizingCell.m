//
//  FullWidthSelfSizingCell.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "FullWidthSelfSizingCell.h"

@implementation FullWidthSelfSizingCell
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.1];
        _label.numberOfLines=0;
        _label.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _label;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label];
        
        [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:15].active=YES;
        [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:15].active=YES;
        [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeBottom multiplier:1 constant:15].active=YES;
        [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeTrailing multiplier:1 constant:15].active=YES;
    }
    return self;
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super setNeedsLayout];
    [super layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newFrame = layoutAttributes.frame;
    // 注意: 不要修改宽度
    newFrame.size.height = ceil(size.height);
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}

@end
